import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BarWidget extends StatelessWidget {
  const BarWidget({
    super.key,
    required this.color,
    required this.value,
  });

  final Color color;
  final double value;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Text(value.toStringAsFixed(0), style: TextStyle(fontSize: 14.sp),),
        Container(
          width: size.width * 0.03,
          height: size.height * 0.55,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: FAProgressBar(
            currentValue: value,
            maxValue: 3000,
            changeColorValue: 2500,
            changeProgressColor: color,
            backgroundColor: Colors.white,
            progressColor: color,
            animatedDuration: const Duration(milliseconds: 300),
            direction: Axis.vertical,
            verticalDirection: VerticalDirection.up,
            formatValueFixed: 0,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            displayTextStyle: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}