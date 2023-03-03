import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'text_to_speech_state.dart';
import 'text_to_speech_widget_state.dart';

class TtsStateWidget extends HookConsumerWidget {
  const TtsStateWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTextPoint =
        ref.watch(TextToSpeechWidgetState.currentTextPointProvider);

    final ttsState = ref.watch(ttsStateNotifierProvider);

    return Column(
      children: [
        Text("currentTextPoint: $currentTextPoint"),
        Text("ttsState: ${ttsState.value}"),
      ],
    );
  }
}
