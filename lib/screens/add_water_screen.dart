import 'package:flutter/material.dart';
import 'package:mood/constants.dart';
import 'package:mood/providers/mood_provider.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';

class AddWaterScreen extends StatelessWidget {
  const AddWaterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer2<MealProvider, MoodProvider>(
        builder: (context, data, mood, _){
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            kNavy.withOpacity(0.7),
                            kBlue.withOpacity(0.7)
                          ]
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () => mood.toMainScreen(context, 1),
                                icon: const Icon(Icons.arrow_back_ios_new, color: kWhite,)
                            )
                          ],
                        ),
                        const SizedBox(height: 40,),
                        TextFormField(
                          controller: data.waterTypeTextController,
                          cursorColor: kWhite,
                          decoration: textFieldDecoration.copyWith(
                              label: const Text('type', style: TextStyle(color: kWhite),)),
                        ),
                        const SizedBox(height: 20,),
                        TextField(
                          controller: data.waterQuantityTextController,
                          cursorColor: kWhite,
                          decoration: textFieldDecoration.copyWith(
                              label: const Text('qty', style: TextStyle(color: kWhite),)),
                        ),
                        const SizedBox(height: 40,),
                        ElevatedButton(
                            onPressed: () => data.insertWater(context),
                            child: const Text('Add')),
                        const SizedBox(height: 40,)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}

