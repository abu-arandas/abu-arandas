import 'dart:ui' show Color, Locale;

/// Everything a rebrand changes in the Dart code, in one place. The web page's title, description and icons are in
/// web/index.html and web/manifest.json.
class Brand {
  /// The studio's name in English, also the translation key for [nameAr].
  static const name = 'Arandas Tech';

  /// The studio's name in Arabic.
  static const nameAr = 'أرندس تك';

  /// The colour every screen's palette is made from.
  static const seedColor = Color(0xFF1F5EFF);

  /// One font for Arabic and Latin text, bundled in assets/fonts and declared in pubspec.yaml.
  static const fontFamily = 'Cairo';

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
