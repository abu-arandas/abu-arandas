// Lists every English text the site shows that has no Arabic entry in lib/l10n/ar.dart, every Arabic entry
// written twice, and every Arabic entry whose English is no longer used. Run from site/:
//
//   node tool/check_arabic.mjs
//
// It reads source text only (nothing is built or run). Texts counted as shown:
//   * literals translated with `.tr` / `.trParams`;
//   * literals handed to a block that translates them (`title:`, `subtitle:`, `body:`, `eyebrow:`,
//     `Eyebrow('...')`, `SiteLink('...', ...)`);
//   * every text in lib/config/content.dart, the site's words, except links, paths, asset names and the
//     technology names in `stack:`.
import fs from 'node:fs';
import path from 'node:path';

const lib = 'lib';
const i18n = path.join(lib, 'l10n');
const contentFile = path.join(lib, 'config', 'content.dart');

function walk(dir, acc = []) {
  for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
    const p = path.join(dir, e.name);
    if (e.isDirectory()) walk(p, acc);
    else if (p.endsWith('.dart')) acc.push(p);
  }
  return acc;
}

const LITERAL = /'(?:[^'\\\n]|\\.)*'|"(?:[^"\\\n]|\\.)*"/g;
const unquote = (s) => s.slice(1, -1).replace(/\\(['"$\\])/g, '$1');
// Adjacent literals split over lines are one text.
const joined = (text) => text.replace(/'\s*\n\s*'/g, '');
const lineOf = (text, index) => text.slice(0, index).split('\n').length;

// --- the Arabic keys
const known = new Map();
const repeated = [];
const arText = joined(fs.readFileSync(path.join(i18n, 'ar.dart'), 'utf8'));
for (const m of arText.matchAll(/^\s*('(?:[^'\\\n]|\\.)*'|"(?:[^"\\\n]|\\.)*")\s*:/gm)) {
  const key = unquote(m[1]);
  if (known.has(key)) repeated.push(key);
  known.set(key, lineOf(arText, m.index));
}

// --- the texts the site shows
const missing = new Map(); // text -> first place
const looksLikeData = (t) => /^(https?:|mailto:|tel:|\/|assets\/|#)/.test(t) || /^[\w.-]+\.(png|jpe?g|svg|webp|pdf)$/.test(t);
function want(text, file, line) {
  if (text.includes('$') || !/[A-Za-z]/.test(text) || looksLikeData(text) || known.has(text) || missing.has(text)) return;
  missing.set(text, `${file}:${line}`);
}

const sources = walk(lib).filter((f) => !f.startsWith(i18n));
const handedOn = /(?:\b(?:title|subtitle|body|eyebrow)[:=]\s*|Eyebrow\(|SiteLink\()('(?:[^'\\\n]|\\.)*')/g;
for (const file of sources) {
  const text = joined(fs.readFileSync(file, 'utf8'));
  for (const m of text.matchAll(/('(?:[^'\\\n]|\\.)*')\.(?:tr|trParams)\b/g)) want(unquote(m[1]), file, lineOf(text, m.index));
  for (const m of text.matchAll(handedOn)) want(unquote(m[1]), file, lineOf(text, m.index));
}
{
  const text = joined(fs.readFileSync(contentFile, 'utf8'));
  // Skip comments, imports and `stack: [...]` (product names, the same in every language), then take every literal
  // that is not a link, a path or an asset.
  const code = text
    .replace(/\/\/[^\n]*|^import [^\n]*|\bstack:\s*\[[^\]]*\]/gm, (c) => ' '.repeat(c.length));
  for (const m of code.matchAll(LITERAL)) {
    const before = code.slice(Math.max(0, m.index - 12), m.index);
    if (/(?:url|href|route|image|asset|path|slug|id):\s*$/.test(before)) continue;
    want(unquote(m[0]), contentFile, lineOf(text, m.index));
  }
}

// --- Arabic whose English is gone
const all = sources.map((f) => joined(fs.readFileSync(f, 'utf8'))).join('\n');
const unused = [...known.keys()].filter((k) => !all.includes(`'${k.replace(/'/g, "\\'")}'`) && !all.includes(`"${k}"`));

let bad = 0;
const report = (title, items) => {
  if (!items.length) return;
  bad += items.length;
  console.log(`${title} (${items.length}):`);
  for (const i of items) console.log(`  ${i}`);
};
report('Arabic texts written twice', repeated);
report('English texts with no Arabic', [...missing].map(([t, where]) => `${JSON.stringify(t)}  ${where}`));
report('Arabic left over from a text that is gone', unused.map((k) => JSON.stringify(k)));
console.log(bad === 0 ? `All good: ${known.size} Arabic texts, none repeated, missing or left over.` : `\n${bad} problem(s).`);
process.exit(bad === 0 ? 0 : 1);
