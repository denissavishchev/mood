import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mood/constants.dart';
import 'package:mood/providers/mood_provider.dart';
import 'package:mood/widgets/switch_widget.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';
import '../widgets/rating_bar_widget.dart';

class AddMealScreen extends StatelessWidget {
  const AddMealScreen({super.key});

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
                            data.mealState
                                ? kYellow.withOpacity(0.7)
                                : kNavy.withOpacity(0.7),
                            data.mealState
                                ? kOrange.withOpacity(0.7)
                                : kBlue.withOpacity(0.7)
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
                        const SizedBox(height: 12,),
                        SwitchWidget(
                            onTap: () => data.switchMeal(),
                            state: data.mealState,
                            textOne: '',
                            textTwo: '',
                            textThree: 'Health',
                            textFour: 'Junk'
                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          controller: data.mealTextController,
                          cursorColor: kWhite,
                          decoration: textFieldDecoration.copyWith(
                              label: const Text('meal', style: TextStyle(color: kWhite),)),
                        ),
                        const SizedBox(height: 20,),
                        TextField(
                          controller: data.personTextController,
                          cursorColor: kWhite,
                          decoration: textFieldDecoration.copyWith(
                              label: const Text('person', style: TextStyle(color: kWhite),)),
                        ),
                        const SizedBox(height: 20,),
                        TextField(
                          controller: data.placeTextController,
                          cursorColor: kWhite,
                          decoration: textFieldDecoration.copyWith(
                              label: const Text('place', style: TextStyle(color: kWhite),)),
                        ),
                        const SizedBox(height: 20,),
                        TextField(
                          controller: data.caloriesTextController,
                          cursorColor: kWhite,
                          decoration: textFieldDecoration.copyWith(
                              label: const Text('calories', style: TextStyle(color: kWhite),)),
                        ),
                        const SizedBox(height: 20,),
                        TextField(
                          controller: data.opinionTextController,
                          cursorColor: kWhite,
                          decoration: textFieldDecoration.copyWith(
                              label: const Text('opinion', style: TextStyle(color: kWhite),)),
                        ),
                        const SizedBox(height: 20,),
                        RatingBarWidget(
                          state: data.mealState,
                          provider: 'meal',
                        ),
                        const SizedBox(height: 20,),
                        GestureDetector(
                          onTap: () => data.pickAnImage(),
                          child: Container(
                            width: 100,
                            clipBehavior: Clip.hardEdge,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: kBlue.withOpacity(0.3),
                              borderRadius: const BorderRadius.all(Radius.circular(4)),
                            ),
                            child: data.fileName == ''
                                ? const Icon(Icons.camera_alt, color: kGrey,)
                                : Image.file(File(data.file!.path), fit: BoxFit.cover,),
                          ),
                        ),
                        const SizedBox(height: 40,),
                        ElevatedButton(
                            onPressed: () => data.insertMeal(context),
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

