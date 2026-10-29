// A small static server for the Flutter web build. No dependencies; needs Node 18 or newer.
//
//   node tool/serve.mjs [port] [folder]        defaults: 8080 build/web
//
// What a host has to do for this site, and what this does:
//  * answer any path that is not a file with index.html (the site uses path URLs such as /pos);
//  * serve Flutter's files with `Cache-Control: no-cache` plus an ETag, because their names do not change
//    between builds and a rebuilt site must not be hidden by an old copy;
//  * compress text, fonts and wasm with brotli or gzip (main.dart.js is 4 MB raw, under 1 MB compressed);
//  * answer Range requests, which browsers send for large media.
import fs from 'node:fs';
import http from 'node:http';
import path from 'node:path';
import { promisify } from 'node:util';
import zlib from 'node:zlib';

const port = Number(process.argv[2] ?? 8080);
const root = path.resolve(process.argv[3] ?? 'build/web');
if (!fs.existsSync(path.join(root, 'index.html'))) {
  console.error(`No index.html in ${root}. Build first: flutter build web --release`);
  process.exit(1);
}

const TYPES = {
  '.html': 'text/html; charset=utf-8',
  '.js': 'text/javascript; charset=utf-8',
  '.mjs': 'text/javascript; charset=utf-8',
  '.json': 'application/json; charset=utf-8',
  '.css': 'text/css; charset=utf-8',
  '.svg': 'image/svg+xml',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.webp': 'image/webp',
  '.ico': 'image/x-icon',
  '.wasm': 'application/wasm',
  '.ttf': 'font/ttf',
  '.otf': 'font/otf',
  '.woff2': 'font/woff2',
  '.mp4': 'video/mp4',
  '.webm': 'video/webm',
  '.map': 'application/json',
  '.symbols': 'text/plain; charset=utf-8',
  '': 'text/plain; charset=utf-8', // e.g. assets/NOTICES
};
const COMPRESSIBLE = new Set(['.html', '.js', '.mjs', '.json', '.css', '.svg', '.wasm', '.ttf', '.otf', '.map', '.symbols', '']);

const brotli = promisify(zlib.brotliCompress);
const gzip = promisify(zlib.gzip);
const packed = new Map(); // `${file}|${mtime}|${encoding}` -> Promise<Buffer>

function pack(file, stat, encoding) {
  const key = `${file}|${stat.mtimeMs}|${encoding}`;
  if (!packed.has(key)) {
    const bytes = fs.readFileSync(file);
    packed.set(
      key,
      encoding === 'br' ? brotli(bytes, { params: { [zlib.constants.BROTLI_PARAM_QUALITY]: 6, [zlib.constants.BROTLI_PARAM_SIZE_HINT]: bytes.length } }) : gzip(bytes, { level: 9 }),
    );
  }
  return packed.get(key);
}

function resolveFile(urlPath) {
  const clean = path.normalize(decodeURIComponent(urlPath)).replace(/^([/\\])+/, '');
  const file = path.join(root, clean);
  if (!file.startsWith(root)) return null; // never leave the folder
  if (fs.existsSync(file) && fs.statSync(file).isFile()) return file;
  if (fs.existsSync(file) && fs.statSync(file).isDirectory() && fs.existsSync(path.join(file, 'index.html'))) return path.join(file, 'index.html');
  // a page address, not a file: the app routes it
  return path.extname(clean) === '' ? path.join(root, 'index.html') : null;
}

http
  .createServer(async (req, res) => {
    try {
      const url = new URL(req.url ?? '/', 'http://localhost');
      const file = resolveFile(url.pathname);
      if (!file) {
        res.writeHead(404, { 'Content-Type': 'text/plain' }).end('Not found');
        return;
      }
      const stat = fs.statSync(file);
      const ext = path.extname(file).toLowerCase();
      const etag = `W/"${stat.size}-${Math.round(stat.mtimeMs)}"`;
      const headers = {
        'Content-Type': TYPES[ext] ?? 'application/octet-stream',
        'Cache-Control': 'no-cache',
        ETag: etag,
        'X-Content-Type-Options': 'nosniff',
        Vary: 'Accept-Encoding',
        'Accept-Ranges': 'bytes',
        // Lets the WebAssembly build draw on several threads (`flutter build web --wasm`).
        'Cross-Origin-Opener-Policy': 'same-origin',
        'Cross-Origin-Embedder-Policy': 'credentialless',
      };
      if (req.headers['if-none-match'] === etag) {
        res.writeHead(304, headers).end();
        return;
      }

      const range = /^bytes=(\d*)-(\d*)$/.exec(req.headers.range ?? '');
      if (range && req.method === 'GET') {
        const start = range[1] === '' ? Math.max(0, stat.size - Number(range[2])) : Number(range[1]);
        const end = range[1] === '' || range[2] === '' ? stat.size - 1 : Math.min(Number(range[2]), stat.size - 1);
        if (start > end || start >= stat.size) {
          res.writeHead(416, { 'Content-Range': `bytes */${stat.size}` }).end();
          return;
        }
        res.writeHead(206, { ...headers, 'Content-Range': `bytes ${start}-${end}/${stat.size}`, 'Content-Length': end - start + 1 });
        fs.createReadStream(file, { start, end }).pipe(res);
        return;
      }

      const accepts = String(req.headers['accept-encoding'] ?? '');
      const encoding = COMPRESSIBLE.has(ext) && stat.size > 1024 ? (accepts.includes('br') ? 'br' : accepts.includes('gzip') ? 'gzip' : null) : null;
      if (encoding) {
        const body = await pack(file, stat, encoding);
        res.writeHead(200, { ...headers, 'Content-Encoding': encoding, 'Content-Length': body.length });
        res.end(req.method === 'HEAD' ? undefined : body);
        return;
      }
      res.writeHead(200, { ...headers, 'Content-Length': stat.size });
      if (req.method === 'HEAD') res.end();
      else fs.createReadStream(file).pipe(res);
    } catch (e) {
      res.writeHead(500, { 'Content-Type': 'text/plain' }).end(String(e));
    }
  })
  .listen(port, () => console.log(`Serving ${root} at http://localhost:${port}`));
