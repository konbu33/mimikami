import 'package:common/common.dart';
import 'package:flutter/material.dart';

import 'control_button_section_widget.dart';
import 'control_engine_widget.dart';
import 'control_language_widget.dart';
import 'control_slider_section_widget.dart';

class TtsControllerWidget extends StatefulWidget {
  const TtsControllerWidget({super.key});

  @override
  State<TtsControllerWidget> createState() => _TtsControllerWidgetState();
}

class _TtsControllerWidgetState extends State<TtsControllerWidget> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   logger.d("onTap");
      //   isVisible = !isVisible;
      //   setState(() {});
      // },
      onVerticalDragEnd: (details) {
        logger.d("onVerticalDragEnd: ${details.primaryVelocity}");
        final verocity = details.primaryVelocity ?? 0;
        verocity < 0 ? isVisible = true : isVisible = false;
        setState(() {});
      },
      child: Container(
        padding:
            !isVisible ? EdgeInsets.zero : const EdgeInsets.only(bottom: 30),
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
          ],
        ),
      ),
    );
  }
}

class TtsControllerWidgetParts {
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
