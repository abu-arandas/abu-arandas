import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/brand.dart';
import '../config/breakpoints.dart';
import '../config/routes.dart';
import '../controllers/site_controller.dart';
import '../models/content.dart';
import 'glyph_icon.dart';

/// The building blocks every page is made of. Text handed to them is English and is translated here.

/// A band across the page with an optional heading, holding [child] in the grid's container.
class PageSection extends StatelessWidget {
  const PageSection({required this.child, this.title, this.subtitle, this.eyebrow, this.tinted = false, super.key});

  final Widget child;
  final String? title;
  final String? subtitle;

  /// A short label above the title.
  final String? eyebrow;

  /// A tinted background, to set the band apart from its neighbours.
  final bool tinted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final vertical = context.responsive<double>(48, lg: 80);
    return ColoredBox(
      color: tinted ? theme.colorScheme.surfaceContainerLow : theme.colorScheme.surface,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: vertical),
        child: GridContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (eyebrow != null) ...[Eyebrow(eyebrow!), const SizedBox(height: 8)],
              if (title != null) Text(title!.tr, style: theme.textTheme.headlineMedium),
              if (subtitle != null) ...[
                const SizedBox(height: 12),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: Text(subtitle!.tr, style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                ),
              ],
              if (title != null || subtitle != null) const SizedBox(height: 32),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

/// A short coloured label in capitals, above a heading.
class Eyebrow extends StatelessWidget {
  const Eyebrow(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text.tr.toUpperCase(),
      style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary, letterSpacing: 1.2, fontWeight: FontWeight.w700),
    );
  }
}

/// The top of a page: what it is about, why it matters, and what to do next, with a picture beside on wide screens.
class PageHero extends StatelessWidget {
  const PageHero({required this.title, required this.body, this.eyebrow, this.actions = const [], this.image, this.aside, super.key});

  final String title;
  final String body;
  final String? eyebrow;
  final List<SiteLink> actions;

  /// An asset under assets/images, shown beside the text on wide screens and under it on narrow ones.
  final String? image;

  /// Shown in place of [image] when there is none.
  final Widget? aside;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final side = image != null ? Screenshot(image!) : aside;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: [theme.colorScheme.primaryContainer.withValues(alpha: 0.3), theme.colorScheme.surface],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.responsive<double>(48, lg: 96)),
        child: GridContainer(
          child: GridRow(
            gutter: 48,
            children: [
              GridCol(
                lg: side == null ? 9 : 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (eyebrow != null) ...[Eyebrow(eyebrow!), const SizedBox(height: 12)],
                    Text(
                      title.tr,
                      style: context.responsive(theme.textTheme.headlineMedium, lg: theme.textTheme.displaySmall)?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 20),
                    Text(body.tr, style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.6)),
                    if (actions.isNotEmpty) ...[const SizedBox(height: 32), LinkButtons(actions)],
                  ],
                ),
              ),
              if (side != null) GridCol(lg: 6, child: side),
            ],
          ),
        ),
      ),
    );
  }
}

/// [links] as buttons: the first filled, the rest outlined.
class LinkButtons extends StatelessWidget {
  const LinkButtons(this.links, {super.key});

  final List<SiteLink> links;

  @override
  Widget build(BuildContext context) {
    final site = Get.find<SiteController>();
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (final (i, link) in links.indexed)
          if (i == 0)
            FilledButton(onPressed: () => site.open(link.url), child: Text(link.label.tr))
          else
            OutlinedButton(onPressed: () => site.open(link.url), child: Text(link.label.tr)),
      ],
    );
  }
}

/// A picture from assets/images in a rounded frame with a soft shadow.
class Screenshot extends StatelessWidget {
  const Screenshot(this.asset, {this.label, super.key});

  final String asset;

  /// What the picture shows, for screen readers.
  final String? label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant),
        boxShadow: [BoxShadow(color: scheme.shadow.withValues(alpha: 0.12), blurRadius: 32, offset: const Offset(0, 12))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(asset, fit: BoxFit.cover, semanticLabel: label?.tr),
      ),
    );
  }
}

/// [features] as cards in a grid: one column on phones, two on tablets, [columns] on laptops.
class FeatureGrid extends StatelessWidget {
  const FeatureGrid(this.features, {this.columns = 3, this.numbered = false, super.key});

  final List<Feature> features;
  final int columns;

  /// Shows each card's place in the list, for steps.
  final bool numbered;

  @override
  Widget build(BuildContext context) => GridRow(
    gutter: 20,
    children: [
      for (final (i, f) in features.indexed)
        GridCol(
          md: 6,
          lg: 12 ~/ columns,
          child: FeatureCard(f, number: numbered ? i + 1 : null),
        ),
    ],
  );
}

class FeatureCard extends StatelessWidget {
  const FeatureCard(this.feature, {this.number, super.key});

