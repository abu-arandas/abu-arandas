import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart';

import '../config/brand.dart';
import '../config/content.dart';
import '../models/content.dart';
import '../widgets/blocks.dart';
import '../widgets/site_scaffold.dart';

/// One policy (terms, privacy or refunds): its parts in a readable column, when it last changed, and the way to the
/// other two.
class LegalPage extends StatelessWidget {
  const LegalPage(this.doc, {super.key});

  final LegalDoc doc;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant);
    return SiteScaffold(
      current: doc.route,
      sections: [
        PageSection(
          eyebrow: 'Policies',
          title: doc.title,
          subtitle: doc.summary,
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Content.legalUpdated.tr, style: muted),
                  if (Brand.registrationNumber != null) Text('Trade register number: @number'.trParams({'number': Brand.registrationNumber!}), style: muted),
                  for (final part in doc.parts) _Part(part),
                  const SizedBox(height: 40),
                  LinkButtons([for (final other in Content.legal.where((d) => d != doc)) SiteLink(other.title, other.route)]),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Part extends StatelessWidget {
  const _Part(this.part);

  final LegalPart part;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Text(part.heading.tr, style: theme.textTheme.titleLarge),
        for (final paragraph in part.paragraphs) ...[const SizedBox(height: 10), Text(paragraph.tr, style: theme.textTheme.bodyLarge?.copyWith(height: 1.7))],
      ],
    );
  }
}
