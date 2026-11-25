import 'dart:ui' show Color, Locale;

/// Everything a rebrand changes in the Dart code, in one place. The web page's title, description and icons are in
/// web/index.html and web/manifest.json.
class Brand {
  /// The company's name in English, also the translation key for [nameAr].
  static const name = 'Arandas Tech';

  /// The company's name in Arabic.
  static const nameAr = 'العرندس للتكنولوجيا';

  /// The company's product line for shops, also the translation key for [productLineAr]. Zirr (زِرّ) is "button": the
  /// one on a shirt and the one on a screen.
  static const productLine = 'Zirr';
  static const productLineAr = 'زِرّ';

  /// Deep teal: buttons, links and the monogram. Every screen's palette is made from it.
  static const seedColor = Color(0xFF0E5E6F);

  /// Saffron gold: the pixel on the wordmark and highlights. Dark text on it, never white.
  static const accent = Color(0xFFE8A33D);

  /// Teal and saffron as they read on the dark theme's ink.
  static const seedColorDark = Color(0xFF6CC3D3);
  static const accentDark = Color(0xFFF2B95C);

  /// Ink: text, and the tint of every shadow.
  static const ink = Color(0xFF121417);

  /// The page: warm sand, or ink in the dark.
  static const page = Color(0xFFF5F1EA);
  static const pageDark = Color(0xFF101416);

  /// One font for Arabic and Latin text, bundled in assets/fonts and declared in pubspec.yaml.
  static const fontFamily = 'Rubik';

  /// The languages the site speaks. A visitor whose browser asks for Arabic gets Arabic; everyone else the first.
  static const locales = [Locale('en'), Locale('ar')];

  /// WhatsApp for sales and support, in international form without the plus.
  static const whatsApp = '962791568798';

  /// The address the contact page shows, or null to show none. Fill it in once the company has its own domain.
  static const String? email = null;

  static const facebook = 'https://www.facebook.com/1294898037048567';
  static const github = 'https://github.com/abu-arandas';

  /// Where the company works from, for the footer and the contact page.
  static const city = 'Amman, Jordan';

  /// A chat with [whatsApp], opened with [text] already typed.
  static String whatsAppLink([String text = '']) => 'https://wa.me/$whatsApp${text.isEmpty ? '' : '?text=${Uri.encodeComponent(text)}'}';
}
