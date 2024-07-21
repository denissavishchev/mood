import 'package:flutter/material.dart';
import 'package:mood/providers/mood_provider.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class MoodSwitchWidget extends StatelessWidget {
  const MoodSwitchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MoodProvider>(
        builder: (context, data, _){
          return GestureDetector(
            onTap: () => data.switchMood(),
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
                        alignment: data.moodState ? Alignment.centerRight : Alignment.centerLeft,
                        duration: const Duration(milliseconds: 200),
                      child: Text(data.moodState ? 'is good' : 'Mood', style: kBigTextStyle,),
                    ),
                  ),
                  AnimatedAlign(
                    alignment: data.moodState ? Alignment.centerLeft : Alignment.centerRight,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      width: 100,
                      height: 44,
                      decoration: BoxDecoration(
                          color: data.moodState
                              ? kOrange.withOpacity(0.3)
                              : kBlue.withOpacity(0.3),
                          borderRadius: const BorderRadius.all(Radius.circular(12))
                      ),
                      child: Center(
                        child: Text(data.moodState ? 'Mood' : 'is bad', style: kBigTextStyle,),
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
