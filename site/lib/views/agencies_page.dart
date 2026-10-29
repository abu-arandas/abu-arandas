import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/brand.dart';
import '../config/breakpoints.dart';
import '../config/content.dart';
import '../config/routes.dart';
import '../models/content.dart';
import '../widgets/blocks.dart';
import '../widgets/site_scaffold.dart';

/// The white-label Flutter team, for agencies that sell apps and need people to build them.
class AgenciesPage extends StatelessWidget {
  const AgenciesPage({super.key});

  @override
  Widget build(BuildContext context) => SiteScaffold(
    current: Routes.agencies,
    sections: [
      PageHero(
        eyebrow: 'For agencies and software houses',
        title: 'A white-label Flutter team, under your name',
        body: 'You win the client and own the relationship. We design, build, test and ship the Flutter app, in Arabic and English, and hand it over as yours.',
        actions: [
          SiteLink('Send us a brief', Brand.whatsAppLink('Hi Arandas Tech, we are an agency and would like to talk about a Flutter project.'.tr)),
          const SiteLink('See our work', Routes.work),
        ],
        aside: const _WhoWeAre(),
      ),
      const PageSection(eyebrow: 'Why agencies use us', title: 'Everything you need to resell our work', child: FeatureGrid(Content.agencyBenefits)),
      const PageSection(
        tinted: true,
        eyebrow: 'Ways to work',
        title: 'Pick how we work with you',
        subtitle: 'Prices depend on the scope. Send a brief and you get a written quote within two working days.',
        child: OfferGrid(Content.agencyOffers, highlight: 1),
      ),
      const PageSection(eyebrow: 'How it works', title: 'From brief to handover', child: FeatureGrid(Content.agencySteps, columns: 4, numbered: true)),
      const PageSection(tinted: true, eyebrow: 'Our quality bar', title: 'The standard your client gets', child: FeatureGrid(Content.qualityBar)),
      const PageSection(eyebrow: 'Questions', title: 'What agencies ask us', child: _Faqs(Content.agencyFaqs)),
      const CallToAction(
        title: 'Have a client waiting?',
        body: 'Send the brief on WhatsApp. We sign an NDA first if you need one, and quote within two working days.',
      ),
    ],
  );
}

class _WhoWeAre extends StatelessWidget {
  const _WhoWeAre();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('What you get'.tr, style: theme.textTheme.titleLarge),
            const SizedBox(height: 20),
            const CheckList(Content.agencyIncludes),
            const SizedBox(height: 8),
            Text('Based in Amman, UTC+3.'.tr, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}

class _Faqs extends StatelessWidget {
  const _Faqs(this.faqs);

  final List<Faq> faqs;

  @override
  Widget build(BuildContext context) => ConstrainedBox(
    constraints: BoxConstraints(maxWidth: context.isDesktop ? 860 : double.infinity),
    child: Column(
      children: [
        for (final faq in faqs)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: ExpansionTile(
                shape: const Border(),
                title: Text(faq.question.tr, style: const TextStyle(fontWeight: FontWeight.w600)),
                childrenPadding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
                expandedAlignment: AlignmentDirectional.centerStart,
                children: [Text(faq.answer.tr)],
              ),
            ),
          ),
      ],
    ),
  );
}
