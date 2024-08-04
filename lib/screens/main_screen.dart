import 'package:flutter/material.dart';
import 'package:mood/constants.dart';
import 'package:mood/providers/mood_provider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: kGrey,
      body: Consumer<MoodProvider>(
        builder: (context, data, _){
          return Column(
            children: [
              SizedBox(height: size.height * 0.05,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    const Spacer(),
                    Container(
                      width: size.width * 0.6,
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                      decoration: const BoxDecoration(
                        color: kBlack,
                        borderRadius: BorderRadius.all(Radius.circular(12))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(4, ((i){
                          return GestureDetector(
                            onTap: () => data.switchPage(i),
                            child: Container(
                              width: size.height * 0.065,
                              height: size.height * 0.065,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        kGrey,
                                        kWhite
                                      ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(8))
                              ),
                              child: Container(
                                width: size.height * 0.06,
                                height: size.height * 0.06,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: data.currentPageIndex == i
                                          ? kOrange.withOpacity(0.3)
                                          : kWhite,
                                      width: 1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: data.currentPageIndex == i
                                            ? kOrange.withOpacity(0.15)
                                            : kBlack.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: Offset(0, data.currentPageIndex == i ? 0 : 2)
                                      )
                                    ],
                                    gradient: const LinearGradient(
                                        colors: [
                                          kGrey,
                                          kWhite
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter
                                    ),
                                    borderRadius: const BorderRadius.all(Radius.circular(100))
                                ),
                                child: Icon(
                                  data.pageIcons[i],
                                  color: data.currentPageIndex == i
                                      ? kOrange : kBlueGrey,
                                ),
                              ),
                            ),
                          );
                        })),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: data.currentPage(),
              )
            ],
          );
        },
      )
    );
  }
}
