import 'package:flutter/material.dart';

import 'brand.dart';

/// Light and dark themes, both made from [Brand.seedColor], with the brand's own denim, thread orange and page colours.
class AppTheme {
  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final dark = brightness == Brightness.dark;
    final scheme = ColorScheme.fromSeed(seedColor: Brand.seedColor, brightness: brightness, dynamicSchemeVariant: DynamicSchemeVariant.fidelity).copyWith(
      primary: dark ? Brand.seedColorDark : Brand.seedColor,
      onPrimary: dark ? Brand.pageDark : Colors.white,
      secondary: dark ? Brand.threadDark : Brand.thread,
      onSecondary: const Color(0xFF18202E),
      surface: dark ? Brand.pageDark : Brand.page,
    );
    final base = ThemeData(colorScheme: scheme, fontFamily: Brand.fontFamily, scaffoldBackgroundColor: scheme.surface);
    return base.copyWith(
      textTheme: base.textTheme.copyWith(
        displaySmall: base.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800, height: 1.2),
        headlineMedium: base.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
        titleLarge: base.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        bodyLarge: base.textTheme.bodyLarge?.copyWith(height: 1.6),
        bodyMedium: base.textTheme.bodyMedium?.copyWith(height: 1.6),
      ),
      inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18))),
      outlinedButtonTheme: OutlinedButtonThemeData(style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18))),
    );
  }
}
