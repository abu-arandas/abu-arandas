import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/scheduler.dart';
import 'package:material_ui/material_ui.dart';

import '../config/brand.dart';
import '../config/breakpoints.dart';
import '../config/theme.dart';

// The shop's motion. Blocks rise into view as they are scrolled to, headlines arrive word by word, things answer the
// pointer and a few moments pop. All of it plays once, moves only position, size and opacity (and a clip for a picture
// being uncovered), and with reduced motion shows the end at once. The back office keeps to [Appear], [HoverLift],
// [PressScale] and [DrawnCheck]. The same kit as Zirr Retail's, on this app's tokens (AppMotion); see docs/BRAND.md,
// "Motion and voice".

/// Whether the person has asked for less motion (on the web, the browser's "reduce motion" setting). Then everything
/// is simply there: nothing slides, pops or waits to be shown.
bool reduceMotion(BuildContext context) => MediaQuery.maybeDisableAnimationsOf(context) ?? false;

/// The gap between one item of a group and the next as they arrive: shorter on a phone.
Duration staggerOf(BuildContext context) => context.isMobile ? AppTheme.staggerPhone : AppTheme.stagger;

/// Fades and slides its child in when it is first built, after [delay]. With reduced motion it just shows.
class Appear extends StatelessWidget {
  const Appear({super.key, required this.child, this.delay = Duration.zero, this.offset = const Offset(0, 12), this.duration = AppTheme.slow});

  final Widget child;
  final Duration delay;
  final Offset offset;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    if (reduceMotion(context)) return child;
    final total = duration + delay;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: total,
      curve: delay == Duration.zero ? AppTheme.enter : Interval(delay.inMilliseconds / total.inMilliseconds, 1, curve: AppTheme.enter),
      builder: (context, t, child) => Opacity(
        opacity: t,
        child: Transform.translate(offset: offset * (1 - t), child: child),
      ),
      child: child,
    );
  }
}

/// Settles its child from a little larger to its size when first built: the hero's photograph.
class Settle extends StatelessWidget {
  const Settle({super.key, required this.child, this.from = 1.06, this.duration = AppTheme.hero});

  final Widget child;
  final double from;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    if (reduceMotion(context)) return child;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: from, end: 1),
      duration: duration,
      curve: AppTheme.enter,
      builder: (context, s, child) => Transform.scale(scale: s, child: child),
      child: child,
    );
  }
}

/// A figure that rolls to its value: from nought on first show, then from the old value to each new one. With
/// reduced motion it simply shows the value.
class AnimatedCounter extends StatelessWidget {
  const AnimatedCounter({super.key, required this.value, required this.format, this.style, this.duration = AppTheme.slow});

  final num value;
  final String Function(num value) format;
  final TextStyle? style;
  final Duration duration;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    tween: Tween(begin: 0, end: value.toDouble()),
    duration: reduceMotion(context) ? Duration.zero : duration,
    curve: Curves.easeOutCubic,
    builder: (context, v, _) => Text(format(value is int ? v.round() : v), style: style),
  );
}

/// Plays an animation from 0 to 1, once, when its child first comes into view in the page that scrolls it (straight
/// away when nothing scrolls it), after [delay]. Scrolling back to it does not play it again; a block already scrolled
/// past is simply shown. With reduced motion it starts at 1.
class InView extends StatefulWidget {
  const InView({
    super.key,
    required this.builder,
    this.child,
    this.duration = AppTheme.reveal,
    this.delay = Duration.zero,
    this.curve = AppTheme.enter,
    this.margin = 56,
  });

  /// Draws the child at a point of the animation: 0 before, 1 at the end (a curve such as [AppTheme.pop] may pass 1).
  final Widget Function(BuildContext context, double t, Widget? child) builder;
  final Widget? child;
  final Duration duration;
  final Duration delay;
  final Curve curve;

  /// How far into the window the child's top must come before it plays.
  final double margin;

  @override
  State<InView> createState() => _InViewState();
}

