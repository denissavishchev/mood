import 'package:flutter/material.dart';
import '../constants.dart';

class StarsWidget extends StatelessWidget {
  StarsWidget({super.key,
    required this.stars, 
    required this.mood,
  });

  final int stars;
  final String mood;

  final shadow = [
    const BoxShadow(
        color: kWhite,
        blurRadius: 9,
        spreadRadius: 6,
        offset: Offset(0.5, 0.5)
    )
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Stack(
          children: [
            Positioned(
              top: 10,
                left: 0,
                child: Icon(
                  stars >= 1
                      ? Icons.star
                      : Icons.star_border,
                  color: mood == 'true' 
                      ? kBlue.withOpacity(0.3)
                      : kOrange.withOpacity(0.3),
                  size: 30,
                  shadows: shadow,
                )),
            Positioned(
                top: 5,
                left: 20,
                child: Icon(
                  stars >= 2
                      ? Icons.star
                      : Icons.star_border,
                  color: mood == 'true'
                      ? kBlue.withOpacity(0.3)
                      : kOrange.withOpacity(0.3),
                  size: 35,
                  shadows: shadow,
                )),
            Align(
             alignment: Alignment.topCenter,
                child: Icon(
                  stars >= 3
                      ? Icons.star
                      : Icons.star_border,
                  color: mood == 'true'
                      ? kBlue.withOpacity(0.3)
                      : kOrange.withOpacity(0.3),
                  size: 40,
                  shadows: shadow,
                )),
            Positioned(
                top: 5,
                right: 20,
                child: Icon(
                  stars >= 4
                      ? Icons.star
                      : Icons.star_border,
                  color: mood == 'true'
                      ? kBlue.withOpacity(0.3)
                      : kOrange.withOpacity(0.3),
                  size: 35,
                  shadows: shadow,
                )),
            Positioned(
              top: 10,
                right: 0,
                child: Icon(
                  stars >= 5
                      ? Icons.star
                      : Icons.star_border,
                  color: mood == 'true'
                      ? kBlue.withOpacity(0.3)
                      : kOrange.withOpacity(0.3),
                  size: 30,
                  shadows: shadow,
                )),
          ],
        ),
      ),
    );
  }
}
