import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart';

import '../config/breakpoints.dart';
import '../config/routes.dart';
import '../models/content.dart';
import '../widgets/blocks.dart';
import '../widgets/fun.dart';
import '../widgets/motion.dart';
import '../widgets/site_scaffold.dart';
import '../widgets/stitch_line.dart';

/// Shown for any address the site does not have: the lost button rolls in, with one of a few kind lines and the way
/// back home.
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = funLine(['This page lost a button.'.tr, 'This page went out for a coffee.'.tr, 'We looked under every cushion. Nothing.'.tr]);
    return SiteScaffold(
      current: '',
      sections: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: context.responsive<double>(56, lg: 96)),
          child: GridContainer(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 640),
                child: Column(
                  children: [
                    LostButton(label: 'The lost button'.tr),
                    const SizedBox(height: 24),
                    const Appear(child: Eyebrow('Page not found')),
                    const SizedBox(height: 12),
                    WordsRise(
                      title,
                      delay: const Duration(milliseconds: 120),
                      textAlign: TextAlign.center,
                      style: context.responsive(theme.textTheme.headlineMedium, lg: theme.textTheme.displaySmall),
                    ),
                    const SizedBox(height: 14),
                    const SewIn(delay: Duration(milliseconds: 480), child: StitchLine()),
                    const SizedBox(height: 18),
                    Appear(
                      delay: const Duration(milliseconds: 360),
                      child: Text(
                        'The link may be old, or the address mistyped.'.tr,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.6),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Appear(
                      delay: Duration(milliseconds: 440),
                      child: LinkButtons([
                        SiteLink('Go to the home page', Routes.home),
                        SiteLink('See our work', Routes.work),
                      ], alignment: WrapAlignment.center),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
