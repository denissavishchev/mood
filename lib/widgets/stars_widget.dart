import 'package:flutter/material.dart';
import '../constants.dart';

class StarsWidget extends StatelessWidget {
  StarsWidget({super.key,
    required this.stars,
  });

  final int stars;

  final shadow = [
    const BoxShadow(
        color: kBlue,
        blurRadius: 9,
        spreadRadius: 6,
        offset: Offset(0.5, 0.5)
    )
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width * 0.5,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Stack(
          children: [
            Positioned(
              top: 10,
                left: 0,
                child: Icon(
                  stars >= 1
                      ? Icons.star
                      : Icons.star_border,
                  color: kGrey,
                  size: 50,
                  shadows: shadow,
                )),
            Positioned(
                top: 5,
                left: 35,
                child: Icon(
                  stars >= 2
                      ? Icons.star
                      : Icons.star_border,
                  color: kGrey,
                  size: 55,
                  shadows: shadow,
                )),
            Align(
             alignment: Alignment.topCenter,
                child: Icon(
                  stars >= 3
                      ? Icons.star
                      : Icons.star_border,
                  color: kGrey,
                  size: 60,
                  shadows: shadow,
                )),
            Positioned(
                top: 5,
                right: 35,
                child: Icon(
                  stars >= 4
                      ? Icons.star
                      : Icons.star_border,
                  color: kGrey,
                  size: 55,
                  shadows: shadow,
                )),
            Positioned(
              top: 10,
                right: 0,
                child: Icon(
                  stars >= 5
                      ? Icons.star
                      : Icons.star_border,
                  color: kGrey,
                  size: 50,
                  shadows: shadow,
                )),
          ],
        ),
      ),
    );
  }
}
