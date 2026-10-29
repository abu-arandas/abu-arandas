import 'package:arandas_site/app.dart';
import 'package:arandas_site/controllers/site_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

/// The links the site tried to open outside itself, newest last.
final opened = <Uri>[];

/// Starts the whole site at [route], in [locale], in a window [width] wide.
Future<SiteController> pumpSite(WidgetTester tester, {String route = '/', Locale locale = const Locale('en'), double width = 1280}) async {
  Get.reset();
  opened.clear();
  tester.view.physicalSize = Size(width, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  addTearDown(Get.reset);
  final controller = SiteController(
    launcher: (uri) async {
      opened.add(uri);
      return true;
    },
    preferred: locale,
  );
  await tester.pumpWidget(SiteApp(controller: controller, initialRoute: route));
  await tester.pumpAndSettle();
  return controller;
}
