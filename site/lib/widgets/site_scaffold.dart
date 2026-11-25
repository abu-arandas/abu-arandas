import 'dart:async';

import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart';

import '../config/brand.dart';
import '../config/breakpoints.dart';
import '../config/routes.dart';
import '../config/theme.dart';
import '../controllers/site_controller.dart';
import 'confetti.dart';
import 'fun.dart';
import 'language_button.dart';
import 'motion.dart';

/// The site's main pages, as the header and the menu list them.
const navItems = [(Routes.services, 'Flutter services'), (Routes.zirr, Brand.productLine), (Routes.work, 'Work'), (Routes.contact, 'Contact')];

/// Builds [page] again from the top when the language changes, so every `.tr` text is read in the new language: the
/// ones the page reads while building (a WhatsApp message it puts in a link) as well as its sections'. Every route
/// wraps its page in one (`lib/config/routes.dart`).
class LanguageBound extends StatelessWidget {
  const LanguageBound(this.page, {super.key});

  final Widget page;

  @override
  Widget build(BuildContext context) {
    final site = Get.find<SiteController>();
    return Obx(() => KeyedSubtree(key: ValueKey(site.locale.value), child: page));
  }
}

/// Every page's frame: the header with the menu, the page's [sections] one under another, and the footer.
class SiteScaffold extends StatelessWidget {
  const SiteScaffold({required this.current, required this.sections, super.key});

  /// The address of the page, to mark it in the menu.
  final String current;
  final List<Widget> sections;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: _Header(current: current),
    endDrawer: context.isDesktop ? null : _Menu(current: current),
    body: SelectionArea(child: ListView(children: [...sections, const _Footer()])),
  );
}

/// The logo, which takes the visitor home and keeps a secret: press it five times in a row and Zirr's shirt buttons
/// rain down, with a short line to say thanks. The mark gives a little shake under the pointer and on every press.
class _Logo extends StatefulWidget {
  const _Logo();

  @override
  State<_Logo> createState() => _LogoState();
}

class _LogoState extends State<_Logo> {
  // Counted across pages, since the first press on another page goes home.
  static int _taps = 0;
  static DateTime _last = DateTime(0);

  void _tap() {
    final now = DateTime.now();
    _taps = now.difference(_last) < const Duration(milliseconds: 1500) ? _taps + 1 : 1;
    _last = now;
    setState(() {});
    if (_taps >= 5) {
      _taps = 0;
      celebrate(context, kind: Celebration.buttons);
      ScaffoldMessenger.maybeOf(context)
        ?..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(funLine(['Five presses! Zirr’s buttons say thank you.'.tr, 'You found the secret. Buttons for everyone.'.tr]))));
    }
    unawaited(Get.find<SiteController>().open(Routes.home));
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: _tap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ExcludeSemantics(
              child: Wiggle(
                trigger: _taps,
                child: CustomPaint(
                  size: const Size.square(34),
                  painter: _CompanyMark(tile: scheme.primary, letter: scheme.surface, lit: scheme.secondary),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(Brand.wordmark.tr, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.5)),
          ],
        ),
      ),
    );
  }
}

/// The Arandas Tech mark on a 120-unit grid: a denim tile with continuous corners and a white A whose crossbar is an
/// orange button, the company's nod to its Zirr line. web/favicon.svg and the boot screen in web/index.html draw the
/// same shape.
class _CompanyMark extends CustomPainter {
  const _CompanyMark({required this.tile, required this.letter, required this.lit});

  final Color tile;
  final Color letter;
  final Color lit;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = letter
      ..style = PaintingStyle.stroke
      ..strokeWidth = 13
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas
      ..save()
      ..scale(size.shortestSide / 120)
      ..drawRSuperellipse(RSuperellipse.fromRectAndRadius(const Rect.fromLTWH(4, 4, 112, 112), const Radius.circular(34)), Paint()..color = tile)
      ..drawPath(
        Path()
          ..moveTo(32, 90)
          ..lineTo(60, 30)
          ..lineTo(88, 90),
        stroke,
      )
      ..drawCircle(const Offset(60, 72), 10, Paint()..color = lit)
      ..restore();
  }

  @override
  bool shouldRepaint(_CompanyMark old) => old.tile != tile || old.letter != letter || old.lit != lit;
}

class _Header extends StatelessWidget implements PreferredSizeWidget {
  const _Header({required this.current});

