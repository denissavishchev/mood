import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mood/constants.dart';
import 'package:mood/models/database_helper.dart';
import 'package:mood/models/mood_model.dart';
import 'package:mood/screens/add_mood_screen.dart';
import 'package:provider/provider.dart';
import '../providers/mood_provider.dart';
import '../widgets/bar_widget.dart';

class MoodScreen extends StatelessWidget {
  const MoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MoodProvider>(
        builder: (context, data, _){
          return Scaffold(
            body: SafeArea(
              child: Container(
                width: size.width,
                height: size.height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      kGrey,
                      kLightGrey,
                      kGrey,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.07,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Mood', style: kBigTextStyle,),
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(30)),
                                border: Border.all(color: kBlack.withOpacity(0.5), width: 1.5)
                              ),
                              child: Icon(Icons.access_alarm, color: kBlack.withOpacity(0.5),),
                            ),
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                                  border: Border.all(color: kBlack.withOpacity(0.5), width: 1.5)
                              ),
                              child: Icon(Icons.account_circle_outlined, color: kBlack.withOpacity(0.5),),
                            ),
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                                  border: Border.all(color: kBlack.withOpacity(0.5), width: 1.5)
                              ),
                              child: Icon(Icons.account_balance_outlined, color: kBlack.withOpacity(0.5),),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: size.height * 0.38,
                                width:  size.width * 0.9,
                                // padding: const EdgeInsets.all(4),
                                clipBehavior: Clip.hardEdge,
                                decoration: const BoxDecoration(
                                  color: kBlack,
                                    borderRadius: BorderRadius.all(Radius.circular(18)),
                                ),
                                child: FutureBuilder(
                                  future: MoodDatabaseHelper.getData(),
                                  builder: (context, snapshot){
                                    if(snapshot.connectionState == ConnectionState.waiting){
                                      return const Center(child: CircularProgressIndicator());
                                    }
                                    return ListView.builder(
                                        itemCount: snapshot.data?.length,
                                        itemBuilder: (context, index){
                                          if(snapshot.data == null){
                                            return const Text('No data');
                                          }
                                            List<MoodModel> moods = snapshot.data!;
                                            return GestureDetector(
                                              onLongPress: () => data.deleteMood(
                                                  int.parse(moods[index].id.toString())),
                                              child: Container(
                                                height: 60,
                                                width:  size.width * 0.8,
                                                margin: const EdgeInsets.fromLTRB(6, 6, 6, 0),
                                                decoration: const BoxDecoration(
                                                    color: kOrange,
                                                    borderRadius: BorderRadius.all(Radius.circular(18))
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      // width: 55,
                                                      // height: 55,
                                                        clipBehavior: Clip.hardEdge,
                                                        decoration: const BoxDecoration(
                                                          borderRadius: BorderRadius.all(Radius.circular(12)),
                                                        ),
                                                      child: moods[index].photo == ''
                                                            ? const SizedBox.shrink()
                                                            : Image.memory(base64Decode(moods[index].photo))),
                                                    Column(
                                                      children: [
                                                        Text(moods[index].mood),
                                                        Text(moods[index].description),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                        }
                                    );
                                  },
                                )
                              ),
                              SizedBox(
                                height: 60,
                                width:  size.width * 0.9,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                          color: kGrey,
                                          borderRadius: BorderRadius.all(Radius.circular(12),
                                          )
                                      ),
                                      child: Center(child: Text('Journal', style: kBigTextStyle,)),
                                    ),
                                    GestureDetector(
                                      onTap: () => Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) =>
                                          const AddMoodScreen())),
                                      child: Container(
                                        width: 200,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                            color: kGrey,
                                            borderRadius: BorderRadius.all(Radius.circular(12),
                                            )
                                        ),
                                        child: Center(child: Text('Add mood', style: kBigTextStyle,)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  height: size.height * 0.38,
                                  width:  size.width * 0.9,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: const BoxDecoration(
                                    color: kOrange,
                                    borderRadius: BorderRadius.all(Radius.circular(18)),
                                  ),
                                  child: FutureBuilder(
                                    future: MoodDatabaseHelper.getData(),
                                    builder: (context, snapshot){
                                      if(snapshot.connectionState == ConnectionState.waiting){
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                      return ListView.builder(
                                          itemCount: snapshot.data?.length,
                                          itemBuilder: (context, index){
                                            if(snapshot.data == null){
                                              return const Text('No data');
                                            }
                                            List<MoodModel> moods = snapshot.data!;
                                            return GestureDetector(
                                              onLongPress: () => data.deleteMood(
                                                  int.parse(moods[index].id.toString())),
                                              child: Container(
                                                height: 60,
                                                width:  size.width * 0.8,
                                                margin: const EdgeInsets.fromLTRB(6, 6, 6, 0),
                                                decoration: const BoxDecoration(
                                                    color: kBlack,
                                                    borderRadius: BorderRadius.all(Radius.circular(18))
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      // width: 55,
                                                      // height: 55,
                                                        clipBehavior: Clip.hardEdge,
                                                        decoration: const BoxDecoration(
                                                          borderRadius: BorderRadius.all(Radius.circular(12)),
                                                        ),
                                                        child: moods[index].photo == ''
                                                            ? const SizedBox.shrink()
                                                            : Image.memory(base64Decode(moods[index].photo))),
                                                    Column(
                                                      children: [
                                                        Text(moods[index].mood, style: kTextStyle,),
                                                        Text(moods[index].description, style: kTextStyle,),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                      );
                                    },
                                  )
                              ),
                            ],
                          ),
                          const Spacer(),
                          SizedBox(
                            height: size.height * 0.85,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BarWidget(color: kOrange, topRadius: true, value: 50,),
                                SizedBox(height: 10,),
                                BarWidget(color: kBlack, topRadius: false, value: 20,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}

