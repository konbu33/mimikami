import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:text_to_speech/src/text_to_speech_state.dart';

import 'text_to_speech_widget_state.dart';

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
      // final ttsRepository = ref.watch(ttsRepositoryProvider);

      // final currentTextPoint =
      //     ref.watch(TextToSpeechWidgetState.currentTextPointProvider);

      // logger.d("currentTextPoint: $currentTextPoint ");

      // トリガー開始
      // final ttsState =
      //     ref.watch(ttsStateNotifierProvider);

      final currentTextList =
          ref.watch(TextToSpeechWidgetState.currentTextListStateProvider);
      ref.watch(TextToSpeechWidgetState.playingProvider);
      ref.watch(TextToSpeechWidgetState.playingCompleteProvider);
      ref.watch(TextToSpeechWidgetState.pausedProvider);
      ref.watch(TextToSpeechWidgetState.stoppedProvider);

      return Container(
        padding: const EdgeInsets.only(top: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.play_arrow),
              onPressed: currentTextList.isEmpty ||
                      ref.read(ttsStateNotifierProvider.notifier).isPlaying()
                  ? null
                  : () async {
                      logger.d("Button pressed");
                      ref
                          .read(ttsStateNotifierProvider.notifier)
                          .updateTssState(EnumTtsState.playing);

                      return;

                      //   const limitLength = 3500;

                      //   bool containJapanese(String text) {
                      //     return RegExp(
                      //             r'[\u3040-\u309F]|\u3000|[\u30A1-\u30FC]|[\u4E00-\u9FFF]')
                      //         .hasMatch(text);
                      //   }

                      //   // while (currentTextPoint < currentTextList.length) {
                      //   for (int i = ref.watch(
                      //           TextToSpeechWidgetState.currentTextPointProvider);
                      //       i < 5;
                      //       i++) {
                      //     final currentText = currentTextList[i];
                      //     // logger.d("i: $i, currentTextPoint: $currentTextPoint ");
                      //     logger.d("currentText: $currentText");

                      //     if (currentText.isEmpty) {
                      //       ref
                      //           .read(TextToSpeechWidgetState
                      //               .currentTextPointProvider.notifier)
                      //           .update((state) => i);
                      //       continue;
                      //     }

                      //     if (currentText.length > limitLength) {
                      //       ref
                      //           .read(TextToSpeechWidgetState
                      //               .currentTextPointProvider.notifier)
                      //           .update((state) => i);

                      //       continue;
                      //     }

                      //     if (!containJapanese(currentText)) {
                      //       ref
                      //           .read(TextToSpeechWidgetState
                      //               .currentTextPointProvider.notifier)
                      //           .update((state) => i);

                      //       continue;
                      //     }

                      //     // await ttsRepository.speak(
                      //     //   volume: ref.watch(
                      //     //       TextToSpeechWidgetState.volumeStateProvider),
                      //     //   pitch: ref.watch(
                      //     //       TextToSpeechWidgetState.pitchStateProvider),
                      //     //   rate: ref
                      //     //       .watch(TextToSpeechWidgetState.rateStateProvider),
                      //     //   newVoiceText: currentText,
                      //     // );

                      //     ref
                      //         .read(TextToSpeechWidgetState
                      //             .currentTextPointProvider.notifier)
                      //         .update((state) => i);
                      //   }
                    },
            ),

            // buildButtonColumn(
            //     Colors.green,
            //     Colors.greenAccent,
            //     Icons.play_arrow,
            //     'PLAY',
            //     () => ttsRepository.speak(
            //           volume: volume,
            //           pitch: pitch,
            //           rate: rate,
            //           newVoiceText: newVoiceText,
            //         )),
            buildButtonColumn(
              Colors.red,
              Colors.redAccent,
              Icons.stop,
              'STOP',
              // ttsRepository.stop,
              () {
                ref
                    .read(ttsStateNotifierProvider.notifier)
                    .updateTssState(EnumTtsState.stopped);
              },
            ),
            buildButtonColumn(
              Colors.blue,
              Colors.blueAccent,
              Icons.pause,
              'PAUSE',
              // ttsRepository.pause,
              () {
                ref
                    .read(ttsStateNotifierProvider.notifier)
                    .updateTssState(EnumTtsState.paused);
              },
            ),
          ],
        ),
      );
    });
  }
}
