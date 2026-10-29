import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/brand.dart';
import '../config/breakpoints.dart';
import '../config/routes.dart';
import '../controllers/site_controller.dart';
import 'language_button.dart';

/// The site's main pages, as the header and the menu list them.
const navItems = [(Routes.agencies, 'For agencies'), (Routes.marcat, 'Marcat'), (Routes.clinic, 'Clinic'), (Routes.work, 'Work'), (Routes.contact, 'Contact')];

/// Every page's frame: the header with the menu, the page's [sections] one under another, and the footer. A change
/// of language builds the page again, so every `.tr` text is read in the new language.
class SiteScaffold extends StatelessWidget {
  const SiteScaffold({required this.current, required this.sections, super.key});

  /// The address of the page, to mark it in the menu.
  final String current;
  final List<Widget> sections;

  @override
  Widget build(BuildContext context) {
    final site = Get.find<SiteController>();
    return Obx(
      () => KeyedSubtree(
        key: ValueKey(site.locale.value),
        child: Scaffold(
          appBar: _Header(current: current),
          endDrawer: context.isDesktop ? null : _Menu(current: current),
          body: SelectionArea(child: ListView(children: [...sections, const _Footer()])),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => Get.find<SiteController>().open(Routes.home),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(color: scheme.primary, borderRadius: BorderRadius.circular(8)),
              child: SizedBox.square(
                dimension: 32,
                child: Center(
                  child: Text(
                    'A',
                    style: TextStyle(color: scheme.onPrimary, fontWeight: FontWeight.w800, fontSize: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(Brand.name.tr, style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ),
    );
  }
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
                child: Row(
                  children: [
                    const _Logo(),
                    const Spacer(),
                    if (context.isDesktop) ...[
                      for (final (route, label) in navItems)
                        TextButton(
                          onPressed: () => site.open(route),
                          style: TextButton.styleFrom(foregroundColor: _isCurrent(route) ? scheme.primary : scheme.onSurface),
                          child: Text(label.tr, style: TextStyle(fontWeight: _isCurrent(route) ? FontWeight.w700 : FontWeight.w500)),
                        ),
                      const SizedBox(width: 8),
                      const LanguageButton(),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: () => site.open(Brand.whatsAppLink('Hi Arandas Tech, I found you on your website.'.tr)),
                        style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
                        child: Text('Talk to us'.tr),
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
    );
  }

  bool _isCurrent(String route) => current == route || current.startsWith('$route/');
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                onTap: () {
                  Navigator.of(context).pop();
                  site.open(route);
                },
              ),
            const SizedBox(height: 16),
            FilledButton(onPressed: () => site.open(Brand.whatsAppLink('Hi Arandas Tech, I found you on your website.'.tr)), child: Text('Talk to us'.tr)),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _Logo(),
                    const SizedBox(height: 12),
                    Text('A Flutter and Supabase studio in Amman, building in Arabic and English.'.tr, style: muted),
                    const SizedBox(height: 4),
                    Text(Brand.city.tr, style: muted),
                  ],
                ),
              ),
              GridCol(
                xs: 6,
                md: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pages'.tr, style: theme.textTheme.titleSmall),
                    for (final (route, label) in navItems) _FooterLink(label: label.tr, onTap: () => site.open(route)),
                  ],
                ),
              ),
              GridCol(
                xs: 6,
                md: 3,
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
              GridCol(child: Text('© @year @name. Built with Flutter.'.trParams({'year': '${DateTime.now().year}', 'name': Brand.name.tr}), style: muted)),
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
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: InkWell(onTap: onTap, child: Text(label)),
  );
}
