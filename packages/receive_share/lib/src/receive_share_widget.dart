import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:receive_sharing_intent/receive_sharing_intent.dart';

// --------------------------------------------------
//
// ReceiveShareWidgetState
//
// --------------------------------------------------
class ReceiveShareWidgetState {
  // ShareされたURLを保持する
  static final sharedTextProvider = StateProvider((ref) => "");

  // 他アプリからURLがShareされてくるのを待機・Shareされたら保持する。
  static final intentDataStreamSubscriptionProvider =
      StateProvider.autoDispose((ref) {
    return ReceiveSharingIntent.getTextStream().listen((String value) {
      logger.d("received Shared: $value");
      ref.watch(sharedTextProvider.notifier).update((state) => value);
    }, onError: (err) {
      logger.d("getLinkStream error: $err");
    });
  });
}

// --------------------------------------------------
//
// ReceiveShareWidget
//
// --------------------------------------------------
class ReceiveShareWidget extends StatelessWidget {
  const ReceiveShareWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        // 他アプリからURLがShareされてくるのを待機
        ref.watch(ReceiveShareWidgetState.intentDataStreamSubscriptionProvider);

        return const SizedBox();
      },
    );
  }
}
