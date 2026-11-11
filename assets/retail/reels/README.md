# Reels

Vertical 1080x1920 reels for Facebook, Instagram and LinkedIn, five topics in Arabic and English, with a backing track made from scratch by `music.py` (no samples, nothing to license).

```
cd ERP && flutter test test/tutorial/record_tutorial.dart      # screenshots in build/tutorial/{desktop,phone}
cd abu-arandas/assets/retail/reels
node render.js ~/ERP/build/tutorial ..                          # all reels, both languages
node render.js ~/ERP/build/tutorial /tmp/stills till --lang ar --still   # one still per scene, to check the framing
```

The words, screenshots and camera moves of each reel are in `reels.json`; the look is in `reel.html`.
