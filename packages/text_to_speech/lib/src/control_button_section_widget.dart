import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:text_to_speech/src/text_to_speech_state.dart';

import 'control_button_widget.dart';
import 'text_to_speech_widget_state.dart';

class ControlButtonSectionWidget extends StatelessWidget {
  const ControlButtonSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      //

      return Container(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ControlButtonSectionWidgetParts.playButtonWidget(),
            ControlButtonSectionWidgetParts.pauseButtonWidget(),
            ControlButtonSectionWidgetParts.stopButtonWidget(),
          ],
        ),
      );
    });
  }
}

class ControlButtonSectionWidgetParts {
  static Widget playButtonWidget() {
    //

    final widget = Consumer(builder: (context, ref, child) {
      final ttsState = ref.watch(ttsStateNotifierProvider);

      final currentTextList =
          ref.watch(TextToSpeechWidgetState.currentTextListStateProvider);

      return ControlButtonWidget(
        color: Colors.green,
        splashColor: Colors.greenAccent,
        icon: Icons.play_arrow,
        label: 'PLAY',
        func: () =>
            currentTextList.isEmpty || ttsState.value == EnumTtsState.playing
                ? null
                : () {
                    ref
                        .read(ttsStateNotifierProvider.notifier)
                        .updateTssState(EnumTtsState.playing);

                    return;
                  },
      );
    });

    return widget;
  }

  static Widget pauseButtonWidget() {
    //

    final widget = Consumer(builder: (context, ref, child) {
      final ttsState = ref.watch(ttsStateNotifierProvider);

      return ControlButtonWidget(
        color: Colors.blue,
        splashColor: Colors.blueAccent,
        icon: Icons.pause,
        label: 'PAUSE',
        func: () => ttsState.value != EnumTtsState.playing
            ? null
            : () {
                ref
                    .read(ttsStateNotifierProvider.notifier)
                    .updateTssState(EnumTtsState.paused);
              },
      );
    });

    return widget;
  }

  static Widget stopButtonWidget() {
    //

    final widget = Consumer(builder: (context, ref, child) {
      final ttsState = ref.watch(ttsStateNotifierProvider);

      return ControlButtonWidget(
        color: Colors.red,
        splashColor: Colors.redAccent,
        icon: Icons.stop,
        label: 'STOP',
        func: () => ttsState.value == EnumTtsState.stopped
            ? null
            : () {
                ref
                    .read(ttsStateNotifierProvider.notifier)
                    .updateTssState(EnumTtsState.stopped);
              },
      );
    });

    return widget;
  }
}
