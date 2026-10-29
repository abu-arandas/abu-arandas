import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/site_controller.dart';

/// Switches the site between Arabic and English. Its label names the language it switches to.
class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) =>
      TextButton.icon(onPressed: () => Get.find<SiteController>().toggleLanguage(), icon: const Icon(Icons.translate, size: 18), label: Text('العربية'.tr));
}
