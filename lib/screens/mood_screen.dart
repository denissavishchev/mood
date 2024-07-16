import 'package:flutter/material.dart';
import 'package:mood/constants.dart';
import 'package:mood/models/mood_model.dart';
import 'package:mood/screens/add_mood_screen.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/database_helper.dart';
import '../providers/mood_provider.dart';
import '../widgets/mood_list_widget.dart';
import '../widgets/navigation_button_widget.dart';

class MoodScreen extends StatelessWidget {
  const MoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MoodProvider>(
        builder: (context, data, _){
          return Scaffold(
            body: Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    kPinkGrey,
                    kBlueGrey
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                )
              ),
              child: Column(
                children: [
                  const SizedBox(height: 40,),
                  SizedBox(
                    height: size.height * 0.07,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Mood', style: kBigOrangeTextStyle,),
                        const NavigationButtonWidget(icon: Icons.access_alarm,),
                        const NavigationButtonWidget(icon: Icons.account_circle_outlined,),
                        const NavigationButtonWidget(icon: Icons.account_balance_outlined,),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const MoodsListWidget(color: kOrange,),
                      FutureBuilder(
                          future: MoodDatabaseHelper.getData(),
                          builder: (context, snapshot){
                            if(snapshot.connectionState == ConnectionState.waiting){
                              return const Center(child: CircularProgressIndicator());
                            }
                            return Container(
                              width: 200,
                              height: 200,
                              color: kWhite,
                              child: SfCircularChart(
                                  annotations: <CircularChartAnnotation>[
                                    CircularChartAnnotation(
                                        widget: GestureDetector(
                                         onTap: () => Navigator.pushReplacement(context,
                                            MaterialPageRoute(builder: (context) =>
                                            const AddMoodScreen())),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: kWhite,
                                        borderRadius: const BorderRadius.all(Radius.circular(25),),
                                        border: Border.all(color: kOrange, width: 1.5),
                                      ),
                                      child: const Center(child: Icon(Icons.add)),
                                    ),
                                  ),),
                                  ],
                                margin: EdgeInsets.zero,
                                  series: <CircularSeries>[
                                    DoughnutSeries<MoodModel, int>(
                                      animationDuration: 600,
                                        dataSource: snapshot.data!,
                                        pointColorMapper:(mood,  _) => mood.mood == 'good' ? kOrange : kBlue,
                                        xValueMapper: (mood, _) => 1,
                                        yValueMapper: (mood, _) => 1,
                                        pointRadiusMapper: (mood, _) => data.doughnut(mood.rating),
                                        explode: true,
                                        explodeAll: true,
                                        explodeOffset: '1',
                                        radius: '40%',
                                        innerRadius: '30%',
                                        // strokeColor: kBlueGrey
                                    )
                                  ]
                              ),
                            );
                          }
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}







