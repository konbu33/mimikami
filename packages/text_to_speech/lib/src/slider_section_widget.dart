import 'package:flutter/material.dart';

import 'pitch_widget.dart';
import 'rate_widget.dart';
import 'volume_widget.dart';

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
