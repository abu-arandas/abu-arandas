import 'package:arandas_site/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers.dart';

void main() {
  testWidgets('the form asks for a name and a message', (tester) async {
    await pumpSite(tester, route: Routes.contact);
    await tester.tap(find.text('Send on WhatsApp'));
    await tester.pumpAndSettle();
    expect(find.text('Required'), findsNWidgets(2));
    expect(opened, isEmpty);
  });

  testWidgets('the form opens WhatsApp with the message written', (tester) async {
    await pumpSite(tester, route: Routes.contact);
    await tester.enterText(find.widgetWithText(TextFormField, 'Your name'), 'Lina');
    await tester.enterText(find.widgetWithText(TextFormField, 'Company or agency (optional)'), 'Blue Agency');
    await tester.tap(find.text('White-label work for an agency'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Arandas Clinic').last);
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextFormField, 'Your message'), 'We need a clinic app.');
    await tester.tap(find.text('Send on WhatsApp'));
    await tester.pumpAndSettle();
    final text = opened.single.queryParameters['text']!;
    expect(opened.single.host, 'wa.me');
    expect(text, contains('I am Lina.'));
    expect(text, contains('Company: Blue Agency'));
    expect(text, contains('About: Arandas Clinic'));
    expect(text, endsWith('We need a clinic app.'));
  });

  testWidgets('in Arabic the message is written in Arabic', (tester) async {
    await pumpSite(tester, route: Routes.contact, locale: const Locale('ar'));
    await tester.enterText(find.byType(TextFormField).first, 'لينا');
    await tester.enterText(find.byType(TextFormField).last, 'نحتاج تطبيقاً.');
    await tester.tap(find.text('أرسل على واتساب'));
    await tester.pumpAndSettle();
    final text = opened.single.queryParameters['text']!;
    expect(text, contains('أنا لينا.'));
    expect(text, isNot(contains('Company')));
    expect(text, contains('الموضوع: عمل باسم وكالة'));
  });

  testWidgets('the other links open WhatsApp, Facebook and GitHub', (tester) async {
    await pumpSite(tester, route: Routes.contact);
    for (final label in ['WhatsApp', 'Facebook', 'GitHub']) {
      await tester.tap(find.widgetWithText(ListTile, label));
    }
    expect(opened.map((u) => u.host), ['wa.me', 'www.facebook.com', 'github.com']);
  });
}
