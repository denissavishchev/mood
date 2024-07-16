import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../models/database_helper.dart';
import '../models/mood_model.dart';
import '../providers/mood_provider.dart';

class MoodsListWidget extends StatelessWidget {
  const MoodsListWidget({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MoodProvider>(
        builder: (context, data, _){
          return Container(
            height: size.height * 0.38,
            width: size.width,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: kWhite.withOpacity(0.4),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: const Offset(2, 2)
                  )
                ]
            ),
            child: FutureBuilder(
              future: MoodDatabaseHelper.getData(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    padding: const EdgeInsets.symmetric(vertical: 4),
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
                          padding: const EdgeInsets.all(4),
                          margin: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                          decoration: const BoxDecoration(
                            color: kBlueGrey,
                            // borderRadius: const BorderRadius.horizontal(right: Radius.circular(18)),
                            boxShadow: [
                              BoxShadow(
                                color: kWhite,
                                blurRadius: 1,
                                spreadRadius: 3,
                                // offset: Offset(1, 1)
                              )
                            ]
                          ),
                          child: Row(
                            children: [
                              Container(
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
                                  // Text(moods[index].description),
                                  Text(moods[index].rating),
                                ],
                              ),
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