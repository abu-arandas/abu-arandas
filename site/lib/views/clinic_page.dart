import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/brand.dart';
import '../config/breakpoints.dart';
import '../config/content.dart';
import '../config/routes.dart';
import '../models/content.dart';
import '../widgets/blocks.dart';
import '../widgets/site_scaffold.dart';

/// Arandas Clinic: appointments, patient files, reminders and e-invoices for small clinics in Jordan.
class ClinicPage extends StatelessWidget {
  const ClinicPage({super.key});

  @override
  Widget build(BuildContext context) => SiteScaffold(
    current: Routes.clinic,
    sections: [
      PageHero(
        eyebrow: 'Arandas Clinic · for clinics in Jordan',
        title: 'Fewer no-shows, files in one place, and e-invoices sent for you',
        body: 'Appointments, patient files and WhatsApp reminders for small clinics, on Android, iPhone and the web. Arabic first, English too, and built around Jordan’s privacy and e-invoicing laws.',
        actions: [SiteLink('Book a demo on WhatsApp', Brand.whatsAppLink('Hi Arandas Tech, I would like a demo of Arandas Clinic.'.tr))],
        aside: const _Today(),
      ),
      const PageSection(eyebrow: 'Features', title: 'Everything the front desk and the doctor need', child: FeatureGrid(Content.clinicFeatures)),
      PageSection(
        tinted: true,
        child: GridRow(
          gutter: 48,
          children: [
            GridCol(
              lg: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Eyebrow('Privacy'),
                  const SizedBox(height: 8),
                  Text('Built for Jordan’s data protection law'.tr, style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 12),
                  Text(
                    'Health data is sensitive data under the PDPL (Law 24 of 2023). The app protects it in the database, not only on the screen.'.tr,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            const GridCol(lg: 6, child: CheckList(Content.clinicPrivacy)),
          ],
        ),
      ),
      const CallToAction(
        title: 'Run a clinic, or build for clinics?',
        body: 'Clinics get a demo and a setup in Amman. Agencies can license the clinic system for their own clients.',
      ),
    ],
  );
}

/// A sketch of the app's Today screen, standing in for a screenshot.
class _Today extends StatelessWidget {
  const _Today();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final rows = [
      ('09:00', 'Confirmed'.tr, Icons.check_circle),
      ('09:30', 'Reminder sent'.tr, Icons.chat),
      ('10:15', 'Booked online'.tr, Icons.event_available),
      ('11:00', 'Attended'.tr, Icons.done_all),
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Today'.tr, style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            for (final (time, status, icon) in rows)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Text(time, style: theme.textTheme.titleSmall),
                        const SizedBox(width: 16),
                        Expanded(child: Text(status)),
                        Icon(icon, size: 20, color: scheme.primary),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
