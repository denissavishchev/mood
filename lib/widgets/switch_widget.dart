import 'package:flutter/material.dart';
import 'package:mood/providers/mood_provider.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class SwitchWidget extends StatelessWidget {
  const SwitchWidget({
    super.key,
    required this.state,
    required this.textOne,
    required this.textTwo,
    required this.textThree,
    required this.textFour,
    required this.onTap,
  });

  final bool state;
  final String textOne;
  final String textTwo;
  final String textThree;
  final String textFour;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Consumer<MoodProvider>(
        builder: (context, data, _){
          return GestureDetector(
            onTap: onTap,
            child: Container(
              width: 200,
              height: 50,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: kGrey.withOpacity(0.4),
                  borderRadius: const BorderRadius.all(Radius.circular(12))
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: AnimatedAlign(
                        alignment: state ? Alignment.centerRight : Alignment.centerLeft,
                        duration: const Duration(milliseconds: 200),
                      child: Text(state ? textOne : textTwo, style: kBigTextStyle,),
                    ),
                  ),
                  AnimatedAlign(
                    alignment: state ? Alignment.centerLeft : Alignment.centerRight,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      width: 100,
                      height: 44,
                      decoration: BoxDecoration(
                          color: state
                              ? kOrange.withOpacity(0.3)
                              : kBlue.withOpacity(0.3),
                          borderRadius: const BorderRadius.all(Radius.circular(12))
                      ),
                      child: Center(
                        child: Text(state ? textThree : textFour, style: kBigTextStyle,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
