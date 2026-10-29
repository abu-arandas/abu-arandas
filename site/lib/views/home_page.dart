import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/breakpoints.dart';
import '../config/content.dart';
import '../config/routes.dart';
import '../models/content.dart';
import '../widgets/blocks.dart';
import '../widgets/site_scaffold.dart';
import '../widgets/testimonials.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => SiteScaffold(
    current: Routes.home,
    sections: [
      const PageHero(
        eyebrow: 'Flutter and Supabase studio in Amman',
        title: 'Flutter apps for agencies, and the products to start them from',
        body: 'We build Arabic and English apps under your agency’s name, and we make our own products for retail and clinics that you can license and ship.',
        actions: [SiteLink('Hire us for your agency', Routes.agencies), SiteLink('See our work', Routes.work)],
        image: 'assets/images/arandas-erp.jpg',
      ),
      const _Stats(),
      const PageSection(eyebrow: 'What we do', title: 'Four ways to work with us', child: FeatureGrid(Content.services, columns: 4)),
      PageSection(
        tinted: true,
        eyebrow: 'Our products',
        title: 'Built, tested and ready to brand',
        subtitle: 'Each product is a working app with its source code, tests and docs, so your next project starts at version one.',
        child: GridRow(
          gutter: 20,
          children: [
            GridCol(lg: 6, child: CaseStudyCard(Content.caseStudy('marcat')!)),
            GridCol(lg: 6, child: CaseStudyCard(Content.caseStudy('clinic')!)),
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
                    Text(
                      figure,
                      style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w800),
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
