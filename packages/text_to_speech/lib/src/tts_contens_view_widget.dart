import 'dart:async';

import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'text_to_speech_widget_state.dart';

class TtsContentsViewWidget extends HookConsumerWidget {
  const TtsContentsViewWidget({super.key, required this.contents});

  final String contents;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(builder: (context, ref, child) {
      //

      final currentTextPoint =
          ref.watch(TextToSpeechWidgetState.currentTextPointProvider);

      // 読み上げ対象のコンテンツを登録
      unawaited(Future(() => ref
          .read(TextToSpeechWidgetState.newVoiceTextStateProvider.notifier)
          .update((state) => contents)));

      // 読み上げ対象のコンテンツを配列化したデータを取得
      final currentTextList =
          ref.watch(TextToSpeechWidgetState.currentTextListStateProvider);

      return Container(
        // color: Colors.amber,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        height: MediaQuery.of(context).size.height * 0.85,

        // 配列化したデータを表示(onTap可能にする)
        child: ListView.builder(
            itemCount: currentTextList.length,
            itemBuilder: (context, index) {
              //

              final textStyle = TextStyle(
                  color: currentTextPoint == index ? Colors.red : Colors.black);

              return GestureDetector(
                onTap: () {
                  logger.d("onTap: $index");

                  // ref
                  //     .read(ttsStateNotifierProvider.notifier)
                  //     .updateTssState(EnumTtsState.paused);

                  ref
                      .read(TextToSpeechWidgetState
                          .currentTextPointProvider.notifier)
                      .update((state) => index);
                },
                child: Text(currentTextList[index], style: textStyle),
              );
            }),
      );
    });
  }
}
