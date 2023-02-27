import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'text_to_speech_widget_state.dart';

class VolumeWidget extends StatelessWidget {
  const VolumeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final volume = ref.watch(TextToSpeechWidgetState.volumeStateProvider);

      return Slider(
        value: volume,
        onChanged: (newVolume) {
          ref
              .read(TextToSpeechWidgetState.volumeStateProvider.notifier)
              .update((state) => newVolume);
        },
        min: 0.0,
        max: 1.0,
        divisions: 10,
        label: "Volume: $volume",
      );
    });
  }
}