  final String current;

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    final site = Get.find<SiteController>();
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surface,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: scheme.outlineVariant)),
        ),
        child: SafeArea(
          bottom: false,
          child: SizedBox(
            height: 72,
            child: GridContainer(
              child: SizedBox(
                height: 72,
                child: _FirstEntrance(
                  child: Row(
                    children: [
                      const _Logo(),
                      const Spacer(),
                      if (context.isDesktop) ...[
                        for (final (route, label) in navItems)
                          TextButton(
                            onPressed: () => site.open(route),
                            style: TextButton.styleFrom(foregroundColor: _isCurrent(route) ? scheme.primary : scheme.onSurface),
                            child: Text(label.tr, style: TextStyle(fontWeight: _isCurrent(route) ? FontWeight.w600 : FontWeight.w400)),
                          ),
                        const SizedBox(width: 8),
                        const LanguageButton(),
                        const SizedBox(width: 8),
                        Magnetic(
                          child: Squish(
                            child: FilledButton(
                              onPressed: () => site.open(Brand.whatsAppLink('Hi Arandas Tech team, I found you on your website.'.tr)),
                              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
                              child: Text('Talk to us'.tr),
                            ),
                          ),
                        ),
                      ] else ...[
                        const LanguageButton(),
                        Builder(
                          builder: (context) =>
                              IconButton(tooltip: 'Menu'.tr, icon: const Icon(Icons.menu), onPressed: () => Scaffold.of(context).openEndDrawer()),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isCurrent(String route) => current == route || current.startsWith('$route/');
}

/// Slides the header's contents down into place on the first page of a visit, not on every page after it.
class _FirstEntrance extends StatelessWidget {
  const _FirstEntrance({required this.child});

  static bool _played = false;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (_played) return child;
    WidgetsBinding.instance.addPostFrameCallback((_) => _played = true);
    return Appear(offset: const Offset(0, -10), child: child);
  }
}

class _Menu extends StatelessWidget {
  const _Menu({required this.current});

  final String current;

  @override
  Widget build(BuildContext context) {
    final site = Get.find<SiteController>();
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Align(alignment: AlignmentDirectional.centerStart, child: _Logo()),
            const SizedBox(height: 16),
            for (final (route, label) in [(Routes.home, 'Home'), ...navItems])
              ListTile(
                title: Text(label.tr),
                selected: current == route,
                shape: AppTheme.shape(10),
                onTap: () {
                  Navigator.of(context).pop();
                  site.open(route);
                },
              ),
            const SizedBox(height: 16),
            FilledButton(onPressed: () => site.open(Brand.whatsAppLink('Hi Arandas Tech team, I found you on your website.'.tr)), child: Text('Talk to us'.tr)),
          ],
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final site = Get.find<SiteController>();
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant);
    return ColoredBox(
      color: theme.colorScheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: GridContainer(
          child: GridRow(
            gutter: 32,
            children: [
              GridCol(
                md: 6,
                child: Reveal(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _Logo(),
                      const SizedBox(height: 12),
                      Text('A software company in Amman. We build Flutter apps and make Zirr, software for shops.'.tr, style: muted),
                      const SizedBox(height: 4),
                      Text(Brand.city.tr, style: muted),
                    ],
                  ),
                ),
              ),
              GridCol(
                xs: 6,
                md: 3,
                child: Reveal(
                  delay: staggerOf(context) * 1.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pages'.tr, style: theme.textTheme.titleSmall),
                      for (final (route, label) in navItems) _FooterLink(label: label.tr, onTap: () => site.open(route)),
                    ],
                  ),
                ),
              ),
              GridCol(
                xs: 6,
                md: 3,
                child: Reveal(
                  delay: staggerOf(context) * 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Elsewhere'.tr, style: theme.textTheme.titleSmall),
                      _FooterLink(label: 'WhatsApp'.tr, onTap: () => site.open(Brand.whatsAppLink())),
                      _FooterLink(label: 'Facebook'.tr, onTap: () => site.open(Brand.facebook)),
                      _FooterLink(label: 'GitHub'.tr, onTap: () => site.open(Brand.github)),
                    ],
                  ),
                ),
              ),
              GridCol(
                child: Wrap(
                  spacing: 16,
                  runSpacing: 4,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Text('© @year @name. Built with Flutter.'.trParams({'year': '${DateTime.now().year}', 'name': Brand.name.tr}), style: muted),
                    Text('Made in Amman, one button at a time.'.tr, style: muted),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => UnderlineLink(
    label: label,
    onTap: onTap,
    style: Theme.of(context).textTheme.bodyMedium,
    line: Theme.of(context).colorScheme.secondary,
    padding: const EdgeInsets.only(top: 8, bottom: 4),
  );
}
