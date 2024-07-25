import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mood/widgets/stars_widget.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../models/database_helper.dart';
import '../models/mood_model.dart';
import '../providers/mood_provider.dart';

class MoodsListWidget extends StatelessWidget {
  const MoodsListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MoodProvider>(
        builder: (context, data, _){
          return Container(
            height: size.height * 0.6,
            width: size.width,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4))
            ),
            child: FutureBuilder(
              future: Future.wait([
                MoodDatabaseHelper.getData(),
                MoodDatabaseHelper.getSingleData(DateFormat('y-MM-d').format(
                    DateTime.parse(data.selectedDate.toString())))]),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator());
                }else if(snapshot.data![1].isEmpty){
                  if(!data.isToday(data.selectedDate.toString(), DateTime.now().toString())){
                    return const Center(child: Text('No data in this day'));
                  }else{
                    return const Center(child: Text('Today is a good day to start'));
                  }

                }
                return ListView.builder(
                    itemCount: snapshot.data?[1].length,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    itemBuilder: (context, index){
                      if(snapshot.data == null){
                        return const Text('No data');
                      }
                      List<MoodModel> moods = snapshot.data![1];
                      data.dates = snapshot.data![0];
                      return GestureDetector(
                        onTap: () => data.showDescription(context, moods, index),
                        onLongPress: () => data.deleteMood(
                            int.parse(moods[index].id.toString())),
                        child: Container(
                          height: 60,
                          width:  size.width * 0.8,
                          padding: const EdgeInsets.all(4),
                          margin: const EdgeInsets.fromLTRB(8, 2, 8, 8),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  moods[index].mood == 'true'
                                      ? kYellow.withOpacity(0.7)
                                      : kNavy.withOpacity(0.7),
                                  moods[index].mood == 'true'
                                      ? kOrange.withOpacity(0.7)
                                      : kBlue.withOpacity(0.7)
                                ],
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(4)),
                              boxShadow: const [
                                BoxShadow(
                                    color: kWhite,
                                    blurRadius: 0.5,
                                    spreadRadius: 0.1,
                                    offset: Offset(0, 0.5)
                                )
                              ]
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(width: 4,),
                              Container(
                                  width: 50,
                                  height: 50,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 2,
                                          blurRadius: 1,
                                          color: moods[index].mood == 'true'
                                              ? kOrange.withOpacity(0.3) : kBlue.withOpacity(0.3)
                                      )
                                    ],
                                  ),
                                  child: moods[index].photo == ''
                                      ? const SizedBox.shrink()
                                      : CircleAvatar(
                                    backgroundImage: MemoryImage(base64Decode(moods[index].photo),),
                                  )),
                              Column(
                                children: [
                                  Text(DateFormat('HH:mm').format(moods[index].time),
                                    style: kBigTextStyle,),
                                  Text(moods[index].action, style: kBigTextStyle,),
                                ],
                              ),
                              StarsWidget(
                                stars: double.parse(moods[index].rating).toInt(),
                                mood: moods[index].mood,
                              )
                            ],
                          ),
                        ),
                      );
                    }
                );
              },
            ),
          );
        }
    );
  }
}