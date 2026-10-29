import 'package:arandas_site/config/brand.dart';
import 'package:arandas_site/config/routes.dart';
import 'package:arandas_site/controllers/site_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  SiteController make(Locale? preferred) => SiteController(launcher: (_) async => true, preferred: preferred);

  test('opens in the visitor’s language when the site speaks it', () {
    expect(make(const Locale('ar', 'SA')).isArabic, isTrue);
    expect(make(const Locale('en', 'GB')).locale.value, const Locale('en'));
    expect(make(const Locale('de')).locale.value, Brand.locales.first);
    expect(make(null).locale.value, Brand.locales.first);
  });

  test('WhatsApp links carry the message, encoded', () {
    expect(Brand.whatsAppLink(), 'https://wa.me/${Brand.whatsApp}');
    expect(Uri.parse(Brand.whatsAppLink('Hi & bye')).queryParameters['text'], 'Hi & bye');
  });

  test('only the site’s own addresses are known', () {
    for (final name in ['/', '/agencies', '/agencies/', '/work', '/work/marcat', '/contact?from=ad']) {
      expect(Routes.isKnown(name), isTrue, reason: name);
    }
    for (final name in ['/nowhere', '/agencies/x', '/work/a/b', '/products']) {
      expect(Routes.isKnown(name), isFalse, reason: name);
    }
  });
}
