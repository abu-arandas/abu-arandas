import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/brand.dart';
import '../config/breakpoints.dart';
import '../config/content.dart';
import '../config/routes.dart';
import '../controllers/site_controller.dart';
import '../widgets/blocks.dart';
import '../widgets/site_scaffold.dart';

/// A short form that writes the visitor's WhatsApp message for them, and the other ways to reach the studio. The
/// site has no server, so nothing is stored: the message goes from the visitor's own WhatsApp.
class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) => SiteScaffold(
    current: Routes.contact,
    sections: [
      PageSection(
        eyebrow: 'Contact',
        title: 'Tell us about your project',
        subtitle: 'Fill this in and WhatsApp opens with your message ready to send. We answer within one working day.',
        child: GridRow(
          gutter: 48,
          children: [
            const GridCol(lg: 7, child: ContactForm()),
            GridCol(lg: 5, child: _Elsewhere()),
          ],
        ),
      ),
    ],
  );
}

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _company = TextEditingController();
  final _message = TextEditingController();
  String _type = Content.projectTypes.first;

  @override
  void dispose() {
    _name.dispose();
    _company.dispose();
    _message.dispose();
    super.dispose();
  }

  /// The WhatsApp message the form describes, in the site's current language.
  String get message {
    final lines = [
      'Hi Arandas Tech, I am @name.'.trParams({'name': _name.text.trim()}),
      if (_company.text.trim().isNotEmpty) 'Company: @company'.trParams({'company': _company.text.trim()}),
      'About: @type'.trParams({'type': _type.tr}),
      '',
      _message.text.trim(),
    ];
    return lines.join('\n');
  }

  void _send() {
    if (!(_form.currentState?.validate() ?? false)) return;
    Get.find<SiteController>().open(Brand.whatsAppLink(message));
  }

  String? _required(String? value) => (value ?? '').trim().isEmpty ? 'Required'.tr : null;

  @override
  Widget build(BuildContext context) => Form(
    key: _form,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: _name,
          decoration: InputDecoration(labelText: 'Your name'.tr),
          validator: _required,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _company,
          decoration: InputDecoration(labelText: 'Company or agency (optional)'.tr),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          initialValue: _type,
          decoration: InputDecoration(labelText: 'What is it about?'.tr),
          items: [for (final t in Content.projectTypes) DropdownMenuItem(value: t, child: Text(t.tr))],
          onChanged: (value) => setState(() => _type = value ?? _type),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _message,
          decoration: InputDecoration(labelText: 'Your message'.tr, alignLabelWithHint: true),
          validator: _required,
          minLines: 5,
          maxLines: 10,
        ),
        const SizedBox(height: 24),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: FilledButton.icon(onPressed: _send, icon: const Icon(Icons.send), label: Text('Send on WhatsApp'.tr)),
        ),
      ],
    ),
  );
}

class _Elsewhere extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final site = Get.find<SiteController>();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Other ways to reach us'.tr, style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            for (final link in Content.contactLinks)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(_icons[link.label] ?? Icons.link, color: theme.colorScheme.primary),
                title: Text(link.label.tr),
                trailing: const Icon(Icons.open_in_new, size: 18),
                onTap: () => site.open(link.url),
              ),
            const Divider(height: 32),
            Row(
              children: [
                Icon(Icons.place_outlined, color: theme.colorScheme.primary),
                const SizedBox(width: 16),
                Text(Brand.city.tr),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static const _icons = {'WhatsApp': Icons.chat, 'Email': Icons.mail_outline, 'Facebook': Icons.facebook, 'GitHub': Icons.code};
}
