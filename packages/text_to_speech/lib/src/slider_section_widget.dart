import 'package:flutter/material.dart';

import 'slider_section_pitch_widget.dart';
import 'slider_section_rate_widget.dart';
import 'slider_section_volume_widget.dart';

class SliderSectionWidget extends StatelessWidget {
  const SliderSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        VolumeWidget(),
        PitchWidget(),
        RateWidget(),
      ],
    );
  }
}
