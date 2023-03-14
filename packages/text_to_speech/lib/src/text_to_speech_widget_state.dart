import 'dart:async';

import 'package:common/common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:text_to_speech/src/text_to_speech_state.dart';

import 'tts_repository_impl.dart';

class TextToSpeechWidgetState {
  static final languageStateProvider = StateProvider<String?>((ref) => "en-US");

  static final volumeStateProvider = StateProvider<double>((ref) => 0.5);
  static final pitchStateProvider = StateProvider<double>((ref) => 1.0);
  static final rateStateProvider = StateProvider<double>((ref) => 0.7);
  static final newVoiceTextStateProvider = StateProvider<String?>((ref) => "");

  static final autoScrollControllerProvider =
      StateProvider((ref) => AutoScrollController());

  // --------------------------------------------------
  //
  // 責務：読み上げ対象の文章を保持(配列)
  //
  // --------------------------------------------------
  static final currentTextListStateProvider =
      StateProvider<List<String>>((ref) {
    //

    // 読み上げるコンテンツがタップされた時、配列として保持する。
    final newVoiceText = ref.watch(newVoiceTextStateProvider);

    if (newVoiceText == null) return [];
    if (newVoiceText.isEmpty) return [];
    final String voiceText = newVoiceText;

    // 区切り文字毎に、配列を作成する。
    final re = RegExp(r'。|、|;');
    final List<String> currentTextList = voiceText.split(re);

    return currentTextList;
  });

  // --------------------------------------------------
  //
  // 責務：読み上げ中の文章の位置を返す
  //
  // --------------------------------------------------
  static final currentTextPointProvider = StateProvider((ref) {
    // 現在の文章が更新された時、初期化する。
    ref.watch(currentTextListStateProvider);
    return 0;
  });

  // --------------------------------------------------
  //
  // 責務：現在の文章を返す
  //
  // --------------------------------------------------
  static final currentTextProvider = StateProvider((ref) {
    // 現在の文章が更新された時 or 現在の文章の位置が更新された時
    final currentTextList = ref.watch(currentTextListStateProvider);
    final currentTextPoint = ref.watch(currentTextPointProvider);

    // 空の場合は空文字を返す
    if (currentTextList.isEmpty) return "";
    if (currentTextList.length <= currentTextPoint) return "";

    // 空白除去
    final currentTextNoTrim = currentTextList[currentTextPoint];
    final currentText = currentTextNoTrim.replaceAll(RegExp(r"\s+"), '');
    return currentText;
  });

  // --------------------------------------------------
  //
  // 責務：playing操作時の処理
  //
  // --------------------------------------------------
  static final playingProvider = Provider<void>((ref) async {
    // ttsStateが変化した時 or currentTextが変化した時
    final ttsState = ref.watch(ttsStateNotifierProvider);
    final currentText = ref.watch(currentTextProvider);

    final volume = ref.read(TextToSpeechWidgetState.volumeStateProvider);
    final pitch = ref.read(TextToSpeechWidgetState.pitchStateProvider);
    final rate = ref.read(TextToSpeechWidgetState.rateStateProvider);

    if (ttsState.value != EnumTtsState.playing) return;
    if (currentText.isEmpty) return;

    logger.d("ttsState: $ttsState, currentText: $currentText");

    // 状態変化している可能性があるため、再度playingであることを確認
    if (ref.read(ttsStateNotifierProvider.notifier).isPlaying()) {
      //

      // 日本語が含まれていない場合、読み上げない
      bool containJapanese(String text) {
        return RegExp(r'[\u3040-\u309F]|\u3000|[\u30A1-\u30FC]|[\u4E00-\u9FFF]')
            .hasMatch(text);
      }

      if (!containJapanese(currentText)) {
        Future(() => ref
            .read(currentTextPointProvider.notifier)
            .update((state) => state + 1));
        return;
      }

      // 読み上げ開始
      final ttsRepository = ref.watch(ttsRepositoryProvider);
      await ttsRepository.speak(
        volume: volume,
        pitch: pitch,
        rate: rate,
        newVoiceText: currentText,
      );
      logger.d("countup1");
    }
  });

  // --------------------------------------------------
  //
  // 責務：完読時の処理
  //
  // --------------------------------------------------
  static final playingCompleteProvider = Provider<void>((ref) {
    final currentTextPoint = ref.watch(currentTextPointProvider);
    final currentTextListLength =
        ref.watch(currentTextListStateProvider).length;

    logger.d(
        "currentTextPoint: $currentTextPoint, currentTextListLength: $currentTextListLength");

    // playing時、currentTextPointがmaxまで達したら、stoppedにする
    if (ref.read(ttsStateNotifierProvider.notifier).isPlaying()) {
      if (currentTextPoint >= currentTextListLength) {
        Future(() => ref
            .read(ttsStateNotifierProvider.notifier)
            .updateTssState(EnumTtsState.stopped));
      }
    }
  });

  // --------------------------------------------------
  //
  // 責務：pause操作時の処理
  //
  // --------------------------------------------------
  static final pausedProvider = Provider.autoDispose<void>((ref) async {
    final ttsState = ref.watch(ttsStateNotifierProvider);
    if (ttsState.value != EnumTtsState.paused) return;

    final ttsRepository = ref.watch(ttsRepositoryProvider);
    await ttsRepository.pause();

    logger.d("pausedProvider: executed");
  });

  // --------------------------------------------------
  //
  // 責務：stop操作時の処理
  //
  // --------------------------------------------------
  static final stoppedProvider = Provider.autoDispose<void>((ref) async {
    final ttsState = ref.watch(ttsStateNotifierProvider);
    if (ttsState.value != EnumTtsState.stopped) return;

    final ttsRepository = ref.watch(ttsRepositoryProvider);
    await ttsRepository.stop();

    unawaited(Future(() =>
        ref.read(currentTextPointProvider.notifier).update((state) => 0)));

    logger.d("stoppedProvider: executed");
  });

  // --------------------------------------------------
  //
  // 責務：junping操作時の処理
  //
  // --------------------------------------------------
  static final junpingProvider = Provider.autoDispose<void>((ref) async {
    final ttsState = ref.watch(ttsStateNotifierProvider);
    if (ttsState.value != EnumTtsState.junping) return;

    final ttsRepository = ref.watch(ttsRepositoryProvider);
    await ttsRepository.stop();

    unawaited(Future(() => ref
        .read(ttsStateNotifierProvider.notifier)
        .updateTssState(EnumTtsState.playing)));

    logger.d("stoppedProvider: executed");
  });
}
