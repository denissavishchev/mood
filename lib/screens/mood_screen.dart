import 'package:flutter/material.dart';
import 'package:mood/constants.dart';
import 'package:mood/screens/add_mood_screen.dart';
import 'package:provider/provider.dart';
import '../models/database_helper.dart';
import '../providers/mood_provider.dart';
import '../widgets/mood_list_widget.dart';
import '../widgets/navigation_button_widget.dart';
import 'package:fl_chart/fl_chart.dart';

class MoodScreen extends StatelessWidget {
  const MoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MoodProvider>(
        builder: (context, data, _){
          return Scaffold(
            backgroundColor: kGrey,
            body: Column(
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
                    const SizedBox(height: 24,),
                    Row(
                      children: [
                        const Spacer(),
                        FutureBuilder(
                            future: MoodDatabaseHelper.getData(),
                            builder: (context, snapshot){
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return const Center(child: CircularProgressIndicator());
                              }
                              final moods = snapshot.data!;
                              return GestureDetector(
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
                                            return PieChartSectionData(
                                              color: snapshot.data![i].mood == 'true'
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
                                              // value: double.parse(snapshot.data![i].rating),
                                              radius: double.parse(snapshot.data![i].rating) * 15
                                            );
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
                                        child: const Center(child: Icon(Icons.add)),
                                      )
                                    ],
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
              ],
            ),
          );
        }
    );
  }
}







