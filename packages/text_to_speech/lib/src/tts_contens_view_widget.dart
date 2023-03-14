import 'dart:async';

import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:text_to_speech/src/text_to_speech_state.dart';

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

      final autoScrollController =
          ref.watch(TextToSpeechWidgetState.autoScrollControllerProvider);

      // 読み上げ対象のコンテンツを登録
      unawaited(Future(() => ref
          .read(TextToSpeechWidgetState.newVoiceTextStateProvider.notifier)
          .update(contents)));

      // 読み上げ対象のコンテンツを配列化したデータを取得
      final currentTextList =
          ref.watch(TextToSpeechWidgetState.currentTextListStateProvider);

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        height: MediaQuery.of(context).size.height * 0.85,

        // 配列化したデータを表示(onTap可能にする)
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            controller: autoScrollController,
            itemCount: currentTextList.length,
            itemBuilder: (context, index) {
              //

              final textStyle = TextStyle(
                  color: currentTextPoint == index ? Colors.red : Colors.black);

              return AutoScrollTag(
                key: ValueKey(index),
                controller: autoScrollController,
                index: index,
                child: GestureDetector(
                  onDoubleTap: () {
                    logger.d("onTap: $index");

                    ref
                        .read(ttsStateNotifierProvider.notifier)
                        .updateTssState(EnumTtsState.junping);

                    ref
                        .read(TextToSpeechWidgetState
                            .currentTextPointProvider.notifier)
                        .update(index);
                  },
                  child: Text(currentTextList[index], style: textStyle),
                ),
              );
            }),
      );
    });
  }
}
