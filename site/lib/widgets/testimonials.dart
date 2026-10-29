import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/breakpoints.dart';
import '../config/content.dart';
import 'blocks.dart';

/// What clients say, from [Content.testimonials]. Shows nothing while there are none.
class Testimonials extends StatelessWidget {
  const Testimonials({super.key});

  @override
  Widget build(BuildContext context) {
    if (Content.testimonials.isEmpty) return const SizedBox.shrink();
    final theme = Theme.of(context);
    return PageSection(
      eyebrow: 'Clients',
      title: 'What clients say',
      child: GridRow(
        gutter: 20,
        children: [
          for (final t in Content.testimonials)
            GridCol(
              md: 6,
              lg: 4,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.format_quote, color: theme.colorScheme.primary),
                      const SizedBox(height: 8),
                      Text(t.quote.tr, style: theme.textTheme.bodyLarge),
                      const SizedBox(height: 16),
                      Text(t.name, style: theme.textTheme.titleSmall),
                      Text(t.role.tr, style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
