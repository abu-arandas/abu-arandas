"""A short upbeat backing track for a reel, made from scratch (no samples, nothing licensed).

    python3 music.py out.wav <seconds> <cut times, comma separated>

Am F C G at 112 bpm: pad, bass, plucked arpeggio, kick, clap and hats, with a soft whoosh on every scene change.
"""
import sys, wave
import numpy as np

SR = 44100
out, length, cuts = sys.argv[1], float(sys.argv[2]), [float(x) for x in sys.argv[3].split(',') if x]
N = int(length * SR)
t = np.arange(N) / SR
rng = np.random.default_rng(7)
BPM = 112
beat = 60 / BPM
mix = np.zeros(N)

def hz(n): return 440 * 2 ** ((n - 69) / 12)
def lowpass(x, cutoff):
    X = np.fft.rfft(x); f = np.fft.rfftfreq(len(x), 1 / SR)
    return np.fft.irfft(X / np.sqrt(1 + (f / cutoff) ** 4), len(x))
def highpass(x, cutoff):
    X = np.fft.rfft(x); f = np.fft.rfftfreq(len(x), 1 / SR)
    return np.fft.irfft(X / np.sqrt(1 + (cutoff / np.maximum(f, 1)) ** 4), len(x))
def add(sig, at, gain):
    i = int(at * SR)
    if i >= N: return
    j = min(N, i + len(sig)); mix[i:j] += gain * sig[:j - i]

# chords: root (MIDI) and triad
chords = [(57, [57, 60, 64]), (53, [53, 57, 60]), (48, [52, 55, 60]), (55, [55, 59, 62])]
bar = 4 * beat
nbars = int(np.ceil(length / bar)) + 1

pad = np.zeros(N)
for b in range(nbars):
    root, triad = chords[b % 4]
    s, e = int(b * bar * SR), min(N, int((b + 1) * bar * SR))
    if s >= N: break
    tt = t[s:e]
    for n in triad + [triad[0] + 12]:
        for det in (-0.08, 0.08):
            f = hz(n + det)
            for h in range(1, 6):
                pad[s:e] += np.sin(2 * np.pi * f * h * tt + h) / h / 8
    env = np.minimum(1, (tt - tt[0]) / 0.25) * np.minimum(1, (tt[-1] - tt) / 0.2 + 0.2)
    pad[s:e] *= env
mix += 0.16 * lowpass(pad, 1800)

for b in range(nbars):
    root, triad = chords[b % 4]
    for k in range(8):  # bass on eighths
        at = b * bar + k * beat / 2
        d = np.arange(int(beat / 2 * SR * 0.9)) / SR
        f = hz(root - 12)
        sig = (np.sin(2 * np.pi * f * d) + 0.3 * np.sin(4 * np.pi * f * d)) * np.exp(-d * 6)
        add(sig, at, 0.32 if k % 2 == 0 else 0.22)
    arp = triad + [triad[1] + 12, triad[2] + 12, triad[1] + 12, triad[0] + 12, triad[2]]
    for k in range(16):  # plucks on sixteenths
        at = b * bar + k * beat / 4
        d = np.arange(int(0.35 * SR)) / SR
        f = hz(arp[k % len(arp)] + 12)
        sig = (np.sin(2 * np.pi * f * d) + 0.5 * np.sin(4 * np.pi * f * d) + 0.2 * np.sin(6 * np.pi * f * d)) * np.exp(-d * 14)
        add(sig, at, 0.06 if k % 4 else 0.09)
    for k in range(4):  # kick on every beat
        at = b * bar + k * beat
        d = np.arange(int(0.4 * SR)) / SR
        ph = 2 * np.pi * np.cumsum(45 + 90 * np.exp(-d * 30)) / SR
        add(np.sin(ph) * np.exp(-d * 7), at, 0.55)
    for k in (1, 3):  # clap
        d = np.arange(int(0.25 * SR)) / SR
        add(highpass(rng.standard_normal(len(d)), 1200) * np.exp(-d * 22), b * bar + k * beat, 0.16)
    for k in range(8):  # hats
        d = np.arange(int(0.06 * SR)) / SR
        add(highpass(rng.standard_normal(len(d)), 7000) * np.exp(-d * 70), b * bar + k * beat / 2 + (beat / 2 if False else 0), 0.05 if k % 2 == 0 else 0.08)

for c in cuts[1:]:  # whoosh into each scene
    d = np.arange(int(0.6 * SR)) / SR
    env = np.sin(np.pi * d / d[-1]) ** 2
    add(lowpass(highpass(rng.standard_normal(len(d)), 500), 4000) * env, max(0, c - 0.35), 0.12)

fade_in, fade_out = np.minimum(1, t / 0.4), np.minimum(1, (length - t) / 1.2)
mix *= fade_in * fade_out
mix = np.tanh(mix * 1.1) * 0.8
pcm = (np.clip(mix, -1, 1) * 32767).astype('<i2')
with wave.open(out, 'wb') as w:
    w.setnchannels(1); w.setsampwidth(2); w.setframerate(SR); w.writeframes(pcm.tobytes())
