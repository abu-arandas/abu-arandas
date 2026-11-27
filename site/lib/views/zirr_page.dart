import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart';

import '../config/brand.dart';
import '../config/breakpoints.dart';
import '../config/content.dart';
import '../config/routes.dart';
import '../config/theme.dart';
import '../controllers/site_controller.dart';
import '../models/content.dart';
import '../widgets/blocks.dart';
import '../widgets/fun.dart';
import '../widgets/motion.dart';
import '../widgets/site_scaffold.dart';

/// Zirr, Arandas Tech's product line for shops: what the name means, the four products and why shops pick them.
class ZirrPage extends StatelessWidget {
  const ZirrPage({super.key});

  @override
  Widget build(BuildContext context) => SiteScaffold(
    current: Routes.zirr,
    sections: [
      PageHero(
        eyebrow: 'Zirr by Arandas Tech',
        title: 'Zirr: the software a shop runs on',
        body: 'Zirr is our product line for retail: a till for every branch, the stock behind it, the online store, and the starter we build new apps from. Every product is made, run and supported by Arandas Tech in Amman.',
        actions: [
          const SiteLink('See Zirr Retail', Routes.retail),
          SiteLink('Book a free demo', Brand.whatsAppLink('Hi Arandas Tech team, I would like a demo of Zirr.'.tr)),
        ],
        aside: const _NameCard(),
      ),
      const PageSection(
        tinted: true,
        eyebrow: 'Which Zirr fits you?',
        title: 'Tell us what you run',
        subtitle: 'Pick the closest. We point you to the product, and you can try it or book a demo from there.',
        child: _ShopFinder(),
      ),
      PageSection(
        eyebrow: 'The Zirr line',
        title: 'Four products, one team behind them',
        child: GridRow(gutter: 20, children: [for (final product in Content.zirrProducts) GridCol(md: 6, child: CaseStudyCard(product, hasPage: false))]),
      ),
      const PageSection(eyebrow: 'Why shops pick Zirr', title: 'Made for how shops here work', child: FeatureGrid(Content.zirrReasons)),
      const CallToAction(
        title: 'Want to see Zirr in your shop?',
        body: 'We show you the till, the stock and the online store on a call, in Arabic or English, and set it up for you in Amman.',
      ),
    ],
  );
}

/// What the name means, beside the hero: the Zirr button, which presses in when tapped.
class _NameCard extends StatefulWidget {
  const _NameCard();

  @override
  State<_NameCard> createState() => _NameCardState();
}

class _NameCardState extends State<_NameCard> {
  int _presses = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: EdgeInsets.all(context.responsive<double>(24, lg: 40)),
        child: Column(
          children: [
            Semantics(
              button: true,
              label: 'Press the Zirr button'.tr,
              child: GestureDetector(
                onTap: () => setState(() => _presses++),
                child: Wiggle(trigger: _presses, child: const ZirrButton(size: 132)),
              ),
            ),
            const SizedBox(height: 20),
            Text(Brand.productLineAr, style: theme.textTheme.displaySmall?.copyWith(color: theme.colorScheme.primary)),
            const SizedBox(height: 8),
            Text(
              'Zirr means “button”: the one on a shirt, and the one on a screen.'.tr,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            if (_presses > 0) ...[
              const SizedBox(height: 12),
              Text(
                funLine(['Pressed. It likes that.'.tr, 'Click. Every sale starts like this.'.tr]),
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.primary),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// "What do you run?": a row of choices, and the Zirr product that fits the one picked, which pops in as the choice
/// changes. The first choice is picked to begin with, so the answer is never empty.
class _ShopFinder extends StatefulWidget {
  const _ShopFinder();

  @override
  State<_ShopFinder> createState() => _ShopFinderState();
}

class _ShopFinderState extends State<_ShopFinder> {
  int _picked = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final site = Get.find<SiteController>();
    final fit = Content.zirrFits[_picked];
    final product = Content.zirrProducts.firstWhere((p) => p.slug == fit.slug);
    final demo = Content.demoFor(product.slug) != null ? SiteLink('Book a free demo', '${Routes.contact}?about=${product.slug}') : null;
    final still = reduceMotion(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final (i, f) in Content.zirrFits.indexed)
              Squish(
                child: ChoiceChip(label: Text(f.shop.tr), selected: i == _picked, showCheckmark: false, onSelected: (_) => setState(() => _picked = i)),
              ),
          ],
        ),
        const SizedBox(height: 24),
        AnimatedSwitcher(
          duration: still ? Duration.zero : AppTheme.slow,
          switchInCurve: AppTheme.pop,
          switchOutCurve: AppTheme.curve,
          layoutBuilder: (current, previous) => Stack(children: [...previous, ?current]),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.94, end: 1).animate(animation),
              alignment: AlignmentDirectional.topStart.resolve(Directionality.of(context)),
              child: child,
            ),
          ),
          child: HoverLift(
            key: ValueKey(_picked),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(context.responsive<double>(24, lg: 32)),
                child: GridRow(
                  gutter: 24,
                  children: [
                    GridCol(
                      lg: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Eyebrow(product.sector),
                          const SizedBox(height: 8),
                          Text(product.title.tr, style: theme.textTheme.headlineMedium?.copyWith(color: scheme.primary)),
                          const SizedBox(height: 12),
                          Text(fit.why.tr, style: theme.textTheme.titleMedium),
                          const SizedBox(height: 8),
                          Text(product.summary.tr, style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant)),
                        ],
                      ),
                    ),
                    GridCol(
                      lg: 4,
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        alignment: context.isDesktop ? WrapAlignment.end : WrapAlignment.start,
                        children: [
                          if (product.links.firstOrNull case final link?)
                            Magnetic(
                              child: Squish(
                                child: FilledButton(onPressed: () => site.open(link.url), child: Text(link.label.tr)),
                              ),
                            ),
                          if (demo != null)
                            Squish(
                              child: OutlinedButton(onPressed: () => site.open(demo.url), child: Text(demo.label.tr)),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
