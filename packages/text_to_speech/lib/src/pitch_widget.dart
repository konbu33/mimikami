import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'text_to_speech_widget_state.dart';

class PitchWidget extends StatelessWidget {
  const PitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final pitch = ref.watch(TextToSpeechWidgetState.pitchStateProvider);

        return Slider(
          value: pitch,
          onChanged: (newPitch) {
            ref
                .read(TextToSpeechWidgetState.pitchStateProvider.notifier)
                .update((state) => newPitch);
          },
          min: 0.5,
          max: 2.0,
          divisions: 15,
          label: "Pitch: $pitch",
          activeColor: Colors.red,
        );
      },
    );
  }
}
