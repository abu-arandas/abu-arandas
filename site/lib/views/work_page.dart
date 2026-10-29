import 'package:flutter/material.dart';

import '../config/breakpoints.dart';
import '../config/content.dart';
import '../config/routes.dart';
import '../widgets/blocks.dart';
import '../widgets/site_scaffold.dart';

/// Every case study, then the products that have no case study of their own.
class WorkPage extends StatelessWidget {
  const WorkPage({super.key});

  @override
  Widget build(BuildContext context) => SiteScaffold(
    current: Routes.work,
    sections: [
      PageSection(
        eyebrow: 'Case studies',
        title: 'What we have built',
        subtitle: 'Products we built and run, with the problem each one solves and what it achieved.',
        child: GridRow(gutter: 20, children: [for (final study in Content.caseStudies) GridCol(md: 6, child: CaseStudyCard(study))]),
      ),
      PageSection(
        tinted: true,
        eyebrow: 'Also from us',
        title: 'Other products',
        child: GridRow(gutter: 20, children: [for (final product in Content.otherProducts) GridCol(md: 6, child: CaseStudyCard(product, hasPage: false))]),
      ),
      const CallToAction(),
    ],
  );
}
