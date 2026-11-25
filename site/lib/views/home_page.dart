import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart';

import '../config/breakpoints.dart';
import '../config/content.dart';
import '../config/routes.dart';
import '../models/content.dart';
import '../widgets/blocks.dart';
import '../widgets/motion.dart';
import '../widgets/site_scaffold.dart';
import '../widgets/testimonials.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => SiteScaffold(
    current: Routes.home,
    sections: [
      const PageHero(
        eyebrow: 'Arandas Tech · software company in Amman',
        title: 'Software for businesses that work in Arabic and English',
        body: 'We build Flutter apps for companies and agencies, and we make Zirr, our own line of software that shops run on: the till, the stock, the online store.',
        actions: [SiteLink('See our Flutter services', Routes.services), SiteLink('Meet Zirr', Routes.zirr)],
        image: 'assets/images/zirr-retail.jpg',
      ),
      const _Stats(),
      const PageSection(eyebrow: 'What we do', title: 'Three ways to work with us', child: FeatureGrid(Content.services)),
      PageSection(
        tinted: true,
        eyebrow: 'Our products',
        title: 'Zirr, our software for shops',
        subtitle: 'Four products from one team, built and checked to the same bar as our client work, in Arabic and English.',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridRow(gutter: 20, children: [for (final product in Content.zirrProducts) GridCol(md: 6, lg: 3, child: CaseStudyCard(product, hasPage: false))]),
            const SizedBox(height: 24),
            const LinkButtons([SiteLink('Meet Zirr', Routes.zirr)]),
          ],
        ),
      ),
      const PageSection(
        eyebrow: 'Our quality bar',
        title: 'What every project ships with',
        subtitle: 'The same rules hold for our own products and for the apps we build for you.',
        child: FeatureGrid(Content.qualityBar),
      ),
      PageSection(
        tinted: true,
        eyebrow: 'Case studies',
        title: 'Recent work',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridRow(gutter: 20, children: [for (final study in Content.caseStudies.take(3)) GridCol(md: 6, lg: 4, child: CaseStudyCard(study))]),
            const SizedBox(height: 24),
            const LinkButtons([SiteLink('All case studies', Routes.work)]),
          ],
        ),
      ),
      const Testimonials(),
      const CallToAction(),
    ],
  );
}

class _Stats extends StatelessWidget {
  const _Stats();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: GridContainer(
        child: GridRow(
          gutter: 24,
          children: [
            for (final (figure, label) in Content.homeStats)
              GridCol(
                xs: 6,
                lg: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // The figures roll to their real values as the band comes into view (the year stays put, the
                    // analyzer count counts down to its zero).
                    RollingFigure(
                      figure,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(label.tr, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
