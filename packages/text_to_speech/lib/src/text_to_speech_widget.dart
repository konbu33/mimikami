import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:text_to_speech/src/tts_repository_impl.dart';

import 'button_section_widget.dart';
import 'engine_list_widget.dart';
import 'get_max_speech_input_length_section_widget.dart';
import 'initialize_tts.dart';
import 'input_section_widget.dart';
import 'language_list_widget.dart';
import 'platform_state.dart';
import 'slider_section_widget.dart';

class TextToSpeechWidget extends StatefulHookConsumerWidget {
  const TextToSpeechWidget({super.key});

  @override
  ConsumerState<TextToSpeechWidget> createState() => _TextToSpeechWidgetState();
}

class _TextToSpeechWidgetState extends ConsumerState<TextToSpeechWidget> {
  @override
  initState() {
    super.initState();
    unawaited(Future(() => ref.watch(initializedTtsProvider)()));
  }

  @override
  void dispose() {
    super.dispose();
    final ttsRepository = ref.watch(ttsRepositoryProvider);
    ttsRepository.stop();
  }

  @override
  Widget build(BuildContext context) {
    final isAndroid = ref.watch(PlatformState.isAndroidStateProvider);

    return ProviderScope(
      child: Column(
        children: [
          const InputSectionWidget(),
          const ButtonSectionWidget(),
          const EngineListWidget(),
          const LanguageListWidget(),
          const SliderSectionWidget(),
          if (isAndroid) const GetMaxSpeechInputLengthSectionWidget(),
        ],
      ),
    );
  }
}
