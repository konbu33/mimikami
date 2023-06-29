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

      // ユーザがスクロール操作中か？
      final isScrolling =
          ref.watch(TextToSpeechWidgetState.isScrollingProvider);

      // ユーザがスクロール操作を検知し、タイマーを開始する。タイマー終了後、オートするクロールされるようにする。
      final isScrollingCancelTimer =
          ref.watch(TextToSpeechWidgetState.isScrollingCancelTimerProvider);

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),

        // 配列化したデータを表示(onTap可能にする)
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            // playing中のみ、スクロールイベントを検知する。
            if (ref.read(ttsStateNotifierProvider).value !=
                EnumTtsState.playing) return false;

            switch (notification.runtimeType) {
              case UserScrollNotification:
                logger.d(
                    "onNotification ScrollStart: ${notification.runtimeType}");

                // UserScrollNotificationイベントが、スクロール開始時、終了時の2回発生するため、
                // スクロール中の場合は、処理を実行しない。
                // スクロール中以外だった場合のみ、処理を実行する。
                if (!isScrolling) {
                  // スクロール中の状態とする。
                  ref
                      .read(
                          TextToSpeechWidgetState.isScrollingProvider.notifier)
                      .update(true);

                  // スクロール中の状態を解除するためのタイマーを開始する。
                  isScrollingCancelTimer();
                }

                break;

              default:
            }

            return true;
          },
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              controller: autoScrollController,
              itemCount: currentTextList.length,
              itemBuilder: (context, index) {
                //

                final textStyle = TextStyle(
                    color:
                        currentTextPoint == index ? Colors.red : Colors.black);

                return AutoScrollTag(
                  key: ValueKey(index),
                  controller: autoScrollController,
                  index: index,
                  disabled: isScrolling ? true : false,
                  child: GestureDetector(
                    onDoubleTap: () {
                      logger.d("onTap: $index");

                      ref
                          .read(ttsStateNotifierProvider.notifier)
                          .updateTssState(EnumTtsState.jumping);

                      ref
                          .read(TextToSpeechWidgetState
                              .currentTextPointProvider.notifier)
                          .update(index);
                    },
                    child: Text(currentTextList[index], style: textStyle),
                    // child: Text(
                    //     "count: $isScrollingTimer : isScrolling: $isScrolling : ${currentTextList[index]}",
                    //     style: textStyle),
                  ),
                );
              }),
        ),
      );
    });
  }
}
