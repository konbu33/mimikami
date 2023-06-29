import 'dart:async';

import 'package:common/common.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:text_to_speech/src/platform_state.dart';

import 'text_to_speech_state.dart';
import 'tts_repository_impl.dart';

part 'text_to_speech_widget_state.g.dart';

class TextToSpeechWidgetState {
  static final languageStateProvider = _languageStateProvider;

  static final volumeStateProvider = _volumeStateProvider;
  static final pitchStateProvider = _pitchStateProvider;
  static final rateStateProvider = _rateStateProvider;

  static final newVoiceTextStateProvider = _newVoiceTextStateProvider;
  static final autoScrollControllerProvider = _autoScrollControllerProvider;

  static final currentTextListStateProvider = _currentTextListStateProvider;
  static final currentTextPointProvider = _currentTextPointProvider;
  static final currentTextProvider = _currentTextProvider;

  static final playingProvider = _playingProvider;
  static final playingCompleteProvider = _playingCompleteProvider;
  static final pausedProvider = _pausedProvider;
  static final stoppedProvider = _stoppedProvider;
  static final junpingProvider = _junpingProvider;

  static final isScrollingProvider = _isScrollingProvider;
  static final isScrollingCancelTimerProvider = _isScrollingCancelTimerProvider;
}

@riverpod
class _LanguageState extends _$LanguageState {
  @override
  String? build() => "ja-JP";

  void update(String? value) {
    state = value ?? "ja-JP";
  }
}

@Riverpod(keepAlive: true)
class _VolumeState extends _$VolumeState {
  @override
  double build() => 0.5;

  void update(double value) {
    state = value;
  }
}

@Riverpod(keepAlive: true)
class _PitchState extends _$PitchState {
  @override
  double build() {
    return 1.0;
  }

  void update(double value) {
    state = value;
  }
}

@Riverpod(keepAlive: true)
class _RateState extends _$RateState {
  @override
  double build() {
    return 0.7;
  }

  void update(double value) {
    state = value;
  }
}

@riverpod
class _NewVoiceTextState extends _$NewVoiceTextState {
  @override
  String? build() {
    return "";
  }

  void update(String value) {
    state = value;
  }
}

@riverpod
class _AutoScrollController extends _$AutoScrollController {
  @override
  AutoScrollController build() {
    return AutoScrollController();
  }
}

@riverpod
class _IsScrolling extends _$IsScrolling {
  @override
  bool build() {
    return false;
  }

  void update(bool value) {
    state = value;
  }
}

@riverpod
class _IsScrollingCancelTimer extends _$IsScrollingCancelTimer {
  @override
  Timer Function() build() {
    // Timerをそのまま返すと、返した時点でTimerが開始される様子で、
    // Timerの開始タイミングをコントロールできないため、Timerを返す関数を返す。
    // この関数を呼び出した時点で、Timerが開始されるようにする。
    Timer timer() {
      return Timer.periodic(const Duration(seconds: 1), (timer) {
        logger.d("timer: executed date: ${timer.tick} : ${DateTime.now()}");
        // 1秒毎に、繰り返し、5回実行したら、スクロール中状態を解除し、タイマーもキャンセルする。
        if (timer.tick == 5) {
          unawaited(Future(() => ref
              .read(TextToSpeechWidgetState.isScrollingProvider.notifier)
              .update(false)));
          timer.cancel();
        }
      });
    }

    return timer;
  }
}

// --------------------------------------------------
//
// 責務：読み上げ対象の文章を保持(配列)
//
// --------------------------------------------------
@riverpod
class _CurrentTextListState extends _$CurrentTextListState {
  @override
  List<String> build() {
    // 読み上げるコンテンツがタップされた時、配列として保持する。
    final newVoiceText =
        ref.watch(TextToSpeechWidgetState.newVoiceTextStateProvider);

    if (newVoiceText == null) return [];
    if (newVoiceText.isEmpty) return [];
    final String voiceText = newVoiceText;

    // 区切り文字毎に、配列を作成する。
    final re = RegExp(r'。|、|;');
    final List<String> currentTextList = voiceText.split(re);

    return currentTextList;
  }
}

