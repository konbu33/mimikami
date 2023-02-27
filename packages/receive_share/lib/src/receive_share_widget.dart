import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class ReceiveShareWidget extends StatefulWidget {
  const ReceiveShareWidget({super.key});

  @override
  ReceiveShareWidgetState createState() => ReceiveShareWidgetState();
}

class ReceiveShareWidgetState extends State<ReceiveShareWidget> {
  late StreamSubscription _intentDataStreamSubscription;
  String? sharedText;

  @override
  void initState() {
    super.initState();

    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
      setState(() {
        sharedText = value;
        logger.d("Shared: $sharedText");
      });
    }, onError: (err) {
      logger.d("getLinkStream error: $err");
    });

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String? value) {
      setState(() {
        sharedText = value;
        logger.d("Shared: $sharedText");
      });
    });
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const textStyleBold = TextStyle(fontWeight: FontWeight.bold);
    return Center(
      child: Column(
        children: <Widget>[
          const Text("Shared urls/text:", style: textStyleBold),
          Text(sharedText ?? "")
        ],
      ),
    );
  }
}
