import 'package:flutter/widgets.dart' show RouteSettings;
import 'package:get/get.dart';

import '../views/agencies_page.dart';
import '../views/case_study_page.dart';
import '../views/clinic_page.dart';
import '../views/contact_page.dart';
import '../views/home_page.dart';
import '../views/marcat_page.dart';
import '../views/not_found_page.dart';
import '../views/work_page.dart';

/// Every page the site can open, by address.
class Routes {
  static const home = '/';
  static const agencies = '/agencies';
  static const marcat = '/products/marcat';
  static const clinic = '/products/clinic';
  static const work = '/work';
  static const contact = '/contact';

  static const notFound = '/not-found';

  /// One case study, by its slug.
  static String caseStudy(String slug) => '$work/$slug';

  static const _fixed = {home, agencies, marcat, clinic, work, contact, notFound};

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

GetPage<void> _page(String name, GetPageBuilder page) => GetPage<void>(name: name, page: page, middlewares: [_KnownOnly()]);

final notFoundPage = GetPage<void>(name: Routes.notFound, page: () => const NotFoundPage());

final appPages = [
  _page(Routes.home, () => const HomePage()),
  _page(Routes.agencies, () => const AgenciesPage()),
  _page(Routes.marcat, () => const MarcatPage()),
  _page(Routes.clinic, () => const ClinicPage()),
  _page(Routes.work, () => const WorkPage()),
  _page('${Routes.work}/:slug', () => CaseStudyPage(slug: Get.parameters['slug'] ?? '')),
  _page(Routes.contact, () => const ContactPage()),
  notFoundPage,
];
