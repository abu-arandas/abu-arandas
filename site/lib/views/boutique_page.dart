import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart';

import '../config/breakpoints.dart';
import '../config/content.dart';
import '../config/routes.dart';
import '../widgets/blocks.dart';
import '../widgets/motion.dart';
import '../widgets/site_scaffold.dart';

/// Zirr Boutique: the fashion storefront and its back office, sold as source code under a Regular or Extended
/// licence. Its public demo is the live store.
class BoutiquePage extends StatelessWidget {
  const BoutiquePage({super.key});

  @override
  Widget build(BuildContext context) => SiteScaffold(
    current: Routes.boutique,
    sections: [
      const PageHero(
        eyebrow: 'Zirr Boutique · for fashion brands online',
        title: 'An online store that dresses as well as your brand',
        body: 'Zirr Boutique is a fashion storefront with its own back office: colour and size variants with their own stock, promotion codes with rules, and card checkout. Buy the source code and launch it under your name.',
        actions: Content.boutiqueLinks,
        image: 'assets/images/zirr-boutique.jpg',
      ),
      const PageSection(eyebrow: 'Features', title: 'Made for clothes, not for everything', child: FeatureGrid(Content.boutiqueFeatures)),
      PageSection(
        tinted: true,
        child: GridRow(
          gutter: 48,
          children: [
            GridCol(
              lg: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Eyebrow('In the box'),
                  const SizedBox(height: 8),
                  Text('What you get with the code'.tr, style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 24),
                  const CheckList(Content.boutiqueInTheBox),
                ],
              ),
            ),
            const GridCol(
              lg: 7,
              child: Reveal(child: Screenshot('assets/images/boutique-admin.jpg', label: 'The Zirr Boutique back office dashboard')),
            ),
          ],
        ),
      ),
      const PageSection(
        eyebrow: 'Licences',
        title: 'One store, or one for a client',
        subtitle: 'Each licence covers one store with its own web address and database. Message us to buy: we send a PayPal invoice, then the code by email.',
        child: OfferGrid(Content.boutiqueOffers, highlight: 0),
      ),
      const CallToAction(title: 'Want a tour of the store?', body: 'We walk you through the shop and its back office on a call, in Arabic or English.'),
    ],
  );
}
