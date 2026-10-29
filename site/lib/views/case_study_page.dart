import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/breakpoints.dart';
import '../config/content.dart';
import '../config/routes.dart';
import '../widgets/blocks.dart';
import '../widgets/site_scaffold.dart';
import 'not_found_page.dart';

/// One case study: the problem, what was built, and the results.
class CaseStudyPage extends StatelessWidget {
  const CaseStudyPage({required this.slug, super.key});

  final String slug;

  @override
  Widget build(BuildContext context) {
    final study = Content.caseStudy(slug);
    if (study == null) return const NotFoundPage();
    final theme = Theme.of(context);
    return SiteScaffold(
      current: Routes.caseStudy(slug),
      sections: [
        PageHero(eyebrow: study.sector, title: study.title, body: study.summary, actions: study.links, image: study.image),
        PageSection(
          child: GridRow(
            gutter: 48,
            children: [
              GridCol(
                lg: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Eyebrow('The challenge'),
                    const SizedBox(height: 12),
                    Text(study.challenge.tr, style: theme.textTheme.bodyLarge),
                    const SizedBox(height: 24),
                    const Eyebrow('Stack'),
                    const SizedBox(height: 12),
                    StackChips(study.stack),
                  ],
                ),
              ),
              GridCol(
                lg: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [const Eyebrow('What we built'), const SizedBox(height: 12), CheckList(study.built)],
                ),
              ),
              GridCol(
                lg: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [const Eyebrow('Results'), const SizedBox(height: 12), CheckList(study.results)],
                ),
              ),
            ],
          ),
        ),
        PageSection(
          tinted: true,
          title: 'More case studies',
          child: GridRow(
            gutter: 20,
            children: [for (final other in Content.caseStudies.where((c) => c.slug != slug)) GridCol(md: 6, lg: 4, child: CaseStudyCard(other))],
          ),
        ),
        const CallToAction(),
      ],
    );
  }
}
