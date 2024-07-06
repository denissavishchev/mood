import 'package:flutter/material.dart';
import 'package:mood/models/database_helper.dart';
import 'package:mood/models/mood_model.dart';
import 'package:mood/screens/add_mood_screen.dart';
import 'package:provider/provider.dart';
import '../providers/mood_provider.dart';
import '../widgets/bar_widget.dart';

class MoodScreen extends StatelessWidget {
  const MoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MoodProvider>(
        builder: (context, data, _){
          return Scaffold(
            backgroundColor: Colors.grey,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Container(
                      height: size.height * 0.07,
                      decoration: const BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.all(Radius.circular(8))
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: size.height * 0.42,
                              width:  size.width * 0.8,
                              clipBehavior: Clip.hardEdge,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8))
                              ),
                              child: FutureBuilder(
                                future: MoodDatabaseHelper.getData(),
                                builder: (context, snapshot){
                                  if(snapshot.connectionState == ConnectionState.waiting){
                                    return const Center(child: CircularProgressIndicator());
                                  }
                                  return ListView.builder(
                                      itemCount: snapshot.data?.length,
                                      itemBuilder: (context, index){
                                        if(snapshot.data == null){
                                          return const Text('No data');
                                        }
                                          List<MoodModel> moods = snapshot.data!;
                                          return GestureDetector(
                                            onLongPress: () => data.deleteMood(int.parse(moods[index].id.toString())),
                                            child: Container(
                                              height: 80,
                                              width:  size.width * 0.8,
                                              margin: const EdgeInsets.only(bottom: 8),
                                              decoration: const BoxDecoration(
                                                  color: Colors.deepOrange,
                                                  borderRadius: BorderRadius.all(Radius.circular(8))
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(moods[index].mood),
                                                  Text(moods[index].description),
                                                ],
                                              ),
                                            ),
                                          );
                                      }
                                  );
                                },
                              )
                            ),
                            const SizedBox(height: 12,),
                            Container(
                              height: size.height * 0.42,
                              width:  size.width * 0.8,
                              clipBehavior: Clip.hardEdge,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8))
                              ),
                              child: ListView.builder(
                                  itemCount: 20,
                                  itemBuilder: (context, index){
                                    return Container(
                                      height: 80,
                                      width:  size.width * 0.8,
                                      margin: const EdgeInsets.only(bottom: 8),
                                      decoration: const BoxDecoration(
                                          color: Colors.deepPurple,
                                          borderRadius: BorderRadius.all(Radius.circular(8))
                                      ),
                                    );
                                  }
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          height: size.height * 0.85,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const BarWidget(color: Colors.deepOrange, topRadius: true, value: 50,),
                              const Spacer(),
                              GestureDetector(
                                onTap: () => Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) =>
                                    const AddMoodScreen())),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            Colors.deepOrange,
                                            Colors.deepPurple
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(12),
                                      )
                                  ),
                                ),
                              ),
                              const Spacer(),
                              const BarWidget(color: Colors.deepPurple, topRadius: false, value: 20,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}

