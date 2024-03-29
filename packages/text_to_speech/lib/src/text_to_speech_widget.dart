import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:text_to_speech/src/tts_repository_impl.dart';

import 'back_forward_widget.dart';
import 'initialize_tts.dart';
import 'text_to_speech_state.dart';
import 'text_to_speech_widget_state.dart';
import 'tts_contents_view_widget.dart';
import 'tts_controller_widget.dart';

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
    ref.watch(ttsRepositoryProvider).stop();

    // final ttsRepository = ref.watch(ttsRepositoryProvider);
    // ttsRepository.stop();

    // unawaited(Future(() => ref
    //     .watch(ttsStateNotifierProvider.notifier)
    //     .updateTssState(EnumTtsState.stopped)));
  }

  @override
  Widget build(BuildContext context) {
    //

    ref.watch(TextToSpeechWidgetState.playingProvider);
    ref.watch(TextToSpeechWidgetState.playingCompleteProvider);
    ref.watch(TextToSpeechWidgetState.pausedProvider);
    ref.watch(TextToSpeechWidgetState.stoppedProvider);
    ref.watch(TextToSpeechWidgetState.junpingProvider);

    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        TtsContentsViewWidget(contents: widget.contents),
        BackForwardWidget(
          isRightSide: false,
          icon: Icons.keyboard_double_arrow_left_outlined,
          onDoubleTap: () {
            // logger.d("onDoubleTap: Left");

            if (ref.read(ttsStateNotifierProvider).value ==
                EnumTtsState.playing) {
              ref
                  .read(ttsStateNotifierProvider.notifier)
                  .updateTssState(EnumTtsState.paused);
            }

            ref
                .read(TextToSpeechWidgetState.currentTextPointProvider.notifier)
                .decrement();
          },
        ),
        BackForwardWidget(
          isRightSide: true,
          icon: Icons.keyboard_double_arrow_right_outlined,
          onDoubleTap: () {
            // logger.d("onDoubleTap: Right");

            if (ref.read(ttsStateNotifierProvider).value ==
                EnumTtsState.playing) {
              ref
                  .read(ttsStateNotifierProvider.notifier)
                  .updateTssState(EnumTtsState.paused);
            }

            ref
                .read(TextToSpeechWidgetState.currentTextPointProvider.notifier)
                .increment();
          },
        ),
        const TtsControllerWidget(),
      ],
    );
  }
}
