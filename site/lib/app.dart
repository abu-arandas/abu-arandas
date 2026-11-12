import 'package:flutter_localizations/flutter_localizations.dart' as legacy;
import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart';

import 'config/brand.dart';
import 'config/routes.dart';
import 'config/theme.dart';
import 'controllers/site_controller.dart';
import 'l10n/translations.dart';

class SiteApp extends StatelessWidget {
  const SiteApp({required this.controller, this.initialRoute = Routes.home, super.key});

  final SiteController controller;
  final String initialRoute;

  @override
  Widget build(BuildContext context) => GetMaterialApp(
    title: Brand.name,
    debugShowCheckedModeBanner: false,
    initialBinding: BindingsBuilder<void>(() {
      Get.put(controller);
    }),
    translations: AppTranslations(),
    locale: controller.locale.value,
    fallbackLocale: const Locale('en'),
    supportedLocales: Brand.locales,
    localizationsDelegates: const [
      // The material_ui delegates (they bring the Cupertino and Widgets ones too) for the pages...
      ...GlobalMaterialLocalizations.delegates,
      // ...and the old ones for the flutter/material app GetX 4.7.3 builds underneath. Remove with GetX's move.
      // ignore: deprecated_member_use
      legacy.GlobalMaterialLocalizations.delegate,
      // ignore: deprecated_member_use
      legacy.GlobalCupertinoLocalizations.delegate,
    ],
    initialRoute: initialRoute,
    getPages: appPages,
    unknownRoute: notFoundPage,
    defaultTransition: Transition.fadeIn,
    // GetX 4.7.3 still builds a legacy (flutter/material) MaterialApp, so its theme: parameter cannot take a
    // material_ui ThemeData. The material_ui theme and snack-bar host are given to the pages here instead.
    builder: (context, child) => Theme(
      data: MediaQuery.platformBrightnessOf(context) == Brightness.dark ? AppTheme.dark() : AppTheme.light(),
      child: ScaffoldMessenger(child: child ?? const SizedBox.shrink()),
    ),
  );
}
