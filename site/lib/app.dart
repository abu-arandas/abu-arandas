import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

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
    theme: AppTheme.light(),
    darkTheme: AppTheme.dark(),
    initialBinding: BindingsBuilder(() {
      Get.put(controller);
    }),
    translations: AppTranslations(),
    locale: controller.locale.value,
    fallbackLocale: const Locale('en'),
    supportedLocales: Brand.locales,
    localizationsDelegates: const [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
    initialRoute: initialRoute,
    getPages: appPages,
    unknownRoute: notFoundPage,
    defaultTransition: Transition.fadeIn,
  );
}
