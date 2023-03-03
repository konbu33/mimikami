import 'package:flutter_tts/flutter_tts.dart';

class TtsRepository {
  const TtsRepository({required this.flutterTts});

  final FlutterTts flutterTts;

  Future speak({
    required double volume,
    required double rate,
    required double pitch,
    required String? newVoiceText,
  }) async {}
  Future stop() async {}
  Future awaitSpeakCompletion() async {}
  Future pause() async {}
  Future<dynamic> getLanguages() async {}

  Future<dynamic> getEngines() async {}
  // Future<int?> getMaxSpeechInputLength() async {}
  Future<void> getMaxSpeechInputLength() async {}
  Future<dynamic> setLanguage(String language) async {}
  Future<dynamic> isLanguageInstalled(String language) async {}
  Future<dynamic> setEngine(String selectedEngine) async {}

  Future getDefaultEngine() async {}
  Future getDefaultVoice() async {}
}
