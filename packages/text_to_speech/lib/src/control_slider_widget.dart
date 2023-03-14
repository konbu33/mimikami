import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ControlSliderWidget extends StatelessWidget {
  const ControlSliderWidget({
    super.key,
    required this.onChanged,
    required this.min,
    required this.max,
    required this.divisions,
    required this.label,
    required this.activeColor,
    required this.value,
  });

  final void Function(double)? onChanged;
  final double min;
  final double max;
  final int divisions;
  final String label;
  final Color activeColor;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Slider(
          value: value,
          onChanged: onChanged,
          min: min,
          max: max,
          divisions: divisions,
          label: "$label: $value",
          activeColor: activeColor,
        );
      },
    );
  }
}
