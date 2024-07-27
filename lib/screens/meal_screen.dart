import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mood/constants.dart';
import 'package:mood/widgets/water_list_widget.dart';
import 'package:provider/provider.dart';
import '../models/meal_database_helper.dart';
import '../providers/meal_provider.dart';
import '../widgets/meal_list_widget.dart';
import '../widgets/button_widget.dart';
import 'add_meal_screen.dart';
import 'add_water_screen.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MealProvider>(builder: (context, data, _) {
      return Scaffold(
        backgroundColor: kGrey,
        body: Column(
          children: [
            const Row(
              children: [
                MealListWidget(),
                WaterListWidget()
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Visibility(
                    visible: data.dates.isNotEmpty,
                    child: SizedBox(
                      width: size.width * 0.4,
                      child: Row(
                        children: [
                          ButtonWidget(
                            icon: Icons.calendar_month,
                            onTap: () => data.showHistory(context),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(data.selectedDate?.day == DateTime.now().day
                              ? 'Today'
                              : DateFormat('y-MM-d').format(DateTime.parse(
                                  data.selectedDate.toString()))),
                        ],
                      ),
                    )),
                FutureBuilder(
                    future: MealDatabaseHelper.getMealData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AbsorbPointer(
                            absorbing: !data.isToday(
                                data.selectedDate.toString(),
                                DateTime.now().toString()),
                            child: GestureDetector(
                                onTap: () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddMealScreen())),
                                child: const Text('Meal')),
                          ),
                          const SizedBox(width: 100,),
                          AbsorbPointer(
                            absorbing: !data.isToday(
                                data.selectedDate.toString(),
                                DateTime.now().toString()),
                            child: GestureDetector(
                                onTap: () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddWaterScreen())),
                                child: const Text('Water')),
                          ),
                        ],
                      );
                    })
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      );
    });
  }
}
