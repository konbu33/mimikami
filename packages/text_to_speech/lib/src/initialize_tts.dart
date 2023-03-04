import 'dart:async';

import 'package:common/common.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:text_to_speech/src/control_engine_widget.dart';
import 'package:text_to_speech/src/platform_state.dart';

import 'control_language_widget.dart';
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
        logger.d("handler: engine : $engine");

        // I/flutter ( 5385): engine : com.google.android.tts
        unawaited(Future(() =>
            ref.read(engineStateProvider.notifier).update((state) => engine)));
      }
    }

    @override
    Future getDefaultVoice() async {
      var voice = await flutterTts.getDefaultVoice;

      const language = "ja-JP";
      if (voice != null) {
        logger.d("handler: voice: $voice");

        // I/flutter ( 5385): voice: {name: en-US-language, locale: en-US}
        unawaited(Future(() => ref
            .read(TextToSpeechWidgetState.languageStateProvider.notifier)
            // .update((state) => voice["locale"])));
            .update((state) => language)));
      }

      flutterTts.isLanguageInstalled(language).then((value) {
        ref
            .read(isCurrentLanguageInstalledStateProvider.notifier)
            .update((state) => value as bool);
      });
    }

    if (isAndroid) {
      getDefaultEngine();
      getDefaultVoice();
    }

    flutterTts.setStartHandler(() {
      logger.d("handler: setStartHandler");
      // Future(() => ref
      //     .read(ttsStateNotifierProvider.notifier)
      //     .updateTssState(EnumTtsState.playing));
    });

    if (isAndroid) {
      flutterTts.setInitHandler(() {
        logger.d("handler: setInitHandler");
        // ref
        //     .read(ttsStateNotifierProvider.notifier)
        //     .updateTssState(EnumTtsState.stopped);
      });
    }

    flutterTts.setCompletionHandler(() {
      logger.d("handler: setCompletionHandler");

      // 読み上げ途中で状態変化している可能性があるため、再度playingであることを確認
      if (ref.read(ttsStateNotifierProvider.notifier).isPlaying()) {
        logger.d("countup3");
        Future(() => ref
            .read(TextToSpeechWidgetState.currentTextPointProvider.notifier)
            .update((state) => state + 1));
      }
    });

    flutterTts.setCancelHandler(() {
      logger.d("handler: setCancelHandler");
      // Future(() => ref
      //     .read(ttsStateNotifierProvider.notifier)
      //     .updateTssState(EnumTtsState.stopped));
    });

    flutterTts.setPauseHandler(() {
      logger.d("handler: setPauseHandler");
      // Future(() => ref
      //     .read(ttsStateNotifierProvider.notifier)
      //     .updateTssState(EnumTtsState.paused));
    });

    flutterTts.setContinueHandler(() {
      logger.d("handler: setContinueHandler");
      // Future(() => ref
      //     .read(ttsStateNotifierProvider.notifier)
      //     // .updateTssState(EnumTtsState.continued));
      //     .updateTssState(EnumTtsState.playing));
    });

    flutterTts.setErrorHandler((msg) {
      logger.d("handler: setErrorHandler: $msg");
      ref
          .read(ttsStateNotifierProvider.notifier)
          .updateTssState(EnumTtsState.stopped);
    });

    return flutterTts;
  }

  return initTts;
});
