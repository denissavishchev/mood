import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mood/constants.dart';
import 'package:provider/provider.dart';
import '../models/meal_database_helper.dart';
import '../providers/meal_provider.dart';
import '../widgets/meal_list_widget.dart';
import '../widgets/button_widget.dart';
import 'add_meal_screen.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MealProvider>(
        builder: (context, data, _){
          return Scaffold(
            backgroundColor: kGrey,
            body: Column(
              children: [
                const MealListWidget(),
                FutureBuilder(
                    future: MealDatabaseHelper.getMealData(),
                    builder: (context, snapshot){
                      return Row(
                        children: [
                          Visibility(
                              visible: data.dates.isNotEmpty,
                              child: SizedBox(
                                width: size.width * 0.4,
                                child: Row(
                                  children: [
                                    ButtonWidget(
                                      icon: Icons.calendar_month,
                                      onTap: () => data.showHistory(context),),
                                    const SizedBox(width: 20,),
                                    Text(data.selectedDate?.day == DateTime.now().day
                                        ? 'Today'
                                        : DateFormat('y-MM-d').format(DateTime.parse(data.selectedDate.toString()))),
                                  ],
                                ),
                              )),
                          AbsorbPointer(
                            absorbing: !data.isToday(
                                data.selectedDate.toString(),
                                DateTime.now().toString()),
                            child: GestureDetector(
                                onTap: () => Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) =>
                                    const AddMealScreen())),
                                child: const Icon(Icons.add)
                            ),
                          ),
                        ],
                      );
                    }
                ),
                const SizedBox(height: 10,),
              ],
            ),
          );
        }
    );
  }
}







