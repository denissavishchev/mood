import 'package:flutter/material.dart';
import 'package:mood/constants.dart';
import 'package:mood/screens/add_mood_screen.dart';
import 'package:provider/provider.dart';
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
            body: SafeArea(
              child: Container(
                width: size.width,
                height: size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.07,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Mood', style: kBigTextStyle,),
                            const NavigationButtonWidget(icon: Icons.access_alarm,),
                            const NavigationButtonWidget(icon: Icons.account_circle_outlined,),
                            const NavigationButtonWidget(icon: Icons.account_balance_outlined,),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const MoodsListWidget(color: kOrange,),
                              SizedBox(
                                height: 60,
                                width:  size.width * 0.9,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: kWhite.withOpacity(0.5),
                                          borderRadius: const BorderRadius.all(Radius.circular(12),),
                                          border: Border.all(color: kOrange, width: 1.5),
                                      ),
                                      child: Center(child: Text('Today', style: kBigTextStyle,)),
                                    ),
                                    GestureDetector(
                                      onTap: () => Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) =>
                                          const AddMoodScreen())),
                                      child: Container(
                                        width: 200,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: kWhite.withOpacity(0.5),
                                          borderRadius: const BorderRadius.all(Radius.circular(12),),
                                          border: Border.all(color: kOrange, width: 1.5),
                                        ),
                                        child: Center(child: Text('Add mood', style: kBigTextStyle,)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const MoodsListWidget(color: kBlue,),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}





