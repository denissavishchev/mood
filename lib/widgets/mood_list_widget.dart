import 'dart:convert';
import 'dart:ui';
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
          return SizedBox(
            height: size.height * 0.38,
            width:  size.width * 0.94,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: kWhite.withOpacity(0.13)),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              kWhite.withOpacity(0.15),
                              kWhite.withOpacity(0.25),
                            ]
                        )
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
                                  padding: const EdgeInsets.all(4),
                                  margin: const EdgeInsets.fromLTRB(6, 6, 6, 0),
                                  decoration: BoxDecoration(
                                    color: color.withOpacity(0.5),
                                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                                    border: Border.all(width: 1, color: kWhite.withOpacity(0.5))
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
                    ),
                  ),
                )
            ),
          );
        }
    );
  }
}