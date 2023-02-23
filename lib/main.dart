import 'package:flutter/material.dart';

import 'routing_layer_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const RoutingLayerWidget();
  }
}
