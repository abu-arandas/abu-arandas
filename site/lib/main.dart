import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app.dart';
import 'controllers/site_controller.dart';

/// Starts the site with real addresses (`/agencies`, not `/#/agencies`), in the visitor's language when it is one
/// the site speaks. Pages, text and links live in lib/config and lib/l10n, not here.
void main() {
  usePathUrlStrategy();
  runApp(
    SiteApp(
      controller: SiteController(
        launcher: (uri) => launchUrl(uri, webOnlyWindowName: '_blank'),
        preferred: PlatformDispatcher.instance.locale,
      ),
    ),
  );
}
