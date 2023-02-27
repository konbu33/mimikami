import 'dart:async';

import 'package:common/common.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:text_to_speech/src/engine_list_widget.dart';
import 'package:text_to_speech/src/platform_state.dart';

import 'text_to_speech_state.dart';
import 'text_to_speech_widget_state.dart';

final flutterTtsProvider = Provider((ref) => FlutterTts());

final initializedTtsProvider = Provider((ref) {
  FlutterTts initTts() {
    final flutterTts = ref.watch(flutterTtsProvider);
    final isAndroid = ref.watch(PlatformState.isAndroidStateProvider);

    Future setAwaitOptions() async {
      await flutterTts.awaitSpeakCompletion(true);
    }

    setAwaitOptions();

    @override
    Future getDefaultEngine() async {
      var engine = await flutterTts.getDefaultEngine;

      if (engine != null) {
        logger.d("engine : $engine");

        // I/flutter ( 5385): engine : com.google.android.tts
        unawaited(Future(() =>
            ref.read(engineStateProvider.notifier).update((state) => engine)));
      }
    }

    @override
    Future getDefaultVoice() async {
      var voice = await flutterTts.getDefaultVoice;

      if (voice != null) {
        logger.d("voice: $voice");

        // I/flutter ( 5385): voice: {name: en-US-language, locale: en-US}
        unawaited(Future(() => ref
            .read(TextToSpeechWidgetState.languageStateProvider.notifier)
            .update((state) => voice["locale"])));
      }
    }

    if (isAndroid) {
      getDefaultEngine();
      getDefaultVoice();
    }

    flutterTts.setStartHandler(() {
      logger.d("Playing");
      ref
          .read(ttsStateNotifierProvider.notifier)
          .updateTssState(EnumTtsState.playing);
    });

    if (isAndroid) {
      flutterTts.setInitHandler(() {
        logger.d("TTS Initialized");
        ref
            .read(ttsStateNotifierProvider.notifier)
            .updateTssState(EnumTtsState.stopped);
      });
    }

    flutterTts.setCompletionHandler(() {
      logger.d("Complete");
      ref
          .read(ttsStateNotifierProvider.notifier)
          .updateTssState(EnumTtsState.stopped);
    });

    flutterTts.setCancelHandler(() {
      logger.d("Cancel");
      ref
          .read(ttsStateNotifierProvider.notifier)
          .updateTssState(EnumTtsState.stopped);
    });

    flutterTts.setPauseHandler(() {
      logger.d("Paused");
      ref
          .read(ttsStateNotifierProvider.notifier)
          .updateTssState(EnumTtsState.paused);
    });

    flutterTts.setContinueHandler(() {
      logger.d("Continued");
      ref
          .read(ttsStateNotifierProvider.notifier)
          .updateTssState(EnumTtsState.continued);
    });

    flutterTts.setErrorHandler((msg) {
      logger.d("error: $msg");
      ref
          .read(ttsStateNotifierProvider.notifier)
          .updateTssState(EnumTtsState.stopped);
    });

    return flutterTts;
  }

  return initTts;
});
