import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:text_to_speech/src/control_slider_widget.dart';
import 'package:text_to_speech/src/text_to_speech_widget_state.dart';

class ControlSliderSectionWidget extends StatelessWidget {
  const ControlSliderSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliderSectionWidgetParts.volumeWidget(),
        SliderSectionWidgetParts.pitchWidget(),
        SliderSectionWidgetParts.rateWidget(),
      ],
    );
  }
}

class SliderSectionWidgetParts {
  static Widget volumeWidget() {
    //

    final widget = Consumer(builder: (context, ref, child) {
      return ControlSliderWidget(
        onChanged: (newVolume) {
          ref
              .read(TextToSpeechWidgetState.volumeStateProvider.notifier)
              .update(newVolume);
        },
        min: 0.0,
        max: 1.0,
        divisions: 10,
        label: "volume",
        activeColor: Colors.blue,
        value: ref.watch(TextToSpeechWidgetState.volumeStateProvider),
      );
    });

    return widget;
  }

  static Widget pitchWidget() {
    //

    final widget = Consumer(builder: (context, ref, child) {
      return ControlSliderWidget(
        onChanged: (newPitch) {
          ref
              .read(TextToSpeechWidgetState.pitchStateProvider.notifier)
              .update(newPitch);
        },
        min: 0.5,
        max: 2.0,
        divisions: 15,
        label: "pitch",
        activeColor: Colors.red,
        value: ref.watch(TextToSpeechWidgetState.pitchStateProvider),
      );
    });

    return widget;
  }

  static Widget rateWidget() {
    final widget = Consumer(builder: (context, ref, child) {
      return ControlSliderWidget(
        onChanged: (newRate) {
          ref
              .read(TextToSpeechWidgetState.rateStateProvider.notifier)
              .update(newRate);
        },
        min: 0.0,
        max: 1.0,
        divisions: 10,
        label: "rate",
        activeColor: Colors.green,
        value: ref.watch(TextToSpeechWidgetState.rateStateProvider),
      );
    });

    return widget;
  }
}
