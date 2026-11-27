import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart';

import '../config/breakpoints.dart';
import '../config/content.dart';
import '../config/routes.dart';
import '../widgets/blocks.dart';
import '../widgets/motion.dart';
import '../widgets/site_scaffold.dart';

/// Zirr POS: the till for shops, cafés and restaurants, set up in the shop for one price. Its public demo runs in the
/// browser with nothing to install.
class PosPage extends StatelessWidget {
  const PosPage({super.key});

  @override
  Widget build(BuildContext context) => SiteScaffold(
    current: Routes.pos,
    sections: [
      const PageHero(
        eyebrow: 'Zirr POS · for shops, cafés and restaurants',
        title: 'A till that keeps selling when the internet drops',
        body: 'Zirr POS saves every sale on the device first, so the queue keeps moving offline. Barcodes, split payments, shifts, stock and, for cafés, tables and a kitchen screen. We install it in your shop for one price, with no monthly fee.',
        actions: Content.posLinks,
        image: 'assets/images/pos-register.png',
      ),
      const PageSection(eyebrow: 'Features', title: 'Everything at the counter, nothing in the way', child: FeatureGrid(Content.posFeatures)),
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
                  const Eyebrow('Set up for you'),
                  const SizedBox(height: 8),
                  Text('What we do in your shop'.tr, style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 24),
                  const CheckList(Content.posInTheBox),
                ],
              ),
            ),
            const GridCol(
              lg: 7,
              child: Reveal(child: Screenshot('assets/images/pos-arabic.jpg', label: 'Zirr POS in Arabic, with the menu and the cart')),
            ),
          ],
        ),
      ),
      const PageSection(
        eyebrow: 'Pricing',
        title: 'Try it free, then pay once',
        subtitle: 'Prices are for shops in Amman and include the setup visit. Outside Amman, ask us on WhatsApp.',
        child: OfferGrid(Content.posOffers, highlight: 1),
      ),
      const CallToAction(title: 'Want to see it on your counter?', body: 'We show you the till on a call, or at your shop in Amman, in Arabic or English.'),
    ],
  );
}
