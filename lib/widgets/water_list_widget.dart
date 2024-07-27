import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../models/meal_database_helper.dart';
import '../models/water_model.dart';
import '../providers/meal_provider.dart';

class WaterListWidget extends StatelessWidget {
  const WaterListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MealProvider>(
        builder: (context, data, _){
          return Container(
            height: size.height * 0.6,
            width: size.width * 0.25,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4))
            ),
            child: FutureBuilder(
              future: Future.wait([
                MealDatabaseHelper.getWaterData(),
                MealDatabaseHelper.getSingleWaterData(DateFormat('y-MM-d').format(
                    DateTime.parse(data.selectedDate.toString())))]),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator());
                }else if(snapshot.data![1].isEmpty){
                  if(!data.isToday(data.selectedDate.toString(), DateTime.now().toString())){
                    return const Center(child: Text('No'));
                  }else{
                    return const Center(child: Text('start'));
                  }
                }
                return ListView.builder(
                    itemCount: snapshot.data?[1].length,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    itemBuilder: (context, index){
                      if(snapshot.data == null){
                        return const Text('No data');
                      }
                      List<WaterModel> water = snapshot.data![1];
                      // data.dates = snapshot.data![0];
                      return GestureDetector(
                        // onTap: () => data.showDescription(context, water, index),
                        onLongPress: () => data.deleteMeal(
                            int.parse(water[index].id.toString())),
                        child: Container(
                          height: 60,
                          width:  size.width * 0.8,
                          padding: const EdgeInsets.all(4),
                          margin: const EdgeInsets.fromLTRB(8, 2, 8, 8),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  water[index].type == 'water'
                                      ? kNavy.withOpacity(0.7)
                                      : kYellow.withOpacity(0.7),
                                  water[index].type == 'water'
                                      ? kBlue.withOpacity(0.7)
                                      : kOrange.withOpacity(0.7)
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
                              Column(
                                children: [
                                  Text(DateFormat('HH:mm').format(water[index].time),
                                    style: kBigTextStyle,),
                                  Text(water[index].type, style: kBigTextStyle,),
                                ],
                              ),
                              Text(water[index].quantity)
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