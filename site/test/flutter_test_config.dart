import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

/// Loads the site's real font, so tests measure text as a browser would and catch overflow in either language.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  final font = File('assets/fonts/Cairo.ttf').readAsBytesSync();
  await (FontLoader('Cairo')..addFont(Future.value(ByteData.view(Uint8List.fromList(font).buffer)))).load();
  await testMain();
}
