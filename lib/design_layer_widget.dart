import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DesignLayerWidget extends StatelessWidget {
  const DesignLayerWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.from(
        textTheme: GoogleFonts.mPlus1pTextTheme(),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.grey,
          backgroundColor: Colors.white,
          accentColor: Colors.blue,
        ).copyWith(
          secondary: Colors.blue,
        ),
      ).copyWith(
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      child: child,
    );
  }
}
