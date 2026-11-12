import 'package:material_ui/material_ui.dart';

import 'brand.dart';

/// Light and dark themes, both made from [Brand.seedColor], with the brand's own denim, thread orange and page colours.
///
/// The Zirr house style sits on top of the colours, as in every Zirr product: headings semibold and a touch tight,
/// corners that flow into the sides ([AppTheme.shape]), fields that show their edge under the pointer and turn white
/// with a ring when in use, buttons that rise a little on hover, and calm motion. A rebrand changes [Brand] and keeps
/// all of this.
class AppTheme {
  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  /// A rectangle whose corners flow into its sides (a superellipse) rather than a quarter circle stuck on.
  static RoundedSuperellipseBorder shape(double radius, {BorderSide side = BorderSide.none}) =>
      RoundedSuperellipseBorder(borderRadius: BorderRadius.all(Radius.circular(radius)), side: side);

  /// For a change in place: quick to answer, then a long, quiet settle.
  static const curve = Cubic(0.2, 0, 0, 1);
  static const fast = Duration(milliseconds: 160);

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
    TextStyle title(TextStyle s, FontWeight weight) => s.copyWith(fontWeight: weight, letterSpacing: -0.2);
    final text = base.textTheme.copyWith(
      displaySmall: title(base.textTheme.displaySmall!, FontWeight.w700).copyWith(height: 1.2),
      headlineMedium: title(base.textTheme.headlineMedium!, FontWeight.w600),
      headlineSmall: title(base.textTheme.headlineSmall!, FontWeight.w600),
      titleLarge: title(base.textTheme.titleLarge!, FontWeight.w600),
      titleMedium: base.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
      bodyLarge: base.textTheme.bodyLarge!.copyWith(height: 1.6),
      bodyMedium: base.textTheme.bodyMedium!.copyWith(height: 1.6),
      labelLarge: base.textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w600),
    );

    OutlineInputBorder edge(Color color, [double width = 1]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: width),
    );

    const buttonStyle = ButtonStyle(
      minimumSize: WidgetStatePropertyAll(Size(44, 46)),
      padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 24, vertical: 18)),
      shape: WidgetStatePropertyAll(StadiumBorder()),
      animationDuration: fast,
    );

    return base.copyWith(
      textTheme: text,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: WidgetStateColor.resolveWith((s) => s.contains(WidgetState.focused) ? scheme.surfaceContainerLowest : scheme.surfaceContainerHigh),
        hoverColor: Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: WidgetStateInputBorder.resolveWith((s) {
          final focused = s.contains(WidgetState.focused);
          if (s.contains(WidgetState.error)) return edge(scheme.error, focused ? 1.6 : 1);
          if (focused) return edge(scheme.primary, 1.6);
          if (s.contains(WidgetState.hovered) && !s.contains(WidgetState.disabled)) return edge(scheme.outlineVariant);
          return edge(Colors.transparent);
        }),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: buttonStyle.copyWith(
          shadowColor: WidgetStatePropertyAll(scheme.primary.withValues(alpha: 0.5)),
          elevation: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.hovered) && !s.contains(WidgetState.pressed) && !s.contains(WidgetState.disabled) ? 3 : 0,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: buttonStyle.copyWith(
          side: WidgetStateProperty.resolveWith(
            (s) => BorderSide(color: s.contains(WidgetState.hovered) || s.contains(WidgetState.focused) ? scheme.outline : scheme.outlineVariant),
          ),
        ),
      ),
      textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(shape: WidgetStatePropertyAll(StadiumBorder()), animationDuration: fast),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: shape(16, side: BorderSide(color: scheme.outlineVariant)),
      ),
      dialogTheme: DialogThemeData(surfaceTintColor: Colors.transparent, shape: shape(22)),
      snackBarTheme: SnackBarThemeData(behavior: SnackBarBehavior.floating, shape: shape(12)),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(color: scheme.inverseSurface, borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        textStyle: TextStyle(color: scheme.onInverseSurface, fontSize: 12.5),
        waitDuration: const Duration(milliseconds: 350),
      ),
      // Thin, and only as dark as it needs to be.
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (s) => scheme.onSurfaceVariant.withValues(alpha: s.contains(WidgetState.hovered) || s.contains(WidgetState.dragged) ? 0.55 : 0.3),
        ),
        thickness: const WidgetStatePropertyAll(6),
        radius: const Radius.circular(8),
      ),
      dividerTheme: DividerThemeData(color: scheme.outlineVariant, space: 1, thickness: 1),
    );
  }
}
