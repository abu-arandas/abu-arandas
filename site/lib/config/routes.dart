import 'package:flutter/widgets.dart' show RouteSettings;
import 'package:get/get.dart';

import '../views/case_study_page.dart';
import '../views/contact_page.dart';
import '../views/home_page.dart';
import '../views/not_found_page.dart';
import '../views/retail_page.dart';
import '../views/services_page.dart';
import '../views/work_page.dart';
import '../views/zirr_page.dart';
import '../widgets/site_scaffold.dart';

/// Every page the site can open, by address.
class Routes {
  static const home = '/';
  static const services = '/services';
  static const zirr = '/zirr';
  static const retail = '/zirr/retail';
  static const work = '/work';
  static const contact = '/contact';

  static const notFound = '/not-found';

  /// Older addresses that still open their page: the services page was "For agencies", and Zirr Retail sat under
  /// /products before the Zirr line had its own page.
  static const oldAgencies = '/agencies';
  static const oldRetail = '/products/retail';

  /// One case study, by its slug.
  static String caseStudy(String slug) => '$work/$slug';

  static const _fixed = {home, services, zirr, retail, work, contact, notFound, oldAgencies, oldRetail};

  /// Whether [name] is one of the site's addresses, ignoring a query and a trailing slash.
  static bool isKnown(String name) {
    var path = Uri.parse(name).path;
    if (path.length > 1 && path.endsWith('/')) path = path.substring(0, path.length - 1);
    return _fixed.contains(path) || RegExp('^$work/[^/]+\$').hasMatch(path);
  }
}

/// GetX opens the longest known prefix of an address (`/nowhere` opens `/`), so every page sends an address that is
/// not exactly one of the site's to the not-found page.
class _KnownOnly extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) => route == null || Routes.isKnown(route) ? null : const RouteSettings(name: Routes.notFound);
}

GetPage<void> _page(String name, GetPageBuilder page) => GetPage<void>(name: name, page: () => LanguageBound(page()), middlewares: [_KnownOnly()]);

final notFoundPage = GetPage<void>(name: Routes.notFound, page: () => const LanguageBound(NotFoundPage()));

final appPages = [
  _page(Routes.home, () => const HomePage()),
  _page(Routes.services, () => const ServicesPage()),
  _page(Routes.oldAgencies, () => const ServicesPage()),
  _page(Routes.zirr, () => const ZirrPage()),
  _page(Routes.retail, () => const RetailPage()),
  _page(Routes.oldRetail, () => const RetailPage()),
  _page(Routes.work, () => const WorkPage()),
  _page('${Routes.work}/:slug', () => CaseStudyPage(slug: Get.parameters['slug'] ?? '')),
  _page(Routes.contact, () => const ContactPage()),
  notFoundPage,
];
