import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart';

import '../config/brand.dart';
import '../config/breakpoints.dart';
import '../config/content.dart';
import '../config/routes.dart';
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
      PageSection(
        eyebrow: 'The Zirr line',
        title: 'Four products, one team behind them',
        child: GridRow(gutter: 20, children: [for (final product in Content.zirrProducts) GridCol(md: 6, child: CaseStudyCard(product, hasPage: false))]),
      ),
      const PageSection(tinted: true, eyebrow: 'Why shops pick Zirr', title: 'Made for how shops here work', child: FeatureGrid(Content.zirrReasons)),
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