  final Feature feature;
  final int? number;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GlyphIcon(feature.glyph),
                if (number != null) ...[
                  const Spacer(),
                  Text('$number', style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.outlineVariant)),
                ],
              ],
            ),
            const SizedBox(height: 16),
            Text(feature.title.tr, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text(feature.body.tr, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}

/// A list of [items], each after a tick.
class CheckList extends StatelessWidget {
  const CheckList(this.items, {super.key});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Icon(Icons.check_circle, size: 20, color: theme.colorScheme.primary),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(item.tr, style: theme.textTheme.bodyLarge)),
              ],
            ),
          ),
      ],
    );
  }
}

/// [offers] side by side, as price cards.
class OfferGrid extends StatelessWidget {
  const OfferGrid(this.offers, {this.highlight, super.key});

  final List<Offer> offers;

  /// The offer to set apart, by its place in [offers].
  final int? highlight;

  @override
  Widget build(BuildContext context) => GridRow(
    gutter: 20,
    children: [
      for (final (i, o) in offers.indexed)
        GridCol(
          md: offers.length == 2 ? 6 : 12,
          lg: 12 ~/ offers.length,
          child: _OfferCard(o, highlighted: i == highlight),
        ),
    ],
  );
}

class _OfferCard extends StatelessWidget {
  const _OfferCard(this.offer, {required this.highlighted});

  final Offer offer;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final link =
        offer.link ??
        SiteLink('Ask on WhatsApp', Brand.whatsAppLink('Hi Arandas Tech, I would like to know more about: @name'.trParams({'name': offer.name.tr})));
    final site = Get.find<SiteController>();
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: highlighted ? scheme.primary : scheme.outlineVariant, width: highlighted ? 2 : 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(offer.name.tr, style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              offer.price.tr,
              style: theme.textTheme.headlineSmall?.copyWith(color: scheme.primary, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(offer.summary.tr, style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 20),
            CheckList(offer.points),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: highlighted
                  ? FilledButton(onPressed: () => site.open(link.url), child: Text(link.label.tr))
                  : OutlinedButton(onPressed: () => site.open(link.url), child: Text(link.label.tr)),
            ),
          ],
        ),
      ),
    );
  }
}

/// A coloured band asking the visitor to get in touch.
class CallToAction extends StatelessWidget {
  const CallToAction({
    this.title = 'Have a project in mind?',
    this.body = 'Tell us what you are building. We answer on WhatsApp within one working day.',
    super.key,
  });

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final site = Get.find<SiteController>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: GridContainer(
        child: DecoratedBox(
          decoration: BoxDecoration(color: scheme.primary, borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: EdgeInsets.all(context.responsive<double>(28, lg: 56)),
            child: GridRow(
              gutter: 24,
              children: [
                GridCol(
                  lg: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title.tr, style: theme.textTheme.headlineMedium?.copyWith(color: scheme.onPrimary)),
                      const SizedBox(height: 12),
                      Text(body.tr, style: theme.textTheme.bodyLarge?.copyWith(color: scheme.onPrimary.withValues(alpha: 0.85))),
                    ],
                  ),
                ),
                GridCol(
                  lg: 4,
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: context.isDesktop ? WrapAlignment.end : WrapAlignment.start,
                    children: [
                      FilledButton(
                        onPressed: () => site.open(Brand.whatsAppLink('Hi Arandas Tech, I found you on your website.'.tr)),
                        style: FilledButton.styleFrom(backgroundColor: scheme.onPrimary, foregroundColor: scheme.primary),
                        child: Text('Message us on WhatsApp'.tr),
                      ),
                      OutlinedButton(
                        onPressed: () => site.open(Routes.contact),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: scheme.onPrimary,
                          side: BorderSide(color: scheme.onPrimary.withValues(alpha: 0.6)),
                        ),
                        child: Text('Other ways to reach us'.tr),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A case study as a card that opens its page, or [CaseStudy.links] for one without a page.
class CaseStudyCard extends StatelessWidget {
  const CaseStudyCard(this.study, {this.hasPage = true, super.key});

  final CaseStudy study;
  final bool hasPage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final site = Get.find<SiteController>();
    final open = hasPage ? Routes.caseStudy(study.slug) : study.links.firstOrNull?.url;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: open == null ? null : () => site.open(open),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: study.image != null
                  ? Image.asset(study.image!, fit: BoxFit.cover, alignment: Alignment.topCenter)
                  : ColoredBox(
                      color: theme.colorScheme.primaryContainer,
                      child: Center(child: Icon(_sectorIcons[study.slug] ?? Icons.apps, size: 56, color: theme.colorScheme.onPrimaryContainer)),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Eyebrow(study.sector),
                  const SizedBox(height: 8),
                  Text(study.title.tr, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Text(study.summary.tr, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                  const SizedBox(height: 16),
                  StackChips(study.stack),
                  if (open != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      hasPage ? 'Read the case study'.tr : study.links.first.label.tr,
                      style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const _sectorIcons = {'clinic': Icons.local_hospital_outlined, 'starter': Icons.rocket_launch_outlined};
}

/// Names of tools as small chips. Names are not translated.
class StackChips extends StatelessWidget {
  const StackChips(this.names, {super.key});

  final List<String> names;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 6,
    runSpacing: 6,
    children: [
      for (final name in names) Chip(label: Text(name), visualDensity: VisualDensity.compact, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
    ],
  );
}
