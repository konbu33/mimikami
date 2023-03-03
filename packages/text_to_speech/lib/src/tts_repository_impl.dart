import 'package:common/common.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:text_to_speech/src/initialize_tts.dart';

import 'tts_repository.dart';

final ttsRepositoryProvider = Provider((ref) {
  final initTts = ref.watch(initializedTtsProvider);
  return TtsRepositoryImpl(flutterTts: initTts());
});

class TtsRepositoryImpl implements TtsRepository {
  const TtsRepositoryImpl({required this.flutterTts});

  @override
  final FlutterTts flutterTts;

  @override
  Future speak({
    required double volume,
    required double rate,
    required double pitch,
    required String? newVoiceText,
  }) async {
    logger.d("speak called: $volume, $rate, $pitch, $newVoiceText");
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (newVoiceText == null) return;
    if (newVoiceText.isEmpty) return;
    await flutterTts.speak(newVoiceText);
  }

  @override
  Future<int> stop() async {
    final result = await flutterTts.stop();
    return result;
    // if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  Future<void> awaitSpeakCompletion() async {
    final result = await flutterTts.awaitSpeakCompletion(true);
    return result;
  }

  @override
  Future<int> pause() async {
    final result = await flutterTts.pause();
    return result;
    // if (result == 1) setState(() => ttsState = TtsState.paused);
  }

  @override
  Future<dynamic> getLanguages() async => await flutterTts.getLanguages;

  @override
  Future<dynamic> getEngines() async => await flutterTts.getEngines;

  @override
  Future<int?> getMaxSpeechInputLength() async {
    final res = await flutterTts.getMaxSpeechInputLength;
    return res;
  }

  @override
  Future<dynamic> setLanguage(String language) async =>
      await flutterTts.setLanguage(language);

  @override
  Future<dynamic> isLanguageInstalled(String language) async =>
      await flutterTts.isLanguageInstalled(language);

  @override
  Future<dynamic> setEngine(String selectedEngine) async =>
      await flutterTts.setEngine(selectedEngine);

  @override
  Future getDefaultEngine() async {
    final engine = await flutterTts.getDefaultEngine;
    return engine;
  }

  @override
  Future getDefaultVoice() async {
    final voice = await flutterTts.getDefaultVoice;
    return voice;
  }
}
