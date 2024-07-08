import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class BarWidget extends StatelessWidget {
  const BarWidget({
    super.key,
    required this.color,
    required this.topRadius,
    required this.value,
  });

  final Color color;
  final bool topRadius;
  final double value;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width * 0.008,
      height: size.height * 0.4,
      // color: kGrey,
      decoration: BoxDecoration(
          borderRadius: topRadius
              ? const BorderRadius.vertical(top: Radius.circular(12))
              : const BorderRadius.vertical(bottom: Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: color,
              blurRadius: 0.5,
              spreadRadius: 0.5,
              // offset: Offset(2, 2)
            )
          ]
      ),
      child: FAProgressBar(
        currentValue: value,
        size: 25,
        maxValue: 100,
        changeColorValue: 80,
        changeProgressColor: Colors.pink,
        backgroundColor: Colors.white,
        progressColor: color,
        animatedDuration: const Duration(milliseconds: 300),
        direction: Axis.vertical,
        verticalDirection: topRadius ? VerticalDirection.up : VerticalDirection.down,
        // displayText: '%',
        formatValueFixed: 0,
        borderRadius: topRadius
            ? const BorderRadius.vertical(top: Radius.circular(12))
            : const BorderRadius.vertical(bottom: Radius.circular(12)),
        displayTextStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
}