class _InViewState extends State<InView> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: widget.delay + widget.duration);
  late final Animation<double> _t = CurvedAnimation(
    parent: _c,
    curve: widget.delay == Duration.zero
        ? widget.curve
        : Interval(widget.delay.inMicroseconds / (widget.delay + widget.duration).inMicroseconds, 1, curve: widget.curve),
  );
  ScrollPosition? _position;
  bool _started = false;
  bool _checkPending = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    if (reduceMotion(context)) {
      _show();
      return;
    }
    // A window made taller can bring the child into view without a scroll.
    MediaQuery.sizeOf(context);
    final position = Scrollable.maybeOf(context, axis: Axis.vertical)?.position;
    if (position != _position) {
      _position?.removeListener(_onScroll);
      _position = position?..addListener(_onScroll);
    }
    _checkSoon();
  }

  // The page has only been told where to scroll to: where the child lands is known once the next frame is laid out.
  void _onScroll() => _checkSoon();

  void _checkSoon() {
    if (_checkPending) return;
    _checkPending = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkPending = false;
      _check();
    });
    // A scroll does not always ask for a frame by itself; this makes sure the check comes.
    SchedulerBinding.instance.ensureVisualUpdate();
  }

  void _check() {
    if (_started || !mounted) return;
    final box = context.findRenderObject();
    if (box is! RenderBox || !box.attached || !box.hasSize) return;
    final port = Scrollable.maybeOf(context, axis: Axis.vertical)?.context.findRenderObject();
    if (port is! RenderBox || !port.attached || !port.hasSize) {
      _play();
      return;
    }
    final top = box.localToGlobal(Offset.zero, ancestor: port).dy;
    final margin = math.min(widget.margin, box.size.height / 2);
    if (top + box.size.height <= 0) {
      _show();
    } else if (top < port.size.height - margin) {
      _play();
    }
  }

  void _detach() {
    _position?.removeListener(_onScroll);
    _position = null;
  }

  void _play() {
    _started = true;
    _detach();
    unawaited(_c.forward());
  }

  void _show() {
    _started = true;
    _detach();
    _c.value = 1;
  }

  @override
  void dispose() {
    _detach();
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      AnimatedBuilder(animation: _t, builder: (context, child) => widget.builder(context, _t.value, child), child: widget.child);
}

/// A block of the shop that rises [rise] points and fades in once, as it comes into view.
class Reveal extends StatelessWidget {
  const Reveal({super.key, required this.child, this.delay = Duration.zero, this.rise = AppTheme.rise, this.duration = AppTheme.reveal});

  final Widget child;
  final Duration delay;
  final double rise;
  final Duration duration;

  @override
  Widget build(BuildContext context) => InView(
    delay: delay,
    duration: duration,
    child: child,
    builder: (context, t, child) => Opacity(
      opacity: t.clamp(0.0, 1.0),
      child: Transform.translate(offset: Offset(0, rise * (1 - t)), child: child),
    ),
  );
}

/// A picture that is uncovered from the start edge, like a curtain drawn back, and settles from a little larger to its
/// size as it comes into view.
class PhotoReveal extends StatelessWidget {
  const PhotoReveal({super.key, required this.child, this.delay = Duration.zero, this.duration = const Duration(milliseconds: 900)});

  final Widget child;
  final Duration delay;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final rtl = Directionality.of(context) == TextDirection.rtl;
    return InView(
      delay: delay,
      duration: duration,
      child: child,
      builder: (context, t, child) => ClipRect(
        clipper: _Curtain(t.clamp(0.0, 1.0), rtl),
        child: Transform.scale(scale: 1.06 - 0.06 * t, child: child),
      ),
    );
  }
}

class _Curtain extends CustomClipper<Rect> {
  _Curtain(this.t, this.rtl);

  final double t;
  final bool rtl;

  @override
  Rect getClip(Size size) {
    final w = size.width * t;
    return rtl ? Rect.fromLTWH(size.width - w, 0, w, size.height) : Rect.fromLTWH(0, 0, w, size.height);
  }

  @override
  bool shouldReclip(_Curtain old) => old.t != t || old.rtl != rtl;
}

/// A headline whose words rise into place one after another. A screen reader hears it once, whole.
class WordsRise extends StatelessWidget {
  const WordsRise(this.text, {super.key, required this.style, this.delay = Duration.zero, this.textAlign = TextAlign.start});

