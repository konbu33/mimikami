import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'text_to_speech_state.freezed.dart';

enum EnumTtsState {
  playing,
  stopped,
  paused,
  continued,
}

@freezed
class TtsState with _$TtsState {
  const factory TtsState._({
    required EnumTtsState value,
  }) = _TtsState;

  factory TtsState.create({
    EnumTtsState? value,
  }) =>
      TtsState._(
        value: value ?? EnumTtsState.stopped,
      );
}

class TtsStateNotifier extends Notifier<TtsState> {
  @override
  TtsState build() {
    return TtsState.create();
  }

  void updateTssState(EnumTtsState value) {
    state = state.copyWith(value: value);
  }

  bool isPlaying() => state.value == EnumTtsState.playing;
  bool isStopped() => state.value == EnumTtsState.stopped;
  bool isPaused() => state.value == EnumTtsState.paused;
  bool isContinued() => state.value == EnumTtsState.continued;
}

final ttsStateNotifierProvider = NotifierProvider<TtsStateNotifier, TtsState>(
  () => TtsStateNotifier(),
);
