import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mood/providers/mood_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../constants.dart';
import '../models/meal_database_helper.dart';
import '../providers/meal_provider.dart';

class MealStatisticScreen extends StatelessWidget {
  const MealStatisticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer2<MealProvider, MoodProvider>(
          builder: (context, data, mood, _){
            return Column(
                children: [
                  const SizedBox(height: 60,),
                  IconButton(
                      onPressed: () => mood.toMainScreen(context, 1),
                      icon: const Icon(Icons.arrow_back_ios_new, color: kBlack,)
                  ),
                  FutureBuilder(
                    future: Future.wait([
                      MealDatabaseHelper.getMealTimeData(),
                      MealDatabaseHelper.getWaterData()
                    ]),
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const Center(child: CircularProgressIndicator());
                      }
                      final meals = snapshot.data![0];
                      final water = snapshot.data![1];
                      data.calculateStatistic(meals, water);
                      return SfCartesianChart(
                        enableSideBySideSeriesPlacement: false,
                        primaryXAxis: DateTimeAxis(
                          intervalType: DateTimeIntervalType.auto,
                          dateFormat: DateFormat('d MMM'),
                          labelRotation: 90,
                          labelStyle: const TextStyle(color: kOrange),
                          minimum: DateTime.now(),
                          maximum: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 10),
                          majorGridLines: const MajorGridLines(width: 0,),
                        ),
                        primaryYAxis: NumericAxis(
                          rangePadding: ChartRangePadding.round,
                          labelStyle: const TextStyle(color: kOrange),
                          placeLabelsNearAxisLine: true,
                          minimum: 0,
                          maximum: double.parse(data.maxCalories) > double.parse(data.maxWater)
                              ? double.parse(data.maxCalories)
                              : double.parse(data.maxWater),
                          majorGridLines: const MajorGridLines(width: 0,),
                        ),
                        series: <CartesianSeries>[
                          ColumnSeries<List, DateTime>(
                            animationDuration: 500,
                            dataSource: data.mealList,
                            xValueMapper: (List data, _) => DateTime.parse(data[0]),
                            yValueMapper: (List data, _) => data[1],
                            color: kOrange,
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                            spacing: 0,
                          ),
                          ColumnSeries<List, DateTime>(
                              animationDuration: 500,
                              dataSource: data.waterList,
                              xValueMapper: (List data, _) => DateTime.parse(data[0]),
                              yValueMapper: (List data, _) => data[1],
                              width: 0.4,
                              color: kBlue,
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(4))
                          ),
                        ],
                      );
                    },
                  ),
                ]
            );
          },
        )
    );
  }
}