  final String text;
  final TextStyle? style;
  final Duration delay;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    if (reduceMotion(context)) {
      return Semantics(
        header: true,
        child: Text(text, style: style, textAlign: textAlign),
      );
    }
    final words = text.trim().split(RegExp(r'\s+'));
    final size = style?.fontSize ?? 34;
    final step = staggerOf(context);
    return Semantics(
      header: true,
      label: text,
      child: ExcludeSemantics(
        child: Wrap(
          spacing: size * 0.26,
          alignment: switch (textAlign) {
            TextAlign.center => WrapAlignment.center,
            TextAlign.end || TextAlign.right => WrapAlignment.end,
            _ => WrapAlignment.start,
          },
          children: [
            for (final (i, w) in words.indexed)
              Appear(
                delay: delay + step * i,
                offset: Offset(0, size * 0.45),
                duration: AppTheme.slow + AppTheme.hover,
                child: Text(w, style: style),
              ),
          ],
        ),
      ),
    );
  }
}

/// Tells the pictures inside a [HoverLift] that the pointer is over it.
class HoverScope extends InheritedWidget {
  const HoverScope({super.key, required this.hovered, required super.child});

  final bool hovered;

  static bool of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<HoverScope>()?.hovered ?? false;

  @override
  bool updateShouldNotify(HoverScope old) => old.hovered != hovered;
}

/// A picture that leans in a little, inside its frame, while the card round it is under the pointer.
class HoverZoom extends StatelessWidget {
  const HoverZoom({super.key, required this.child, this.scale = 1.04, this.hovered});

  final Widget child;
  final double scale;

  /// Overrides the [HoverScope] above, for a card that tracks its own hover.
  final bool? hovered;

  @override
  Widget build(BuildContext context) {
    final on = (hovered ?? HoverScope.of(context)) && !reduceMotion(context);
    return AnimatedScale(scale: on ? scale : 1, duration: AppTheme.slow, curve: AppTheme.curve, child: child);
  }
}

/// Lifts its child a little under the pointer, onto a deeper shadow, and lets it give a touch when pressed.
class HoverLift extends StatefulWidget {
  const HoverLift({super.key, required this.child, this.onTap, this.lift = 4, this.radius = AppTheme.radius, this.semanticLabel, this.zoom = false});

  final Widget child;
  final VoidCallback? onTap;
  final double lift;
  final double radius;
  final String? semanticLabel;

  /// Whether the pictures inside lean in too ([HoverZoom]): the shop's cards. The back office keeps them still.
  final bool zoom;

  @override
  State<HoverLift> createState() => _HoverLiftState();
}

class _HoverLiftState extends State<HoverLift> {
  bool _hover = false;
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    final reduce = reduceMotion(context);
    final lift = _hover && !_down ? -widget.lift : 0.0;
    Widget body = AnimatedContainer(
      duration: reduce ? Duration.zero : (_down ? const Duration(milliseconds: 90) : AppTheme.medium),
      curve: AppTheme.curve,
      transform: Matrix4.translationValues(0, lift, 0),
      decoration: ShapeDecoration(shape: AppTheme.shape(widget.radius), shadows: _hover ? AppTheme.lifted : const []),
      child: HoverScope(hovered: widget.zoom && _hover && !reduce, child: widget.child),
    );
    if (widget.onTap != null) {
      body = Semantics(
        button: true,
        label: widget.semanticLabel,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onTap,
          onTapDown: (_) => setState(() => _down = true),
          onTapUp: (_) => setState(() => _down = false),
          onTapCancel: () => setState(() => _down = false),
          child: body,
        ),
      );
    }
    return MouseRegion(
      cursor: widget.onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: body,
    );
  }
}

/// A button that gives a little when pressed: calm, for the checkout and the back office.
class PressScale extends StatefulWidget {
  const PressScale({super.key, required this.child, this.scale = 0.97});

  final Widget child;
  final double scale;

  @override
  State<PressScale> createState() => _PressScaleState();
}

class _PressScaleState extends State<PressScale> {
  bool _down = false;

  void _set(bool down) {
    if (down != _down) setState(() => _down = down);
  }

  @override
  Widget build(BuildContext context) {
    if (reduceMotion(context)) return widget.child;
    return Listener(
      onPointerDown: (_) => _set(true),
      onPointerUp: (_) => _set(false),
      onPointerCancel: (_) => _set(false),
      child: AnimatedScale(
        scale: _down ? widget.scale : 1,
        duration: Duration(milliseconds: _down ? 90 : 220),
        curve: AppTheme.curve,
        child: widget.child,
      ),
    );
  }
}

