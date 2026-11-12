import 'dart:ui' show Color, Locale;

/// Everything a rebrand changes in the Dart code, in one place. The web page's title, description and icons are in
/// web/index.html and web/manifest.json.
class Brand {
  /// The studio's name in English, also the translation key for [nameAr]. Zirr (زِرّ) is "button": the one on a shirt
  /// and the one on a screen.
  static const name = 'Zirr';

  /// The name as the logo spells it, next to the mark: all lower case in English, [nameAr] in Arabic.
  static const wordmark = 'zirr';

  /// The studio's name in Arabic.
  static const nameAr = 'زِرّ';

  /// Denim: buttons, links and the mark. Every screen's palette is made from it.
  static const seedColor = Color(0xFF2B4C8C);

  /// Thread orange: the lit hole of the mark and highlights. Dark text on it, never white.
  static const thread = Color(0xFFEE7B30);

  /// Denim and thread as they read on the dark theme's night blue.
  static const seedColorDark = Color(0xFF8EAEF0);
  static const threadDark = Color(0xFFFF9F5A);

  /// The page: cotton white, or night blue in the dark.
  static const page = Color(0xFFF7F5F0);
  static const pageDark = Color(0xFF0D121C);

  /// One font for Arabic and Latin text, bundled in assets/fonts and declared in pubspec.yaml.
  static const fontFamily = 'Rubik';

  /// The languages the site speaks. A visitor whose browser asks for Arabic gets Arabic; everyone else the first.
  static const locales = [Locale('en'), Locale('ar')];

  /// WhatsApp for sales and support, in international form without the plus.
  static const whatsApp = '962791568798';

  /// The address the contact page shows, or null to show none. Fill it in once the studio has its own domain.
  static const String? email = null;

  static const facebook = 'https://www.facebook.com/1294898037048567';
  static const github = 'https://github.com/abu-arandas';

  /// Where the studio works from, for the footer and the contact page.
  static const city = 'Amman, Jordan';

  /// A chat with [whatsApp], opened with [text] already typed.
  static String whatsAppLink([String text = '']) => 'https://wa.me/$whatsApp${text.isEmpty ? '' : '?text=${Uri.encodeComponent(text)}'}';
}
