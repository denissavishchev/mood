import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mood/models/mood_database_helper.dart';
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
                    data.calculateStatistic(moods);
                    return SfCartesianChart(
                      enableSideBySideSeriesPlacement: false,
                      // margin: EdgeInsets.all(12),
                      primaryXAxis: DateTimeAxis(
                        intervalType: DateTimeIntervalType.auto,
                        dateFormat: DateFormat('d MMM'),
                        labelRotation: 90,
                        labelStyle: const TextStyle(color: kOrange),
                        minimum: DateTime.now(),
                        maximum: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 10),
                        majorGridLines: const MajorGridLines(width: 0,),
                      ),
                      primaryYAxis: const NumericAxis(
                          rangePadding: ChartRangePadding.round,
                        labelStyle: TextStyle(color: kOrange),
                        placeLabelsNearAxisLine: true,
                        minimum: 0,
                        maximum: 5,
                        majorGridLines: MajorGridLines(width: 0,),
                      ),
                      series: <CartesianSeries>[
                        ColumnSeries<List, DateTime>(
                          animationDuration: 500,
                          dataSource: data.mergedList,
                          xValueMapper: (List data, _) => DateTime.parse(data[0]),
                          yValueMapper: (List data, _) => data[1] == true ? data[2] : 0,
                          color: kOrange,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                          // dataLabelSettings: const DataLabelSettings(
                          //   isVisible: true,
                          //   textStyle: TextStyle(color: kWhite, fontWeight: FontWeight.bold),
                          //   margin: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                          //   borderColor: kOrange,
                          //   opacity: 0.8,
                          // ),
                          spacing: 0,
                          // width: 1,
                          // borderWidth: 5,
                        ),
                        ColumnSeries<List, DateTime>(
                          animationDuration: 500,
                          dataSource: data.mergedList,
                          xValueMapper: (List data, _) => DateTime.parse(data[0]),
                          yValueMapper: (List data, _) => data[1] == false ? data[2] : 0,
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