/// A shop button that squishes a little while pressed and springs back past its size before it settles.
class Squish extends StatefulWidget {
  const Squish({super.key, required this.child, this.scale = 0.94});

  final Widget child;
  final double scale;

  @override
  State<Squish> createState() => _SquishState();
}

class _SquishState extends State<Squish> {
  bool _down = false;

  void _set(bool down) {
    if (down != _down) setState(() => _down = down);
  }

  @override
  Widget build(BuildContext context) {
    if (reduceMotion(context)) return widget.child;
    return Listener(
      onPointerDown: (_) => _set(true),
      onPointerUp: (_) => _set(false),
      onPointerCancel: (_) => _set(false),
      child: AnimatedScale(
        scale: _down ? widget.scale : 1,
        duration: _down ? const Duration(milliseconds: 90) : const Duration(milliseconds: 420),
        curve: _down ? AppTheme.curve : AppTheme.pop,
        child: widget.child,
      ),
    );
  }
}

/// Gives its child a little shake when the pointer comes over it, and whenever [trigger] changes (the bag, as
/// something lands in it).
class Wiggle extends StatefulWidget {
  const Wiggle({super.key, required this.child, this.trigger, this.onHover = true, this.angle = 0.16});

  final Widget child;
  final Object? trigger;
  final bool onHover;

  /// The widest swing, in radians.
  final double angle;

  @override
  State<Wiggle> createState() => _WiggleState();
}

class _WiggleState extends State<Wiggle> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 520));

  void _shake() {
    if (!reduceMotion(context) && !_c.isAnimating) unawaited(_c.forward(from: 0));
  }

  @override
  void didUpdateWidget(Wiggle old) {
    super.didUpdateWidget(old);
    if (old.trigger != widget.trigger) _shake();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: widget.onHover ? (_) => _shake() : null,
    child: AnimatedBuilder(
      animation: _c,
      builder: (context, child) {
        final t = _c.value;
        return Transform.rotate(angle: math.sin(t * math.pi * 4) * widget.angle * (1 - t), child: child);
      },
      child: widget.child,
    ),
  );
}

/// Pops its child, growing past its size and settling back, whenever [value] changes and [when] (by default always)
/// says so: a bag's count going up, a heart being filled.
class PopOnChange extends StatefulWidget {
  const PopOnChange({super.key, required this.value, required this.child, this.when, this.scale = 1.35});

  final Object? value;
  final Widget child;
  final bool Function(Object? before, Object? now)? when;
  final double scale;

  @override
  State<PopOnChange> createState() => _PopOnChangeState();
}

