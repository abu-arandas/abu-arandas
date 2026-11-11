// Renders the vertical reels frame by frame in Chromium, then adds the music.
//   node render.js <screenshots dir> <out dir> [reel ids...] [--lang ar|en] [--still]
// The screenshots dir holds desktop/ and phone/ from the ERP repo's build/tutorial (flutter test test/tutorial/record_tutorial.dart).
const { chromium } = require('playwright');
const { spawn, execFileSync } = require('child_process');
const fs = require('fs'), path = require('path');
const args = process.argv.slice(2);
const flag = (n) => { const i = args.indexOf(n); if (i < 0) return null; const v = args[i + 1]; args.splice(i, 2); return v; };
const still = args.includes('--still'); if (still) args.splice(args.indexOf('--still'), 1);
const langs = (flag('--lang') || 'ar,en').split(',');
const [shots, out, ...ids] = args;
const all = JSON.parse(fs.readFileSync(path.join(__dirname, 'reels.json'), 'utf8'));
const FPS = 30, HOOK = 2.6, SHOT = 3.3, END = 3.4;

function scenes(r, lang) {
  const c = r[lang];
  return [{ type: 'hook', d: HOOK, lines: c.hook },
    ...c.shots.map(([img, title, sub, chips], i) => ({ type: 'shot', d: SHOT, img, title, sub, chips, phone: img.startsWith('phone/'), pan: img.startsWith('phone/') ? r.pans[i] : r.pans[i].map(([x, y, z]) => [x, y, z * 1.2]) })),
    { type: 'end', d: END, title: c.end[0], sub: c.end[1] }];
}

(async () => {
  fs.mkdirSync(out, { recursive: true });
  const browser = await chromium.launch();
  for (const id of ids.length ? ids : Object.keys(all)) for (const lang of langs) {
    const page = await browser.newPage({ viewport: { width: 1080, height: 1920 } });
    await page.goto('file://' + path.join(__dirname, 'reel.html'));
    const sc = scenes(all[id], lang);
    const total = await page.evaluate(([s, l, b]) => window.setup({ lang: l, scenes: s }, b), [sc, lang, 'file://' + path.resolve(shots) + '/']);
    const name = path.join(out, `reel-${id}-${lang}`);
    if (still) {
      let t = 0;
      for (const s of sc) { await page.evaluate((x) => window.render(x), t + s.d * 0.6); await page.screenshot({ path: `${name}-${Math.round(t * 10)}.jpg`, type: 'jpeg', quality: 80 }); t += s.d; }
      await page.close(); continue;
    }
    const n = Math.round(total * FPS);
    const ff = spawn('ffmpeg', ['-y', '-loglevel', 'error', '-f', 'image2pipe', '-framerate', String(FPS), '-c:v', 'mjpeg', '-i', '-',
      '-c:v', 'libx264', '-preset', 'medium', '-crf', '21', '-pix_fmt', 'yuv420p', name + '.silent.mp4'], { stdio: ['pipe', 'inherit', 'inherit'] });
    for (let f = 0; f < n; f++) {
      await page.evaluate((x) => window.render(x), f / FPS);
      const buf = await page.screenshot({ type: 'jpeg', quality: 93 });
      if (!ff.stdin.write(buf)) await new Promise((r) => ff.stdin.once('drain', r));
    }
    ff.stdin.end(); await new Promise((r) => ff.on('close', r));
    const cuts = []; let t = 0; for (const s of sc) { cuts.push(t); t += s.d; }
    execFileSync('python3', [path.join(__dirname, 'music.py'), name + '.wav', String(total), cuts.join(',')]);
    execFileSync('ffmpeg', ['-y', '-loglevel', 'error', '-i', name + '.silent.mp4', '-i', name + '.wav', '-c:v', 'copy', '-c:a', 'aac', '-b:a', '128k', '-shortest', '-movflags', '+faststart', name + '.mp4']);
    fs.unlinkSync(name + '.silent.mp4'); fs.unlinkSync(name + '.wav');
    console.log(name + '.mp4', total.toFixed(1) + 's');
    await page.close();
  }
  await browser.close();
})();
