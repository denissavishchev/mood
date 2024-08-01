import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mood/constants.dart';
import 'package:mood/screens/add_mood_screen.dart';
import 'package:mood/screens/mood_statistic_screen.dart';
import 'package:provider/provider.dart';
import '../models/mood_database_helper.dart';
import '../providers/mood_provider.dart';
import '../widgets/mood_list_widget.dart';
import '../widgets/button_widget.dart';
import 'package:fl_chart/fl_chart.dart';

class MoodScreen extends StatelessWidget {
  const MoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MoodProvider>(
        builder: (context, data, _){
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: kGrey,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      const MoodsListWidget(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Spacer(),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () => Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) =>
                                    const MoodStatisticScreen())),
                                icon: const Icon(Icons.stacked_bar_chart),),
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
                                            : DateFormat('y-MM-dd').format(DateTime.parse(data.selectedDate.toString()))),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                          const Spacer(),
                          FutureBuilder(
                              future: MoodDatabaseHelper.getData(),
                              builder: (context, snapshot){
                                if(snapshot.connectionState == ConnectionState.waiting){
                                  return const Center(child: CircularProgressIndicator());
                                }
                                final moods = snapshot.data!;
                                return AbsorbPointer(
                                  absorbing: !data.isToday(
                                      data.selectedDate.toString(),
                                      DateTime.now().toString()),
                                  child: GestureDetector(
                                    onTap: () => Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) =>
                                        const AddMoodScreen())),
                                    child: Container(
                                      width: 200,
                                      height: 200,
                                      padding: const EdgeInsets.all(2),
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(100)),
                                          color: kGrey,
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 2,
                                                spreadRadius: 2,
                                                color: kWhite
                                            )
                                          ]
                                      ),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          PieChart(
                                            PieChartData(
                                              startDegreeOffset: -90,
                                              sections: List.generate(moods.length, ((i){
                                                if(data.isToday(moods[i].time.toString(), data.selectedDate.toString())){
                                                  for(final m in moods){
                                                    data.barRatings.addAll({m.mood : double.parse(m.rating)});
                                                  }
                                                  return PieChartSectionData(
                                                      color: moods[i].mood == 'true'
                                                          ? kOrange : kBlue,
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            moods[i].mood == 'true'
                                                                ? kYellow.withOpacity(0.7)
                                                                : kNavy.withOpacity(0.7),
                                                            moods[i].mood == 'true'
                                                                ? kOrange.withOpacity(0.7)
                                                                : kBlue.withOpacity(0.7)
                                                          ],
                                                          begin: Alignment.bottomLeft,
                                                          end: Alignment.topRight
                                                      ),
                                                      radius: double.parse(moods[i].rating ) * 15
                                                  );
                                                }else{
                                                  return PieChartSectionData(
                                                    value: 0,
                                                  );
                                                }
                                              }))
                                            )
                                          ),
                                          Container(
                                            width: 44,
                                            height: 44,
                                            decoration: BoxDecoration(
                                              color: kGrey,
                                              borderRadius: const BorderRadius.all(Radius.circular(25),),
                                              border: Border.all(color: kOrange.withOpacity(0.7), width: 1.5),
                                            ),
                                            child: Center(
                                                child: Icon(
                                                    data.isToday(data.selectedDate.toString(), DateTime.now().toString())
                                                        ? Icons.add : Icons.cancel)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                          ),
                          const SizedBox(width: 12,),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10,),
                ],
              ),
            ),
          );
        }
    );
  }
}







