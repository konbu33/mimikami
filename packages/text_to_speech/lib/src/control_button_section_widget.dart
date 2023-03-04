import 'package:common/common.dart';
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
            ControlButtonSectionWidgetParts.stopButtonWidget(),
            ControlButtonSectionWidgetParts.pauseButtonWidget(),
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
      final currentTextList =
          ref.watch(TextToSpeechWidgetState.currentTextListStateProvider);

      return ControlButtonWidget(
        color: Colors.green,
        splashColor: Colors.greenAccent,
        icon: Icons.play_arrow,
        label: 'PLAY',
        func: () {
          return currentTextList.isEmpty ||
                  ref.read(ttsStateNotifierProvider.notifier).isPlaying()
              ? null
              : () async {
                  logger.d("Button pressed");
                  ref
                      .read(ttsStateNotifierProvider.notifier)
                      .updateTssState(EnumTtsState.playing);

                  return;
                };
        },
      );
    });

    return widget;
  }

  static Widget stopButtonWidget() {
    //

    final widget = Consumer(builder: (context, ref, child) {
      return ControlButtonWidget(
        color: Colors.red,
        splashColor: Colors.redAccent,
        icon: Icons.stop,
        label: 'STOP',
        func: () => () {
          ref
              .read(ttsStateNotifierProvider.notifier)
              .updateTssState(EnumTtsState.stopped);
        },
      );
    });

    return widget;
  }

  static Widget pauseButtonWidget() {
    //

    final widget = Consumer(builder: (context, ref, child) {
      return ControlButtonWidget(
        color: Colors.blue,
        splashColor: Colors.blueAccent,
        icon: Icons.pause,
        label: 'PAUSE',
        func: () => () {
          ref
              .read(ttsStateNotifierProvider.notifier)
              .updateTssState(EnumTtsState.paused);
        },
      );
    });

    return widget;
  }
}
