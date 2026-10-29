import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/breakpoints.dart';
import '../config/content.dart';
import '../config/routes.dart';
import '../widgets/blocks.dart';
import '../widgets/site_scaffold.dart';

/// Marcat: the online shop, back office and point of sale, sold as source code. Its public demo is the ERP House shop.
class MarcatPage extends StatelessWidget {
  const MarcatPage({super.key});

  @override
  Widget build(BuildContext context) => SiteScaffold(
    current: Routes.marcat,
    sections: [
      PageHero(
        eyebrow: 'Marcat · for fashion retail',
        title: 'Your online shop, tills and stock in one Flutter app',
        body: 'Marcat runs a fashion retailer end to end: the website, a point of sale in every branch, stock across stores, purchasing and the books, on one Supabase database. Buy the source code and ship it under your brand.',
        actions: Content.marcatLinks.take(2).toList(),
        image: 'assets/images/arandas-erp.jpg',
      ),
      const PageSection(eyebrow: 'Features', title: 'One system instead of five', child: FeatureGrid(Content.marcatFeatures)),
      PageSection(
        tinted: true,
        child: GridRow(
          gutter: 48,
          children: [
            GridCol(
              lg: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Eyebrow('In the box'),
                  const SizedBox(height: 8),
                  Text('What you get with the code'.tr, style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 24),
                  const CheckList(Content.marcatInTheBox),
                ],
              ),
            ),
            const GridCol(lg: 6, child: _Figures()),
          ],
        ),
      ),
      PageSection(
        eyebrow: 'Pricing',
        title: 'Pay once for the code, or let us run it for you',
        subtitle: 'Licences are paid through PayPal. Within 24 hours you get the latest version by email, with your licence inside.',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const OfferGrid(Content.marcatOffers, highlight: 1),
            const SizedBox(height: 16),
            LinkButtons([Content.marcatLinks.last]),
          ],
        ),
      ),
      const CallToAction(title: 'Want a walkthrough first?', body: 'We show you the shop, the back office and the till on a call, in Arabic or English.'),
    ],
  );
}

/// Marcat's numbers, as large figures.
class _Figures extends StatelessWidget {
  const _Figures();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final figures = [
      ('68%', 'test coverage, with an end-to-end sale in an integration test'.tr),
      ('39', 'staff permissions, so each role sees only its own pages'.tr),
      ('2', 'currencies and countries in the sample shop, Jordan and the UAE'.tr),
      ('3', 'apps in one: the shop, the back office and the till'.tr),
    ];
    return GridRow(
      gutter: 20,
      children: [
        for (final (figure, label) in figures)
          GridCol(
            xs: 6,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(figure, style: theme.textTheme.displaySmall?.copyWith(color: theme.colorScheme.primary)),
                    const SizedBox(height: 8),
                    Text(label, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
