import 'dart:async';
import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

import '../config/theme.dart';
import 'motion.dart';

// The site's sense of humour: one short, kind line on the not-found page, the logo's secret and the footer, written
// separately in Arabic and English. Never on prices, the contact form's errors or the legal text, and never at the
// visitor's expense.

/// A number for this visit, so the line picked holds while pages redraw and changes at the next visit.
final int _visit = DateTime.now().millisecondsSinceEpoch ~/ 1000;

/// One of a few (already translated) lines for the same moment, so the joke does not go stale.
String funLine(List<String> lines) => lines[_visit % lines.length];

/// Zirr means "button": a shirt button in the brand's colours, the thread crossing its four holes.
class ZirrButton extends StatelessWidget {
  const ZirrButton({this.size = 72, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ExcludeSemantics(
      child: SizedBox.square(
        dimension: size,
        child: CustomPaint(painter: _ButtonPainter(scheme.primary, scheme.secondary, scheme.surface)),
      ),
    );
  }
}

class _ButtonPainter extends CustomPainter {
  _ButtonPainter(this.disc, this.thread, this.holes);

  final Color disc;
  final Color thread;
  final Color holes;

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = size.width / 2;
    canvas.drawCircle(c, r * 0.96, Paint()..color = disc);
    canvas.drawCircle(
      c,
      r * 0.78,
      Paint()
        ..color = holes.withValues(alpha: 0.25)
        ..style = PaintingStyle.stroke
        ..strokeWidth = r * 0.06,
    );
    final d = r * 0.24;
    final at = [c + Offset(-d, -d), c + Offset(d, -d), c + Offset(-d, d), c + Offset(d, d)];
    for (final o in at) {
      canvas.drawCircle(o, r * 0.13, Paint()..color = holes);
    }
    final stitch = Paint()
      ..color = thread
      ..strokeWidth = r * 0.11
      ..strokeCap = StrokeCap.round;
    canvas
      ..drawLine(at[0], at[3], stitch)
      ..drawLine(at[1], at[2], stitch);
  }

  @override
  bool shouldRepaint(_ButtonPainter old) => old.disc != disc || old.thread != thread || old.holes != holes;
}

/// The not-found page's picture: a button, lost from the page, rolls in from the end side and settles with a wobble.
/// Tapped, it hops.
class LostButton extends StatefulWidget {
  const LostButton({this.size = 80, this.label = 'The lost button', super.key});

  final double size;
  final String label;

  @override
  State<LostButton> createState() => _LostButtonState();
}

class _LostButtonState extends State<LostButton> with TickerProviderStateMixin {
  late final AnimationController _roll = AnimationController(vsync: this, duration: const Duration(milliseconds: 1600));
  late final AnimationController _hop = AnimationController(vsync: this, duration: AppTheme.slow + AppTheme.fast);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (reduceMotion(context)) {
      _roll.value = 1;
    } else if (_roll.status == AnimationStatus.dismissed) {
      unawaited(_roll.forward());
    }
  }

  @override
  void dispose() {
    _roll.dispose();
    _hop.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;
    final from = Directionality.of(context) == TextDirection.rtl ? -1.0 : 1.0;
    return Semantics(
      button: true,
      label: widget.label,
      child: Tooltip(
        message: widget.label,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              if (!reduceMotion(context)) unawaited(_hop.forward(from: 0));
            },
            child: SizedBox(
              width: size * 2.2,
              height: size * 1.5,
              child: AnimatedBuilder(
                animation: Listenable.merge([_roll, _hop]),
                builder: (context, _) {
                  final t = _roll.value;
                  final r = AppTheme.enter.transform(t);
                  final wobble = math.sin(t * math.pi * 5) * (1 - t) * 0.18;
                  final hop = math.sin(_hop.value * math.pi) * size * 0.4;
                  final x = from * size * 1.5 * (1 - r);
                  final turns = -from * (1 - r) * math.pi * 3 + wobble + _hop.value * math.pi * 2 * -from;
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Transform.translate(
                        offset: Offset(x, 0),
                        child: Container(
                          width: size * (0.8 - 0.3 * hop / size),
                          height: size * 0.1,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(size),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: size * 0.05 + hop,
                        child: Transform.translate(
                          offset: Offset(x, 0),
                          child: Transform.rotate(
                            angle: turns,
                            child: ZirrButton(size: size),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
