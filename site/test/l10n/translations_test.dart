import 'dart:io';

import 'package:arandas_site/config/content.dart';
import 'package:arandas_site/l10n/ar.dart';
import 'package:flutter_test/flutter_test.dart';

/// Every literal the code translates, with `'...'.tr` or `'...'.trParams(...)`, or hands to a block that translates
/// it (`title:`, `subtitle:`, `body:` and `eyebrow:` of PageSection, PageHero and CallToAction, Eyebrow, SiteLink).
final _translated = RegExp(r"""'((?:[^'\\]|\\.)+)'\.tr(?:Params)?\b""");
final _handedOn = RegExp(r"""(?:title|subtitle|body|eyebrow)[:=] '((?:[^'\\]|\\.)+)'|Eyebrow\('((?:[^'\\]|\\.)+)'\)|SiteLink\('((?:[^'\\]|\\.)+)',""");

void main() {
  test('every text the screens translate has Arabic', () {
    final missing = <String>{};
    final screens = Directory('lib').listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart') && !f.path.startsWith('lib/l10n'));
    for (final file in screens) {
      // Adjacent literals split over lines are one text.
      final source = file.readAsStringSync().replaceAll(RegExp("'\\s*\\n\\s*'"), '');
      for (final m in [..._translated.allMatches(source), ..._handedOn.allMatches(source)]) {
        final text = (m.group(1) ?? m.group(2) ?? m.group(3)!).replaceAll(r"\'", "'");
        if (!ar.containsKey(text)) missing.add('${file.path}: $text');
      }
    }
    expect(missing, isEmpty, reason: 'add these to lib/l10n/ar.dart');
  });

  test('every content text has Arabic', () {
    final missing = Content.translatedText.where((t) => !ar.containsKey(t)).toSet();
    expect(missing, isEmpty, reason: 'add these to lib/l10n/ar.dart');
  });

  test('no Arabic is left over from a text that is gone', () {
    final sources = Directory('lib').listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart') && !f.path.startsWith('lib/l10n'));
    final all = sources.map((f) => f.readAsStringSync().replaceAll(RegExp("'\\s*\\n\\s*'"), '')).join('\n');
    final unused = ar.keys.where((k) => !all.contains(k.replaceAll("'", r"\'")) && !all.contains(k)).toList();
    expect(unused, isEmpty, reason: 'remove these from lib/l10n/ar.dart');
  });

  test('lib/models imports neither GetX nor Flutter', () {
    final offending = <String>[];
    for (final file in Directory('lib/models').listSync(recursive: true).whereType<File>()) {
      for (final line in file.readAsLinesSync()) {
        if (RegExp("^import 'package:(get|flutter)/").hasMatch(line)) offending.add('${file.path}: $line');
      }
    }
    expect(offending, isEmpty);
  });
}
