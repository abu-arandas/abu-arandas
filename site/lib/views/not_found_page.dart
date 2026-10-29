import 'package:flutter/material.dart';

import '../models/content.dart';
import '../widgets/blocks.dart';
import '../widgets/site_scaffold.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) => const SiteScaffold(
    current: '',
    sections: [
      PageHero(
        eyebrow: 'Page not found',
        title: 'This page does not exist',
        body: 'The link may be old, or the address mistyped.',
        actions: [SiteLink('Go to the home page', '/')],
      ),
    ],
  );
}
