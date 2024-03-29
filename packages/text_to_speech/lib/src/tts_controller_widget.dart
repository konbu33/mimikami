import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'control_button_section_widget.dart';
import 'control_engine_widget.dart';
import 'control_language_widget.dart';
import 'control_slider_section_widget.dart';
import 'text_to_speech_state.dart';
import 'text_to_speech_widget_state.dart';

class TtsControllerWidget extends StatefulWidget {
  const TtsControllerWidget({super.key});

  @override
  State<TtsControllerWidget> createState() => _TtsControllerWidgetState();
}

class _TtsControllerWidgetState extends State<TtsControllerWidget>
    with SingleTickerProviderStateMixin {
  bool isVisible = false;

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    final tween = Tween(begin: 1.5, end: 4.0);

    // animation = controller.drive(tween);
    animation = tween.animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    logger.d("initState: $isVisible, animation value: ${animation.value}");

    super.initState();
  }

  @override
  void dispose() {
    logger.d("dispose: $isVisible, animation value: ${animation.value}");

    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   logger.d("onTap");
      //   isVisible = !isVisible;
      //   setState(() {});
      // },

      onVerticalDragEnd: (details) async {
        logger.d("onVerticalDragEnd: ${details.primaryVelocity}");
        final verocity = details.primaryVelocity ?? 0;

        if (verocity < 0) {
          await controller.forward();
          verocity < 0 ? isVisible = true : isVisible = false;
        } else {
          verocity < 0 ? isVisible = true : isVisible = false;
          await controller.reverse();
        }

        setState(() {});
      },
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Container(
            height: isVisible ? 100 * animation.value : 100 * animation.value,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                TtsControllerWidgetParts.barWidget(),
                const ControlButtonSectionWidget(),
                !isVisible
                    ? const SizedBox()
                    : Column(
                        children: const [
                          ControlEngineWidget(),
                          ControlLanguageWidget(),
                          ControlSliderSectionWidget(),
                        ],
                      ),
                TtsControllerWidgetParts.ttsStateWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TtsControllerWidgetParts {
  //

  static Widget ttsStateWidget() {
    //
    final widget = Consumer(builder: (context, ref, child) {
      final currentTextPoint =
          ref.watch(TextToSpeechWidgetState.currentTextPointProvider);

      final ttsState = ref.watch(ttsStateNotifierProvider);

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 60),
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text("状態: ${ttsState.value.toString().split(".").last}"),
          ),
          Container(
            padding: const EdgeInsets.only(left: 30),
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text("読上げ行: $currentTextPoint 行目"),
          ),
        ],
      );
    });

    return widget;
  }

  static Widget barWidget() {
    //
    final widget = Container(
      margin: const EdgeInsets.fromLTRB(130, 15, 130, 10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey[600]!,
          width: 1.5,
        ),
      ),
    );

    return widget;
  }
}
