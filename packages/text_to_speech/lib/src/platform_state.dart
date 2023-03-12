import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlatformState {
  static final isIOSStateProvider =
      StateProvider((ref) => !kIsWeb && Platform.isIOS);

  static final isAndroidStateProvider =
      StateProvider((ref) => !kIsWeb && Platform.isAndroid);

  static final isWindowsStateProvider =
      StateProvider((ref) => !kIsWeb && Platform.isWindows);

  static final isWebStateProvider = StateProvider((ref) => kIsWeb);
}
