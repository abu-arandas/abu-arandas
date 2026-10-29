import 'package:flutter/material.dart';

import '../models/content.dart';

/// The Material icon for each [Glyph].
const glyphIcons = {
  Glyph.team: Icons.groups_outlined,
  Glyph.brand: Icons.palette_outlined,
  Glyph.code: Icons.code,
  Glyph.shield: Icons.shield_outlined,
  Glyph.language: Icons.translate,
  Glyph.test: Icons.fact_check_outlined,
  Glyph.docs: Icons.description_outlined,
  Glyph.rocket: Icons.rocket_launch_outlined,
  Glyph.store: Icons.storefront_outlined,
  Glyph.pos: Icons.point_of_sale_outlined,
  Glyph.stock: Icons.inventory_2_outlined,
  Glyph.chart: Icons.insights_outlined,
  Glyph.calendar: Icons.event_available_outlined,
  Glyph.chat: Icons.chat_outlined,
  Glyph.receipt: Icons.receipt_long_outlined,
  Glyph.lock: Icons.lock_outline,
  Glyph.phone: Icons.phone_iphone,
  Glyph.handshake: Icons.handshake_outlined,
};

/// A [Glyph] in a tinted rounded square.
class GlyphIcon extends StatelessWidget {
  const GlyphIcon(this.glyph, {super.key});

  final Glyph glyph;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Icon(glyphIcons[glyph], color: scheme.onPrimaryContainer),
      ),
    );
  }
}
