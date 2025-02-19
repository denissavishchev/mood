import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mood/models/mood_model.dart';
import 'package:mood/screens/meal_screen.dart';
import 'package:mood/screens/main_screen.dart';
import 'package:mood/screens/mood_screen.dart';
import 'package:mood/screens/settings_screen.dart';
import '../constants.dart';
import '../models/mood_database_helper.dart';
import 'package:image_picker/image_picker.dart';

class MoodProvider with ChangeNotifier {

  final actionTextController = TextEditingController();
  final personTextController = TextEditingController();
  final placeTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

  late XFile? file;
  String fileName = '';
  String base64String = '';

  double stars = 0.0;
  Map<String, double> barRatings = {};
  List<MoodModel> dates = [];
  DateTime? selectedDate = DateTime.now();
  int currentPageIndex = 0;
  List<List> mergedList = [];


  List<IconData> pageIcons = [
    Icons.mood,
    Icons.set_meal_outlined,
    Icons.animation,
    Icons.settings
  ];

  List<Color> gradients(double stars){
    switch(stars){
      case 0.0:
        return [kGrey, kBlack];
      case 1.0:
        return [kNavy, kBlueGrey];
      case 2.0:
        return [kOcean, kDarkBlue];
      case 3.0:
        return [kSalad, kGreen];
      case 4.0:
        return [kLightYellow, kLightGreen];
      case 5.0:
        return [kYellow, kOrange];
    }
    return [kBlack, kWhite];
  }

  void calculateStatistic(List<MoodModel> moods){
    final trueResult = <String, List<double>>{};
    final falseResult = <String, List<double>>{};
    for (final list in moods) {
      final date = list.time;
      final isTrue = bool.parse(list.mood);
      final value = double.parse(list.rating);
      if (isTrue) {
        trueResult.update(DateFormat('y-MM-dd').format(date),
                (values) => values..add(value),
            ifAbsent: () => [value]);
      } else {
        falseResult.update(DateFormat('y-MM-dd').format(date), (values) => values..add(value),
            ifAbsent: () => [value]);
      }
    }
    final trueList = trueResult.entries.map((e) {
      final average = e.value.reduce((a, b) => a + b) / e.value.length;
      return [e.key, true, average];
    }).toList();
    final falseList = falseResult.entries.map((e) {
      final average = e.value.reduce((a, b) => a + b) / e.value.length;
      return [e.key, false, average];
    }).toList();
    mergedList = [...trueList, ...falseList];
  }

  void switchPage(int index){
    currentPageIndex = index;
    notifyListeners();
  }

  Widget currentPage(){
    switch (currentPageIndex) {
      case 0:
        return const MoodScreen();
      case 1:
        return const MealScreen();
      case 2:
        return const Text('Sleep');
      case 3:
        return const SettingsScreen();
    }
    return const MoodScreen();
  }

  bool isToday(String first, String second){
    if(DateFormat('y-MM-dd').format(DateTime.parse(first)) ==
        DateFormat('y-MM-dd').format(DateTime.parse(second))){
      return true;
    }
    return false;
  }

  Future showHistory(context) async{
    final DateTime? picked = await showDatePicker(
      context: context,
      locale: const Locale('en', 'GB'),
      initialDate: selectedDate,
      firstDate: DateTime(dates.first.time.year, dates.first.time.month, dates.first.time.day),
      lastDate: DateTime(dates.last.time.year, dates.last.time.month, dates.last.time.day),
    );
    selectedDate = picked;
    if(picked == null){
      selectedDate = DateTime.now();
    }
    notifyListeners();
  }

  void toMainScreen(context, int index){
    cleanData();
    currentPageIndex = index;
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) =>
        const MainScreen()));
  }

  void updateRating(double rating){
    stars = rating;
    notifyListeners();
  }

  String doughnut(String rating){
    switch (rating) {
      case '1':
        return '30%';
      case '2':
        return '50%';
      case '3':
        return '70%';
      case '4':
        return '85%';
      case '5':
        return '100%';
    }
    return '30%';
  }

  Future pickAnImage()async{
    ImagePicker image = ImagePicker();
    file = await image.pickImage(source: ImageSource.camera,
        maxHeight: 1000.0,
        maxWidth: 1000.0);
    if(file == null) return;
    List<int> imageBytes = File(file!.path).readAsBytesSync();
    base64String = base64Encode(imageBytes);
    fileName = DateTime.now().millisecondsSinceEpoch.toString();
    notifyListeners();
  }

  insertMood(context) async{
    final mood = MoodModel(
        mood: 'true',
        action: actionTextController.text,
        person: personTextController.text,
        place: placeTextController.text,
        rating: stars.toString(),
        description: descriptionTextController.text,
        photo: base64String,
        time: DateTime.now()
    );
    await MoodDatabaseHelper.insertMood(mood: mood);
    cleanData();
    toMainScreen(context, 0);
  }

  void deleteMood(int docId) async{
    await MoodDatabaseHelper.deleteMood(docId);
    notifyListeners();
  }

  void cleanData(){
    actionTextController.clear();
    personTextController.clear();
    placeTextController.clear();
    descriptionTextController.clear();
    stars = 0.0;
    fileName = '';
    base64String = '';
  }

  Future<void>showDescription(context, List<MoodModel> moods, int index) async{
    Size size = MediaQuery.sizeOf(context);
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
              height: size.height * 0.5,
              width: size.width,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const BoxDecoration(
                color: kGrey,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.clear), color: kBlueGrey,),
                    ],
                  ),
                  Container(
                    height: 60,
                    width: size.width,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: kBlueGrey.withOpacity(0.1),
                      borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(4)
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(moods[index].action,
                          style: kBigTextStyle,),
                        const SizedBox(width: 12,),
                        Text(moods[index].description,
                          style: kBigTextStyle,),
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    width: size.width,
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: kBlueGrey.withOpacity(0.1),
                        borderRadius: const BorderRadius.all(Radius.circular(4))
                    ),
                    child: moods[index].photo == ''
                        ? const SizedBox.shrink()
                        : Image.memory(base64Decode(moods[index].photo),),
                  ),
                ],
              )
          );
        });
  }

}