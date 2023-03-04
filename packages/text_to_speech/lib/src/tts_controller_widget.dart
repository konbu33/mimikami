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
      onTap: () {
        logger.d("onTap");
        isVisible = !isVisible;
        setState(() {});
      },
      onVerticalDragEnd: (details) {
        logger.d("onVerticalDragEnd: ${details.primaryVelocity}");
        final verocity = details.primaryVelocity ?? 0;
        verocity < 0 ? isVisible = true : isVisible = false;
        setState(() {});
      },
      child: Container(
        padding: !isVisible
            ? EdgeInsets.zero
            : const EdgeInsets.only(top: 30, bottom: 30),
        color: Colors.grey[100],
        child: Column(
          children: [
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
