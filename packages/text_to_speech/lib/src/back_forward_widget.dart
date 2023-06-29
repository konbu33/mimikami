import 'dart:async';

import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'text_to_speech_state.dart';

class BackForwardWidget extends ConsumerStatefulWidget {
  const BackForwardWidget({
    super.key,
    required this.isRightSide,
    required this.onDoubleTap,
    required this.icon,
  });

  final bool isRightSide;
  final void Function() onDoubleTap;
  final IconData icon;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BackForwardWidgetState();
}

class _BackForwardWidgetState extends ConsumerState<BackForwardWidget> {
  int pressCount = 0;
  late Timer timer;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(
          MediaQuery.of(context).size.width *
              0.9 *
              (widget.isRightSide ? 1 : -1),
          0),
      child: InkWell(
        // splashColor の範囲を楕円にするために borderRadius を設定
        borderRadius: BorderRadius.all(
          Radius.elliptical(
            MediaQuery.of(context).size.width * 0.4,
            MediaQuery.of(context).size.height * 0.5,
          ),
        ),
        // onDoubleTap: widget.onDoubleTap,
        onTapDown: (tapDownDetails) {
          logger.d("tapDownDetails: ${tapDownDetails.localPosition}");
          pressCount++;
          setState(() {});

          if (pressCount >= 2) {
            widget.onDoubleTap();
            // pressCount = 0;
            timer = Timer(const Duration(milliseconds: 100), () {
              pressCount = 0;
              setState(() {});

              Future.delayed(const Duration(milliseconds: 700), () {
                if (ref.read(ttsStateNotifierProvider).value !=
                    EnumTtsState.playing) {
                  ref
                      .read(ttsStateNotifierProvider.notifier)
                      .updateTssState(EnumTtsState.playing);
                }
              });
            });
          } else {
            timer = Timer(const Duration(milliseconds: 500), () {
              pressCount = 0;
              setState(() {});
            });
          }
          // logger.d("pressCount: $pressCount");
        },
        child: pressCount != 2
            ? null
            : Container(
                alignment: widget.isRightSide
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Transform.translate(
                  offset: Offset(
                    3 * (widget.isRightSide ? 1 : -1),
                    0,
                    // MediaQuery.of(context).size.width *
                    //     0.1 *
                    //  (widget.isRightSide ? 1 : -1),
                    // MediaQuery.of(context).size.height * 0.1 * -1,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        color: Colors.grey.withOpacity(0.5),
                        size: 40,
                        widget.icon,
                      ),
                      // Text("$pressCount"),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
