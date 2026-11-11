"""Cuts the captioned clips for social posts from the tutorial video.

    python3 make_clips.py <tutorial.mp4> <tutorial.srt> [clip names...]

A clip runs from the start of one caption to the end of another, so it follows the video when its timing changes.
"""
import subprocess, sys, tempfile, os
MP4, SRT = sys.argv[1], sys.argv[2]
def t(s):
    h, m, r = s.split(':'); sec, ms = r.split(','); return int(h) * 3600 + int(m) * 60 + int(sec) + int(ms) / 1000
def f(x):
    x = max(0, x); ms = int(round(x * 1000)); return f"{ms // 3600000:02}:{ms % 3600000 // 60000:02}:{ms % 60000 // 1000:02},{ms % 1000:03}"
cues = []
for b in open(SRT, encoding='utf-8').read().strip().split('\n\n'):
    l = b.strip().split('\n'); a, c = l[1].split(' --> '); cues.append((t(a), t(c), '\n'.join(l[2:])))
def find(text, end=False):
    for a, c, x in cues:
        if text.lower() in x.lower().replace('\n', ' '): return c if end else a
    raise SystemExit(f'no caption has: {text}')
def clip(name, start, end, crf):
    out = [(max(a, start) - start, min(c, end) - start, x) for a, c, x in cues if c > start and a < end]
    srt = os.path.join(tempfile.mkdtemp(), 'c.srt')
    open(srt, 'w', encoding='utf-8').write('\n\n'.join(f"{i + 1}\n{f(a)} --> {f(c)}\n{x}" for i, (a, c, x) in enumerate(out)) + '\n')
    style = "FontName=DejaVu Sans,FontSize=14,PrimaryColour=&H00FFFFFF,OutlineColour=&H80000000,BorderStyle=3,Outline=4,Shadow=0,MarginV=22"
    fade = end - start - 0.6
    subprocess.run(['ffmpeg', '-y', '-loglevel', 'error', '-ss', str(start), '-to', str(end), '-i', MP4,
        '-vf', f"scale=1280:720,subtitles={srt}:force_style='{style}',fade=t=in:st=0:d=0.4,fade=t=out:st={fade}:d=0.6",
        '-af', f"afade=t=in:st=0:d=0.3,afade=t=out:st={fade}:d=0.6", '-c:v', 'libx264', '-preset', 'slow', '-crf', str(crf),
        '-pix_fmt', 'yuv420p', '-c:a', 'aac', '-b:a', '96k', '-movflags', '+faststart', name + '.mp4'], check=True)
last = cues[-1][1] + 3.5
clips = {
    'clip-intro': (0.0, find('Sharjah.', end=True) + 0.8, 26),
    'clip-shop-checkout': (find('On a product page') - 0.3, find('all in one place', end=True) + 0.8, 26),
    'clip-back-office': (find('The dashboard is the first') - 0.3, find('reviewing any difference', end=True) + 0.8, 26),
    'clip-till': (find('Now the till') - 0.3, find('against what it expects', end=True) + 0.8, 26),
    'clip-arabic-dark': (find('speaks English and Arabic') - 0.3, find('dark theme too', end=True) + 0.8, 26),
    'arandas-tech-tutorial-720p': (0.0, last, 33),
}
for n in sys.argv[3:] or clips: clip(n, *clips[n])
