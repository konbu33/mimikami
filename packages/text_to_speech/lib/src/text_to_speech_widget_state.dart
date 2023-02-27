import 'package:hooks_riverpod/hooks_riverpod.dart';

class TextToSpeechWidgetState {
  static final languageStateProvider = StateProvider<String?>((ref) => "en-US");

  static final volumeStateProvider = StateProvider<double>((ref) => 0.5);
  static final pitchStateProvider = StateProvider<double>((ref) => 1.0);
  static final rateStateProvider = StateProvider<double>((ref) => 0.5);
  static final newVoiceTextStateProvider = StateProvider<String?>((ref) => "");
}
