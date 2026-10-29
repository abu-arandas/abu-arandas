import 'package:arandas_site/config/content.dart';
import 'package:arandas_site/config/routes.dart';
import 'package:arandas_site/views/not_found_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import '../helpers.dart';

const _pages = {
  Routes.home: 'Flutter apps for agencies, and the products to start them from',
  Routes.agencies: 'A white-label Flutter team, under your name',
  Routes.marcat: 'Your online shop, tills and stock in one Flutter app',
  Routes.clinic: 'Fewer no-shows, files in one place, and e-invoices sent for you',
  Routes.work: 'What we have built',
  Routes.contact: 'Tell us about your project',
  '/work/marcat': 'One app for a fashion retailer’s shop, tills and books',
  '/work/clinic': 'Bookings, files and WhatsApp reminders for clinics in Jordan',
  '/work/vanguard': 'A premium fashion store with its own back office',
  '/work/starter': 'The starter every Arandas Tech app begins from',
};

void main() {
  // Every page, at a phone's and a laptop's width, in both languages, scrolled to the bottom: any overflow fails.
  for (final MapEntry(key: route, value: heading) in _pages.entries) {
    for (final width in [375.0, 1280.0]) {
      testWidgets('$route lays out at ${width.toInt()}px in English and Arabic', (tester) async {
        final site = await pumpSite(tester, route: route, width: width);
        expect(find.text(heading), findsOneWidget);
        await _scrollToEnd(tester);

        site.toggleLanguage();
        await tester.pumpAndSettle();
        expect(Directionality.of(tester.element(find.byType(Scaffold).first)), TextDirection.rtl);
        expect(find.text(heading), findsNothing);
        await _scrollToEnd(tester);
      });
    }
  }

  testWidgets('an unknown address shows the not-found page', (tester) async {
    await pumpSite(tester, route: '/nowhere');
    expect(find.byType(NotFoundPage), findsOneWidget);
  });

  testWidgets('an unknown case study shows the not-found page', (tester) async {
    await pumpSite(tester, route: '/work/nowhere');
    expect(find.byType(NotFoundPage), findsOneWidget);
  });

  testWidgets('the header opens each page', (tester) async {
    await pumpSite(tester);
    await tester.tap(find.widgetWithText(TextButton, 'For agencies'));
    await tester.pumpAndSettle();
    expect(find.text(_pages[Routes.agencies]!), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Work'));
    await tester.pumpAndSettle();
    expect(find.text(_pages[Routes.work]!), findsOneWidget);
  });

  testWidgets('the phone menu opens a page', (tester) async {
    await pumpSite(tester, width: 375);
    expect(find.widgetWithText(TextButton, 'For agencies'), findsNothing);
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ListTile, 'Contact'));
    await tester.pumpAndSettle();
    expect(find.text(_pages[Routes.contact]!), findsOneWidget);
  });

  testWidgets('a case study card opens its page', (tester) async {
    await pumpSite(tester, route: Routes.work);
    final card = find.text(Content.caseStudy('vanguard')!.title);
    await tester.scrollUntilVisible(card, 300, scrollable: find.byType(Scrollable).first);
    await tester.pumpAndSettle();
    await tester.tap(card);
    await tester.pumpAndSettle();
    expect(find.text('The challenge'.toUpperCase()), findsOneWidget);
    expect(Get.currentRoute, '/work/vanguard');
  });

  testWidgets('Talk to us opens WhatsApp', (tester) async {
    await pumpSite(tester);
    await tester.tap(find.text('Talk to us'));
    expect(opened.single.host, 'wa.me');
  });

  testWidgets('a licence button opens PayPal', (tester) async {
    await pumpSite(tester, route: Routes.marcat);
    await tester.scrollUntilVisible(find.text('Agency licence'), 300, scrollable: find.byType(Scrollable).first);
    final buy = find.text('Buy with PayPal').first;
    await tester.ensureVisible(buy);
    await tester.pumpAndSettle();
    await tester.tap(buy);
    expect(opened.single.host, 'www.paypal.com');
  });

  testWidgets('a visitor whose browser asks for Arabic gets Arabic', (tester) async {
    await pumpSite(tester, locale: const Locale('ar', 'JO'));
    expect(find.text('للوكالات'), findsWidgets);
  });

  testWidgets('a visitor in another language gets English', (tester) async {
    await pumpSite(tester, locale: const Locale('fr'));
    expect(find.text('For agencies'), findsWidgets);
  });
}

Future<void> _scrollToEnd(WidgetTester tester) async {
  final list = find.byType(Scrollable).first;
  for (var i = 0; i < 40; i++) {
    await tester.drag(list, const Offset(0, -800));
    await tester.pump();
  }
  await tester.pumpAndSettle();
  expect(find.textContaining('Flutter'), findsWidgets);
}
