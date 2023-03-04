import 'dart:async';

import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'button_section_widget.dart';
import 'engine_list_widget.dart';
import 'initialize_tts.dart';
import 'language_list_widget.dart';
import 'slider_section_widget.dart';
import 'text_to_speech_widget_state.dart';
import 'tts_repository_impl.dart';
import 'tts_state_widget.dart';

class TextToSpeechWidget extends StatefulHookConsumerWidget {
  const TextToSpeechWidget({super.key, required this.contents});

  final String contents;

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
    return Column(
      children: [
        TextToSpeechWidgetParts.ttsControllerWidget(),
        TextToSpeechWidgetParts.ttsContentsWidget(widget.contents),
      ],
    );
  }
}

class TextToSpeechWidgetParts {
  // --------------------------------------------------
  // ttsControllerWidget
  // --------------------------------------------------
  static Widget ttsControllerWidget() {
    return Column(
      children: const [
        ButtonSectionWidget(),
        TtsStateWidget(),
        EngineListWidget(),
        LanguageListWidget(),
        SliderSectionWidget(),
      ],
    );
  }

  // --------------------------------------------------
  // ttsContentsWidget
  // --------------------------------------------------
  static Widget ttsContentsWidget(String contents) {
    return Consumer(builder: (context, ref, child) {
      //

      unawaited(Future(() => ref
          .read(TextToSpeechWidgetState.newVoiceTextStateProvider.notifier)
          .update((state) => contents)));

      final currentTextList =
          ref.watch(TextToSpeechWidgetState.currentTextListStateProvider);

      return Column(
        children: [
          Container(
            color: Colors.amber,
            height: 300,
            child: ListView.builder(
                itemCount: currentTextList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      logger.d("onTap: $index");

                      // ref
                      //     .read(ttsStateNotifierProvider.notifier)
                      //     .updateTssState(EnumTtsState.paused);

                      ref
                          .read(TextToSpeechWidgetState
                              .currentTextPointProvider.notifier)
                          .update((state) => index);
                    },
                    child: Text(currentTextList[index]),
                  );
                }),
          ),
        ],
      );
    });
  }
}
