import 'dart:ui' show Locale;

import 'package:get/get.dart';

import '../config/brand.dart';

/// Opens a link in a browser tab and says whether it did.
typedef Launcher = Future<bool> Function(Uri uri);

/// The language the site speaks, and where its links go.
class SiteController extends GetxController {
  SiteController({required Launcher launcher, Locale? preferred}) : _launch = launcher, locale = _pick(preferred).obs;

  final Launcher _launch;
  final Rx<Locale> locale;

  bool get isArabic => locale.value.languageCode == 'ar';

  /// The visitor's own language when the site speaks it, otherwise the first in [Brand.locales].
  static Locale _pick(Locale? preferred) => Brand.locales.firstWhere((l) => l.languageCode == preferred?.languageCode, orElse: () => Brand.locales.first);

  /// Switches between the languages in [Brand.locales]. The page rebuilds in place (see SiteScaffold) rather than
  /// through `Get.updateLocale`, which reassembles the whole widget tree.
  void toggleLanguage() {
    final next = Brand.locales[(Brand.locales.indexOf(locale.value) + 1) % Brand.locales.length];
    Get.locale = next;
    locale.value = next;
    Get.rootController.update();
  }

  /// Opens [url]: a page of this site (starting with `/`) in place, anything else in a new tab.
  Future<void> open(String url) async {
    if (url.startsWith('/')) {
      if (Get.currentRoute != url) await Get.toNamed<void>(url);
      return;
    }
    await _launch(Uri.parse(url));
  }
}
