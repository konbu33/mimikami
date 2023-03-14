import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'platform_state.g.dart';

class PlatformState {
  static final isIOSStateProvider = _isIOSStateProvider;
  static final isAndroidStateProvider = _isAndroidStateProvider;
  static final isWindowsStateProvider = _isWindowsStateProvider;
  static final isWebStateProvider = _isWebStateProvider;
}

@riverpod
class _IsIOSState extends _$IsIOSState {
  @override
  bool build() {
    return !kIsWeb && Platform.isIOS;
  }
}

@riverpod
class _IsAndroidState extends _$IsAndroidState {
  @override
  bool build() {
    return !kIsWeb && Platform.isAndroid;
  }
}

@riverpod
class _IsWindowsState extends _$IsWindowsState {
  @override
  bool build() {
    return !kIsWeb && Platform.isWindows;
  }
}

@riverpod
class _IsWebState extends _$IsWebState {
  @override
  bool build() {
    return kIsWeb;
  }
}
