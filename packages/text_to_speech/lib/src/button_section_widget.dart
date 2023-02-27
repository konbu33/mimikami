import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'text_to_speech_widget_state.dart';
import 'tts_repository_impl.dart';

class ButtonSectionWidget extends StatelessWidget {
  const ButtonSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Column buildButtonColumn(
      Color color,
      Color splashColor,
      IconData icon,
      String label,
      Function func,
    ) {
      return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                icon: Icon(icon),
                color: color,
                splashColor: splashColor,
                onPressed: () {
                  logger.d("Button pressed");
                  func();
                }),
            Container(
                margin: const EdgeInsets.only(top: 8.0),
                child: Text(label,
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: color)))
          ]);
    }

    return Consumer(builder: (context, ref, child) {
      final ttsRepository = ref.watch(ttsRepositoryProvider);
      final volume = ref.watch(TextToSpeechWidgetState.volumeStateProvider);
      final pitch = ref.watch(TextToSpeechWidgetState.pitchStateProvider);
      final rate = ref.watch(TextToSpeechWidgetState.rateStateProvider);
      final newVoiceText =
          ref.watch(TextToSpeechWidgetState.newVoiceTextStateProvider);

      return Container(
        padding: const EdgeInsets.only(top: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildButtonColumn(
                Colors.green,
                Colors.greenAccent,
                Icons.play_arrow,
                'PLAY',
                () => ttsRepository.speak(
                      volume: volume,
                      pitch: pitch,
                      rate: rate,
                      newVoiceText: newVoiceText,
                    )),
            buildButtonColumn(Colors.red, Colors.redAccent, Icons.stop, 'STOP',
                ttsRepository.stop),
            buildButtonColumn(Colors.blue, Colors.blueAccent, Icons.pause,
                'PAUSE', ttsRepository.pause),
          ],
        ),
      );
    });
  }
}
