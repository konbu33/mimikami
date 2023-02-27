import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'text_to_speech_widget_state.dart';

class RateWidget extends StatelessWidget {
  const RateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final rate = ref.watch(TextToSpeechWidgetState.rateStateProvider);

      return Slider(
        value: rate,
        onChanged: (newRate) {
          ref
              .read(TextToSpeechWidgetState.rateStateProvider.notifier)
              .update((state) => newRate);
        },
        min: 0.0,
        max: 1.0,
        divisions: 10,
        label: "Rate: $rate",
        activeColor: Colors.green,
      );
    });
  }
}
