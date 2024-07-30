import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mood/models/mood_database_helper.dart';
import 'package:mood/models/mood_model.dart';
import 'package:mood/providers/mood_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../constants.dart';

class MoodStatisticScreen extends StatelessWidget {
  const MoodStatisticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MoodProvider>(
        builder: (context, data, _){
          return Column(
              children: [
                const SizedBox(height: 60,),
                IconButton(
                    onPressed: () => data.toMainScreen(context, 0),
                    icon: const Icon(Icons.arrow_back_ios_new, color: kBlack,)
                ),
                FutureBuilder(
                  future: MoodDatabaseHelper.getData(),
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator());
                    }
                    final moods = snapshot.data!;
                    final map = {};
                    for(final i in moods){
                      map.addAll({i.time:i.rating});
                    }
                    final result = <String, double>{};
                    map.forEach((date, value) {
                      result.update(DateFormat('y-MM-d').format(DateTime.parse(date.toString())),
                              (sum) => sum + double.parse(value.toString()), ifAbsent: () => double.parse(value.toString()));
                    });
                    print(result);
                    return SfCartesianChart(
                      primaryXAxis: DateTimeAxis(
                        dateFormat: DateFormat('d MMM'),
                        labelRotation: 90,
                        labelStyle: const TextStyle(color: kOrange),
                        minimum: DateTime.now(),
                        maximum: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 5),
                        majorGridLines: const MajorGridLines(width: 0,),
                      ),
                      primaryYAxis: const NumericAxis(
                        labelStyle: TextStyle(color: kOrange),
                        placeLabelsNearAxisLine: true,
                        minimum: 0,
                        maximum: 5,
                        majorGridLines: MajorGridLines(width: 0,),
                      ),
                      series: <CartesianSeries>[
                        ColumnSeries<MoodModel, DateTime>(
                          dataSource: moods,
                          xValueMapper: (MoodModel data, _) => data.time,
                          yValueMapper: (MoodModel data, _) => data.mood == 'true' ? double.parse(data.rating) : 0,
                          // dataLabelSettings: const DataLabelSettings(
                          //   isVisible: true,
                          //   textStyle: TextStyle(color: kWhite, fontWeight: FontWeight.bold),
                          //   margin: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                          //   borderColor: kOrange,
                          borderWidth: 10,
                          //   color: kOrange,
                          //   opacity: 0.8,
                          // ),
                          borderColor: kOrange.withOpacity(0.5),
                          // width: 1,
                          // borderWidth: 5,
                          color: kBlue,
                        ),
                        ColumnSeries<MoodModel, DateTime>(
                          dataSource: moods,
                          xValueMapper: (MoodModel data, _) => data.time,
                          yValueMapper: (MoodModel data, _) => data.mood == 'false' ? double.parse(data.rating) : 0,
                          borderWidth: 5,
                          borderColor: kBlue,
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



