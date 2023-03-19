import 'package:flutter/material.dart';

class VibrationWidget extends StatefulWidget {
  const VibrationWidget({super.key, required this.child});

  final Widget child;

  @override
  State<VibrationWidget> createState() => _VibrationWidgetState();
}

class _VibrationWidgetState extends State<VibrationWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 150), vsync: this)
      ..repeat(reverse: true);

    final tween = Tween(begin: -0.001, end: 0.001);
    // final tween = Tween<Offset>(
    //     begin: const Offset(-0.004, 0.0), end: const Offset(0.004, 0.0));

    animation = tween.animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      // scale: controller.drive(Tween<double>(begin: 1.0, end: 1.2)),
      turns: animation,
      child: widget.child,
      // child: Container(
      //   height: 100,
      //   width: 100,
      //   color: Colors.red,
      //   child: Text(controller.value.toString()),
      // ),
    );
  }
}

// class VibrationWidget extends HookWidget {
//   const VibrationWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // final singleTicker = useSingleTickerProvider();

//     final controller = useAnimationController(
//       duration: const Duration(milliseconds: 1000),
//       reverseDuration: const Duration(milliseconds: 1000),
//       // vsync: singleTicker,
//     )..repeat(reverse: true);

//     final animation = Tween<double>(
//       begin: -10.0,
//       end: 10.0,
//     ).animate(CurvedAnimation(
//       parent: controller,
//       curve: Curves.easeInOut,
//     ));

//     useAnimation(animation);

//     return Transform.translate(
//       offset: Offset(animation.value * 10, 0),
//       child: GestureDetector(
//         onTap: () {
//           if (controller.isCompleted) {
//             logger.d("onTap: ${animation.value}");
//             controller.reverse();
//           } else {
//             controller.forward();
//           }
//         },
//         child: Container(
//           height: 100,
//           width: 100,
//           color: Colors.red,
//         ),
//       ),
//     );
//   }
// }