// --------------------------------------------------
//
// 責務：読み上げ中の文章の位置を返す
//
// --------------------------------------------------
@riverpod
class _CurrentTextPoint extends _$CurrentTextPoint {
  @override
  int build() {
    // 現在の文章が更新された時、初期化する。
    ref.watch(TextToSpeechWidgetState.currentTextListStateProvider);
    return 0;
  }

  void update(int value) {
    state = value;
  }

  void increment() {
    state = state + 1;
  }

  void decrement() {
    if (state <= 0) return;
    state = state - 1;
  }
}

// --------------------------------------------------
//
// 責務：現在の文章を返す
//
// --------------------------------------------------
@riverpod
class _CurrentText extends _$CurrentText {
  @override
  String build() {
    // 現在の文章が更新された時 or 現在の文章の位置が更新された時
    final currentTextList =
        ref.watch(TextToSpeechWidgetState.currentTextListStateProvider);
    final currentTextPoint =
        ref.watch(TextToSpeechWidgetState.currentTextPointProvider);

    // 空の場合は空文字を返す
    if (currentTextList.isEmpty) return "";
    if (currentTextList.length <= currentTextPoint) return "";

    // 空白除去
    final currentTextNoTrim = currentTextList[currentTextPoint];
    final currentText = currentTextNoTrim.replaceAll(RegExp(r"\s+"), '');
    return currentText;
  }
}

// --------------------------------------------------
//
// 責務：playing操作時の処理
//
// --------------------------------------------------
@riverpod
void _playing(_PlayingRef ref) async {
  // ttsStateが変化した時 or currentTextが変化した時
  final ttsState = ref.watch(ttsStateNotifierProvider);
  final currentText = ref.watch(TextToSpeechWidgetState.currentTextProvider);

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
          .read(TextToSpeechWidgetState.currentTextPointProvider.notifier)
          .increment());
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
}

// --------------------------------------------------
//
// 責務：完読時の処理
//
// --------------------------------------------------
@riverpod
void _playingComplete(_PlayingCompleteRef ref) {
  final currentTextPoint =
      ref.watch(TextToSpeechWidgetState.currentTextPointProvider);
  final currentTextListLength =
      ref.watch(TextToSpeechWidgetState.currentTextListStateProvider).length;

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
}

// --------------------------------------------------
//
// 責務：pause操作時の処理
//
// --------------------------------------------------
@riverpod
void _paused(_PausedRef ref) async {
  final ttsState = ref.watch(ttsStateNotifierProvider);
  if (ttsState.value != EnumTtsState.paused) return;

  final ttsRepository = ref.watch(ttsRepositoryProvider);
  await ttsRepository.pause();

  logger.d("pausedProvider: executed");
}

// --------------------------------------------------
//
// 責務：stop操作時の処理
//
// --------------------------------------------------
@riverpod
void _stopped(_StoppedRef ref) async {
  final ttsState = ref.watch(ttsStateNotifierProvider);
  if (ttsState.value != EnumTtsState.stopped) return;

  final ttsRepository = ref.watch(ttsRepositoryProvider);
  await ttsRepository.stop();

  unawaited(Future(() => ref
      .read(TextToSpeechWidgetState.currentTextPointProvider.notifier)
      .update(0)));

  logger.d("stoppedProvider: executed");
}

// --------------------------------------------------
//
// 責務：junping操作時の処理
//
// --------------------------------------------------
@riverpod
void _junping(_JunpingRef ref) async {
  final ttsState = ref.watch(ttsStateNotifierProvider);
  if (ttsState.value != EnumTtsState.jumping) return;

  // 読み上げ途中でも途中で中断するために、stopを実行する。
  final ttsRepository = ref.watch(ttsRepositoryProvider);
  await ttsRepository.stop();

  // iOSの場合、setCompletionHandlerが呼ばれるため、setCompletionHandler側で再度playを実行する。
  // Androidの場合、stop時に、setCompletionHandlerが呼ばれないため、この時点で、再度playを実行する。
  final isAndroid = ref.watch(PlatformState.isAndroidStateProvider);
  if (isAndroid) {
    unawaited(Future.wait([
      Future(() => ref
          .read(ttsStateNotifierProvider.notifier)
          .updateTssState(EnumTtsState.playing)),
    ]));
  }

  logger.d("stoppedProvider: executed");
}
