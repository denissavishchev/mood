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
                  height: size.height,
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
                        const SizedBox(height: 12,),
                        Wrap(
                          spacing: 30,
                          runSpacing: 12,
                          children: List.generate(8, ((i){
                            return GestureDetector(
                              onTap: () => data.updateWaterType(data.waterIcons[i]),
                              child: Container(
                                width: size.height * 0.07,
                                height: size.height * 0.07,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: data.waterType == data.waterIcons[i]
                                            ? kOrange.withOpacity(0.3)
                                            : kBlack.withOpacity(0.5)),
                                    gradient: const LinearGradient(
                                        colors: [
                                          kGrey,
                                          kWhite
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter
                                    ),
                                    borderRadius: const BorderRadius.all(Radius.circular(8))
                                ),
                                child: Container(
                                  width: size.height * 0.06,
                                  height: size.height * 0.06,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: data.waterType == data.waterIcons[i]
                                              ? kOrange.withOpacity(0.5) : kWhite,
                                          width: 1),
                                      boxShadow: [
                                        BoxShadow(
                                            color: kBlack.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 2,
                                            offset: const Offset(0, 2)
                                        )
                                      ],
                                      gradient: const LinearGradient(
                                          colors: [
                                            kGrey,
                                            kWhite
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter
                                      ),
                                      borderRadius: const BorderRadius.all(Radius.circular(100))
                                  ),
                                  child: Image.asset('assets/icons/${data.waterIcons[i]}.png'),
                                ),
                              ),
                            );
                          })),
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

