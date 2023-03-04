import 'package:flutter/material.dart';

class ControlButtonWidget extends StatelessWidget {
  const ControlButtonWidget({
    super.key,
    required this.color,
    required this.splashColor,
    required this.icon,
    required this.label,
    required this.func,
  });

  final Color color;
  final Color splashColor;
  final IconData icon;
  final String label;
  final Function func;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(icon),
          color: color,
          splashColor: splashColor,
          onPressed: func(),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        )
      ],
    );
  }
}
