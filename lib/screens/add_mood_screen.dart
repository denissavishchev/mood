import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mood/constants.dart';
import 'package:mood/providers/mood_provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../widgets/mood_switch_widget.dart';

class AddMoodScreen extends StatelessWidget {
  const AddMoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MoodProvider>(
        builder: (context, data, _){
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: SingleChildScrollView(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        data.moodState
                            ? kYellow.withOpacity(0.7)
                            : kNavy.withOpacity(0.7),
                        data.moodState
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
                                onPressed: () => data.toMainScreen(context, 0),
                                icon: const Icon(Icons.arrow_back_ios_new, color: kWhite,)
                            )
                          ],
                        ),
                        const SizedBox(height: 12,),
                        const MoodSwitchWidget(),
                        const SizedBox(height: 40,),
                        TextFormField(
                          controller: data.actionTextController,
                          cursorColor: kWhite,
                          decoration: textFieldDecoration.copyWith(
                              label: const Text('action', style: TextStyle(color: kWhite),)),
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
                                label: const Text('place', style: TextStyle(color: kWhite),))
                        ),
                        const SizedBox(height: 20,),
                        TextField(
                          controller: data.descriptionTextController,
                          cursorColor: kWhite,
                          decoration: textFieldDecoration.copyWith(
                              label: const Text('description', style: TextStyle(color: kWhite),)),
                        ),
                        const SizedBox(height: 20,),
                        RatingBar(
                          initialRating: 0,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemSize: 60,
                          ratingWidget: RatingWidget(
                            full: Icon(Icons.star,
                                color: data.moodState
                                    ? kBlue.withOpacity(0.3)
                                    : kOrange.withOpacity(0.3),
                                shadows: const [
                                  BoxShadow(
                                      color: kWhite,
                                      blurRadius: 9,
                                      spreadRadius: 6,
                                      offset: Offset(0.5, 0.5)
                                  )
                                ]),
                            empty: Icon(Icons.star_border,
                                color: data.moodState
                                    ? kBlue.withOpacity(0.3)
                                    : kOrange.withOpacity(0.3),
                                shadows: const [
                                  BoxShadow(
                                      color: kWhite,
                                      blurRadius: 9,
                                      spreadRadius: 6,
                                      offset: Offset(0.5, 0.5)
                                  )
                                ]), half: const SizedBox.shrink(),
                          ),
                          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                          onRatingUpdate: (rating) => data.updateRating(rating),
                        ),
                        const SizedBox(height: 40,),
                        GestureDetector(
                          onTap: () => data.pickAnImage(),
                          child: Container(
                            width: 100,
                            clipBehavior: Clip.hardEdge,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: data.moodState
                                  ? kOrange.withOpacity(0.3)
                                  : kBlue.withOpacity(0.3),
                              borderRadius: const BorderRadius.all(Radius.circular(4)),
                            ),
                            child: data.fileName == ''
                                ? const Icon(Icons.camera_alt, color: kGrey,)
                                : Image.file(File(data.file!.path), fit: BoxFit.cover,),
                          ),
                        ),
                        const SizedBox(height: 40,),
                        ElevatedButton(
                            onPressed: () => data.insertMood(context),
                            child: const Text('Add'))
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

