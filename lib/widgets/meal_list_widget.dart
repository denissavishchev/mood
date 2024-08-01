import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../models/meal_database_helper.dart';
import '../models/meal_model.dart';
import '../providers/meal_provider.dart';
import 'bar_widget.dart';

class MealListWidget extends StatelessWidget {
  const MealListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MealProvider>(
        builder: (context, data, _){
          return Container(
            height: size.height * 0.6,
            width: size.width * 0.75,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4))
            ),
            child: FutureBuilder(
              future: Future.wait([
                MealDatabaseHelper.getMealData(),
                MealDatabaseHelper.getSingleMealData(DateFormat('y-MM-dd').format(
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
                data.calories = 0.0;
                for(final c in snapshot.data![1]){
                  data.calories += double.parse(c.calories);
                }
                return Row(
                  children: [
                    SizedBox(
                      height: size.height * 0.6,
                      width: size.width * 0.7,
                      child: ListView.builder(
                          itemCount: snapshot.data?[1].length,
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          itemBuilder: (context, index){
                            if(snapshot.data == null){
                              return const Text('No data');
                            }
                            List<MealModel> meals = snapshot.data![1];
                            data.dates = snapshot.data![0];
                            return GestureDetector(
                              onTap: () => data.showDescription(context, meals, index),
                              onLongPress: () => data.deleteMeal(
                                  int.parse(meals[index].id.toString())),
                              child: Container(
                                height: 60,
                                width:  size.width * 0.8,
                                padding: const EdgeInsets.all(4),
                                margin: const EdgeInsets.fromLTRB(8, 2, 8, 8),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        meals[index].health == 'true'
                                            ? kYellow.withOpacity(0.7)
                                            : kNavy.withOpacity(0.7),
                                        meals[index].health == 'true'
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
                                                color: meals[index].health == 'true'
                                                    ? kOrange.withOpacity(0.3) : kBlue.withOpacity(0.3)
                                            )
                                          ],
                                        ),
                                        child: meals[index].photo == ''
                                            ? const SizedBox.shrink()
                                            : CircleAvatar(
                                          backgroundImage: MemoryImage(base64Decode(meals[index].photo),),
                                        )),
                                    Column(
                                      children: [
                                        Text(DateFormat('HH:mm').format(meals[index].time),
                                          style: kBigTextStyle,),
                                        Text(meals[index].meal, style: kBigTextStyle,),
                                        // Text(meals[index].calories, style: kBigTextStyle,),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('Cals: ', style: kTextStyle,),
                                        Text(meals[index].calories, style: kTextStyle,),
                                      ],
                                    ),
                                    const SizedBox(width: 12,)
                                  ],
                                ),
                              ),
                            );
                          }
                      ),
                    ),
                    BarWidget(
                      color: kOrange,
                      value: data.calories,
                      maxValue: data.maxCalories,
                    ),
                  ],
                );
              },
            ),
          );
        }
    );
  }
}