class _PopOnChangeState extends State<PopOnChange> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 520));
  late final Animation<double> _scale = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween<double>(begin: 1, end: widget.scale).chain(CurveTween(curve: Curves.easeOutCubic)),
      weight: 35,
    ),
    TweenSequenceItem(
      tween: Tween(begin: widget.scale, end: 0.92).chain(CurveTween(curve: Curves.easeInOutCubic)),
      weight: 30,
    ),
    TweenSequenceItem(tween: Tween<double>(begin: 0.92, end: 1).chain(CurveTween(curve: Curves.easeOutCubic)), weight: 35),
  ]).animate(_c);

  @override
  void didUpdateWidget(PopOnChange old) {
    super.didUpdateWidget(old);
    if (old.value != widget.value && (widget.when?.call(old.value, widget.value) ?? true) && !reduceMotion(context)) {
      unawaited(_c.forward(from: 0));
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScaleTransition(scale: _scale, child: widget.child);
}

/// Leans its child toward the pointer, a few degrees at most, with a soft gleam where the pointer is. Only a mouse
/// does it (a finger does not hover), and not with reduced motion.
class Tilt extends StatefulWidget {
  const Tilt({super.key, required this.child, this.maxAngle = 0.1, this.radius = AppTheme.radius});

  final Widget child;

  /// The most it leans, in radians (0.1 is about 6 degrees).
  final double maxAngle;
  final double radius;

  @override
  State<Tilt> createState() => _TiltState();
}

class _TiltState extends State<Tilt> {
  Offset? _at;

  void _hover(PointerHoverEvent e) {
    final size = context.size;
    if (size == null || size.isEmpty) return;
    setState(() => _at = Offset((e.localPosition.dx / size.width) * 2 - 1, (e.localPosition.dy / size.height) * 2 - 1));
  }

  @override
  Widget build(BuildContext context) {
    if (reduceMotion(context)) return widget.child;
    return MouseRegion(
      onHover: _hover,
      onExit: (_) => setState(() => _at = null),
      child: TweenAnimationBuilder<Offset>(
        tween: Tween(end: _at ?? Offset.zero),
        duration: AppTheme.hover,
        curve: AppTheme.curve,
        child: widget.child,
        builder: (context, o, child) => Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0011)
            ..rotateX(-o.dy * widget.maxAngle)
            ..rotateY(o.dx * widget.maxAngle),
          child: Stack(
            children: [
              child!,
              Positioned.fill(
                child: IgnorePointer(
                  child: AnimatedOpacity(
                    opacity: _at == null ? 0 : 1,
                    duration: AppTheme.medium,
                    child: DecoratedBox(
                      decoration: ShapeDecoration(
                        shape: AppTheme.shape(widget.radius),
                        gradient: RadialGradient(
                          center: Alignment(o.dx, o.dy),
                          radius: 0.9,
                          colors: [Colors.white.withValues(alpha: 0.18), Colors.white.withValues(alpha: 0)],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Draws a line under its child, from the start edge, while [on]; for a link that keeps its own hover.
class DrawnUnderline extends StatelessWidget {
  const DrawnUnderline({super.key, required this.on, required this.colour, required this.child});

  final bool on;
  final Color colour;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final rtl = Directionality.of(context) == TextDirection.rtl;
    return TweenAnimationBuilder<double>(
      tween: Tween(end: on ? 1 : 0),
      duration: reduceMotion(context) ? Duration.zero : AppTheme.medium,
      curve: AppTheme.curve,
      builder: (context, t, child) => CustomPaint(foregroundPainter: _Underline(t, colour, rtl), child: child),
      child: Padding(padding: const EdgeInsets.only(bottom: 3), child: child),
    );
  }
}

/// A text link whose underline draws itself from the start edge while the pointer is over it.
class UnderlineLink extends StatefulWidget {
  const UnderlineLink({super.key, required this.label, required this.onTap, required this.style, this.line, this.padding = EdgeInsets.zero});

  final String label;
  final VoidCallback onTap;
  final TextStyle? style;

  /// The colour of the underline; the text's own unless given.
  final Color? line;

  /// Room round the words that is part of the tap target.
  final EdgeInsetsGeometry padding;

  @override
  State<UnderlineLink> createState() => _UnderlineLinkState();
}

class _UnderlineLinkState extends State<UnderlineLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final colour = widget.line ?? widget.style?.color ?? Theme.of(context).colorScheme.onSurface;
    return Semantics(
      link: true,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onTap,
          child: Padding(
            padding: widget.padding,
            child: DrawnUnderline(
              on: _hover,
              colour: colour,
              child: Text(widget.label, style: widget.style),
            ),
          ),
        ),
      ),
    );
  }
}

class _Underline extends CustomPainter {
  _Underline(this.t, this.colour, this.rtl);

  final double t;
  final Color colour;
  final bool rtl;

  @override
  void paint(Canvas canvas, Size size) {
    if (t <= 0) return;
    final w = size.width * t;
    final paint = Paint()
      ..color = colour
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;
    final y = size.height - 1;
    if (rtl) {
      canvas.drawLine(Offset(size.width, y), Offset(size.width - w, y), paint);
    } else {
      canvas.drawLine(Offset(0, y), Offset(w, y), paint);
    }
  }

  @override
  bool shouldRepaint(_Underline old) => old.t != t || old.colour != colour || old.rtl != rtl;
}

/// A check mark that draws itself, for a placed order or a saved change.
class DrawnCheck extends StatefulWidget {
  const DrawnCheck({super.key, this.size = 72, this.color = Brand.seedColor});

  final double size;
  final Color color;

  @override
  State<DrawnCheck> createState() => _DrawnCheckState();
}

class _DrawnCheckState extends State<DrawnCheck> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..forward();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // With reduced motion the mark is simply there, already drawn.
    if (reduceMotion(context)) _c.value = 1;
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _c,
    builder: (context, _) => SizedBox.square(
      dimension: widget.size,
      child: CustomPaint(painter: _CheckPainter(Curves.easeOutCubic.transform(_c.value), widget.color)),
    ),
  );
}

class _CheckPainter extends CustomPainter {
  _CheckPainter(this.t, this.color);

  final double t;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final ring = Paint()
      ..color = color.withValues(alpha: 0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.07;
    final arc = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width * 0.07;
    final inner = (Offset.zero & size).deflate(size.width * 0.06);
    canvas.drawOval(inner, ring);
    canvas.drawArc(inner, -math.pi / 2, 2 * math.pi * math.min(1, t * 1.6), false, arc);
    final tick = Path()
      ..moveTo(size.width * 0.28, size.height * 0.52)
      ..lineTo(size.width * 0.44, size.height * 0.67)
      ..lineTo(size.width * 0.73, size.height * 0.35);
    final metric = tick.computeMetrics().first;
    final drawn = ((t - 0.35) / 0.65).clamp(0.0, 1.0);
    canvas.drawPath(metric.extractPath(0, metric.length * drawn), arc..strokeWidth = size.width * 0.085);
  }

  @override
  bool shouldRepaint(_CheckPainter old) => old.t != t || old.color != color;
}

/// Leans toward a mouse pointer that comes over it, a few points at most, and settles back when it leaves: the
/// site's main buttons. Touch screens and reduce motion keep it still.
class Magnetic extends StatefulWidget {
  const Magnetic({super.key, required this.child, this.pull = 0.2, this.reach = 8});

  final Widget child;

  /// How much of the pointer's distance from the centre the child follows.
  final double pull;

  /// The furthest it moves, in points.
  final double reach;

  @override
  State<Magnetic> createState() => _MagneticState();
}

class _MagneticState extends State<Magnetic> {
  Offset _at = Offset.zero;

  @override
  Widget build(BuildContext context) {
    if (reduceMotion(context)) return widget.child;
    return MouseRegion(
      onHover: (e) {
        final box = context.findRenderObject();
        if (box is! RenderBox || !box.hasSize) return;
        final d = (e.localPosition - box.size.center(Offset.zero)) * widget.pull;
        setState(() => _at = Offset(d.dx.clamp(-widget.reach, widget.reach), d.dy.clamp(-widget.reach, widget.reach)));
      },
      onExit: (_) => setState(() => _at = Offset.zero),
      child: TweenAnimationBuilder<Offset>(
        tween: Tween(end: _at),
        duration: AppTheme.hover,
        curve: AppTheme.curve,
        builder: (context, o, child) => Transform.translate(offset: o, child: child),
        child: widget.child,
      ),
    );
  }
}

/// Draws its child in from the start edge (the right in Arabic) once it comes into view: the stitch sewing itself.
class SewIn extends StatelessWidget {
  const SewIn({super.key, required this.child, this.delay = Duration.zero});

  final Widget child;
  final Duration delay;

  @override
  Widget build(BuildContext context) => InView(
    delay: delay,
    duration: AppTheme.slow + AppTheme.hover,
    curve: AppTheme.curve,
    child: child,
    builder: (context, t, child) => ClipRect(
      child: Align(alignment: AlignmentDirectional.centerStart, widthFactor: t.clamp(0.0, 1.0), child: child),
    ),
  );
}

/// A figure such as `100%` that rolls to its value as it comes into view: up from nought, or for a nought, down
/// from 99 (the analyzer's issues going away). A year stays as it is. Tabular figures, so it does not jitter.
class RollingFigure extends StatelessWidget {
  const RollingFigure(this.figure, {super.key, this.style});

  final String figure;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final m = RegExp(r'^(\d+)(.*)$').firstMatch(figure);
    final value = m == null ? null : int.parse(m[1]!);
    if (value == null || value >= 1900) return Text(figure, style: style);
    final from = value == 0 ? 99 : 0;
    return Semantics(
      label: figure,
      child: ExcludeSemantics(
        child: InView(
          duration: AppTheme.hero + AppTheme.slow,
          curve: Curves.easeOutCubic,
          builder: (context, t, _) => Text('${(from + (value - from) * t).round()}${m![2]}', style: style),
        ),
      ),
    );
  }
}
