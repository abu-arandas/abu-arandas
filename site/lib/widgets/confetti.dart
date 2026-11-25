import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

import '../config/brand.dart';
import 'motion.dart';

/// How a celebration throws its confetti.
enum Celebration {
  /// Up out of a point, such as the button just pressed, and down again.
  burst,

  /// Down from the top of the window, swaying as it falls.
  rain,

  /// Shirt buttons falling from the top: the secret on the wordmark.
  buttons,
}

/// Throws a handful of confetti over the whole window for a moment worth a cheer: something put in the bag, an order
/// placed, a sign-up done. [from] is a point on the screen (`localToGlobal`) for a [Celebration.burst]; without one it
/// bursts from the middle. It never takes a tap, cleans itself up, and does nothing with reduced motion. Never use it
/// for a payment or anything about money going wrong.
void celebrate(BuildContext context, {Celebration kind = Celebration.burst, Offset? from}) {
  if (reduceMotion(context)) return;
  final overlay = Overlay.maybeOf(context, rootOverlay: true);
  if (overlay == null) return;
  // The company's saffron and teal, its ink, and a lighter saffron.
  const colours = [Brand.accent, Brand.seedColor, Brand.ink, Brand.accentDark, Brand.seedColor, Brand.accent];
  final space = overlay.context.findRenderObject();
  Offset? origin;
  if (space is RenderBox && from != null) origin = space.globalToLocal(from);
  late final OverlayEntry entry;
  entry = OverlayEntry(
    builder: (_) => IgnorePointer(
      child: _Confetti(kind: kind, from: origin, colours: colours, holes: Brand.page, onDone: entry.remove),
    ),
  );
  overlay.insert(entry);
}

class _Confetti extends StatefulWidget {
  const _Confetti({required this.kind, required this.from, required this.colours, required this.holes, required this.onDone});

  final Celebration kind;
  final Offset? from;
  final List<Color> colours;
  final Color holes;
  final VoidCallback onDone;

  @override
  State<_Confetti> createState() => _ConfettiState();
}

class _ConfettiState extends State<_Confetti> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: widget.kind == Celebration.burst ? const Duration(milliseconds: 1700) : const Duration(milliseconds: 3000),
  );
  List<_Piece>? _pieces;

  @override
  void initState() {
    super.initState();
    _c.addStatusListener((s) {
      if (s == AnimationStatus.completed) widget.onDone();
    });
    _c.forward();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  List<_Piece> _make(Size size) {
    final r = math.Random();
    final colours = widget.colours;
    double between(double a, double b) => a + r.nextDouble() * (b - a);
    switch (widget.kind) {
      case Celebration.burst:
        final from = widget.from ?? size.center(Offset.zero);
        // A phone gets fewer pieces: the same cheer on a smaller screen, and less work for it.
        final n = size.width < 600 ? 40 : 70;
        return [
          for (var i = 0; i < n; i++)
            _Piece(
              start: from,
              velocity: Offset.fromDirection(between(-math.pi * 0.9, -math.pi * 0.1), between(640, 1400)),
              colour: colours[i % colours.length],
              shape: i % 5 == 0 ? _Shape.button : (i.isEven ? _Shape.strip : _Shape.dot),
              size: between(9, 15),
              spin: between(-9, 9),
              flip: between(4, 12),
              sway: 0,
              phase: between(0, math.pi * 2),
            ),
        ];
      case Celebration.rain:
      case Celebration.buttons:
        final buttons = widget.kind == Celebration.buttons;
        final n = (size.width / (buttons ? 34 : 16)).clamp(20, buttons ? 46 : 110).round();
        return [
          for (var i = 0; i < n; i++)
            _Piece(
              start: Offset(between(0, size.width), between(-size.height * 0.45, -20)),
              velocity: Offset(between(-60, 60), between(80, 220)),
              colour: colours[i % colours.length],
              shape: buttons ? _Shape.button : (i % 6 == 0 ? _Shape.button : (i.isEven ? _Shape.strip : _Shape.dot)),
              size: buttons ? between(16, 30) : between(7, 12),
              spin: between(-5, 5),
              flip: between(3, 9),
              sway: between(10, 26),
              phase: between(0, math.pi * 2),
            ),
        ];
    }
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, box) {
      final size = box.biggest;
      final pieces = _pieces ??= _make(size);
      return RepaintBoundary(
        child: CustomPaint(size: size, painter: _ConfettiPainter(_c, pieces, widget.kind, widget.holes)),
      );
    },
  );
}

enum _Shape { strip, dot, button }

class _Piece {
  _Piece({
    required this.start,
    required this.velocity,
    required this.colour,
    required this.shape,
    required this.size,
    required this.spin,
    required this.flip,
    required this.sway,
    required this.phase,
  });

  final Offset start;
  final Offset velocity;
  final Color colour;
  final _Shape shape;
  final double size;
  final double spin;
  final double flip;
  final double sway;
  final double phase;
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter(this.time, this.pieces, this.kind, this.holes) : super(repaint: time);

  final AnimationController time;
  final List<_Piece> pieces;
  final Celebration kind;
  final Color holes;

  @override
  void paint(Canvas canvas, Size size) {
    final progress = time.value;
    final seconds = progress * time.duration!.inMilliseconds / 1000;
    final burst = kind == Celebration.burst;
    // Air slows a burst quickly; gravity then brings it down.
    const drag = 2.2;
    final gravity = burst ? 1500.0 : 260.0;
    final fade = progress < 0.72 ? 1.0 : (1 - (progress - 0.72) / 0.28).clamp(0.0, 1.0);
    final paint = Paint();
    for (final p in pieces) {
      final Offset at;
      if (burst) {
        final slowed = (1 - math.exp(-drag * seconds)) / drag;
        at = p.start + p.velocity * slowed + Offset(0, 0.5 * gravity * seconds * seconds * 0.45);
      } else {
        at = p.start + p.velocity * seconds + Offset(math.sin(seconds * 3 + p.phase) * p.sway, 0.5 * gravity * seconds * seconds);
      }
      if (at.dy > size.height + 40) continue;
      paint.color = p.colour.withValues(alpha: p.colour.a * fade);
      canvas.save();
      canvas.translate(at.dx, at.dy);
      canvas.rotate(p.phase + p.spin * seconds);
      // Turning over as it falls, so a strip flashes thin and wide like paper.
      canvas.scale(1, math.cos(p.phase + p.flip * seconds).abs().clamp(0.2, 1));
      final s = p.size;
      switch (p.shape) {
        case _Shape.strip:
          canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: Offset.zero, width: s, height: s * 0.42), const Radius.circular(1.5)), paint);
        case _Shape.dot:
          canvas.drawCircle(Offset.zero, s * 0.38, paint);
        case _Shape.button:
          // A small shirt button: a disc and four holes in the colour of the page.
          canvas.drawCircle(Offset.zero, s * 0.5, paint);
          final hole = Paint()..color = holes.withValues(alpha: fade);
          final d = s * 0.14;
          final r = s * 0.075;
          for (final o in [Offset(-d, -d), Offset(d, -d), Offset(-d, d), Offset(d, d)]) {
            canvas.drawCircle(o, r, hole);
          }
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) => old.pieces != pieces;
}

/// Where a widget sits on the screen, for [celebrate]'s `from`: the middle of the box [key] is on, if it is drawn.
Offset? centreOf(GlobalKey key) {
  final box = key.currentContext?.findRenderObject();
  if (box is! RenderBox || !box.attached || !box.hasSize) return null;
  return box.localToGlobal(box.size.center(Offset.zero));
}
