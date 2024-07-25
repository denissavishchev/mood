import 'package:flutter/material.dart';
import 'package:mood/constants.dart';
import 'package:provider/provider.dart';
import '../providers/mood_provider.dart';


class CaloriesScreen extends StatelessWidget {
  const CaloriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MoodProvider>(
        builder: (context, data, _){
          return const Scaffold(
            backgroundColor: kGrey,
            body: Column(
              children: [
                Column(
                  children: [
                    Text('Calories'),
                    SizedBox(height: 12,),

                  ],
                ),
                SizedBox(height: 10,),
              ],
            ),
          );
        }
    );
  }
}







