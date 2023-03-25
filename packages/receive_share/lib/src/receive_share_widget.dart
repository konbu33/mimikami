import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'receive_share_widget.g.dart';

// --------------------------------------------------
//
// ReceiveShareWidgetState
//
// --------------------------------------------------
class ReceiveShareWidgetState {
  // ShareされたURLを保持する
  static final sharedTextProvider = _sharedTextProvider;

  // 他アプリからURLがShareされてくるのを待機・Shareされたら保持する。
  static final intentDataStreamSubscriptionProvider =
      _intentDataStreamSubscriptionProvider;
}

@riverpod
class _SharedText extends _$SharedText {
  @override
  String build() {
    return "";
  }

  void update(String value) {
    state = value;
  }
}

// 他アプリからURLがShareされてくるのを待機・Shareされたら保持する。
@riverpod
_intentDataStreamSubscription(_IntentDataStreamSubscriptionRef ref) {
  return ReceiveSharingIntent.getTextStream().listen((String value) {
    logger.d("received Shared: $value");
    ref.read(_sharedTextProvider.notifier).update(value);
  }, onError: (err) {
    logger.e("received Shared error: $err");
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
        // final sharedText =
        //     ref.watch(ReceiveShareWidgetState.sharedTextProvider);

        return const SizedBox();
        // return SizedBox(
        //   height: 100,
        //   child: Text("sharedText : $sharedText"),
        // );
      },
    );
  }
}
