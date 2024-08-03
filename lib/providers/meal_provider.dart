import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/meal_database_helper.dart';
import '../models/meal_model.dart';
import '../models/water_model.dart';
import 'mood_provider.dart';

class MealProvider with ChangeNotifier {

  final mealTextController = TextEditingController();
  final personTextController = TextEditingController();
  final placeTextController = TextEditingController();
  final caloriesTextController = TextEditingController();
  final opinionTextController = TextEditingController();
  final waterQuantityTextController = TextEditingController();
  final maxCaloriesController = TextEditingController();
  final maxWaterController = TextEditingController();

  late XFile? file;
  String fileName = '';
  String base64String = '';

  double stars = 0.0;
  List<MealModel> dates = [];
  DateTime? selectedDate = DateTime.now();
  double calories = 0.0;
  double water = 0.0;
  bool mealState = true;
  String waterType = 'water';
  String maxCalories = '3000';
  String maxWater = '3000';
  List<List<Object>> mealList = [];
  List<List<Object>> waterList = [];

  List<String> waterIcons = [
    'water',
    'coffee',
    'tea',
    'juice',
    'soda',
    'beer',
    'wine',
    'alcohol',
  ];

  void calculateStatistic(List meal, List water){
    final mealResult = <String, List<double>>{};
    final waterResult = <String, List<double>>{};
    for (final list in meal) {
      final mealDate = list.time;
      final mealValue = double.parse(list.calories);
        mealResult.update(DateFormat('y-MM-dd').format(mealDate),
                (values) => values..add(mealValue),
            ifAbsent: () => [mealValue]);
    }
    for (final list in water) {
      final waterDate = list.time;
      final waterValue = double.parse(list.quantity);
      waterResult.update(DateFormat('y-MM-dd').format(waterDate),
              (values) => values..add(waterValue),
          ifAbsent: () => [waterValue]);
    }
    mealList = mealResult.entries.map((e) {
      final sum = e.value.reduce((a, b) => a + b);
      return [e.key, sum];
    }).toList();
    waterList = waterResult.entries.map((e) {
      final sum = e.value.reduce((a, b) => a + b);
      return [e.key, sum];
    }).toList();
  }

  Future saveSettings() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('maxCalories', maxCaloriesController.text);
    await prefs.setString('maxWater', maxWaterController.text);
  }

  Future loadSettings() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    maxCalories = prefs.getString('maxCalories') ?? '3000';
    maxWater = prefs.getString('maxWater') ?? '3000';
    maxCaloriesController.text = maxCalories;
    maxWaterController.text = maxWater;
  }

  void updateWaterType(String type){
    waterType = type;
    notifyListeners();
  }

  void updateRating(double rating){
    stars = rating;
    notifyListeners();
  }

  void switchMeal(){
    mealState = !mealState;
    notifyListeners();
  }

  bool isToday(String first, String second){
    if(DateFormat('y-MM-dd').format(DateTime.parse(first)) ==
        DateFormat('y-MM-dd').format(DateTime.parse(second))){
      return true;
    }
    return false;
  }

  void deleteMeal(int docId) async{
    await MealDatabaseHelper.deleteMeal(docId);
    notifyListeners();
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

  insertMeal(context) async{
    final mood = Provider.of<MoodProvider>(context, listen: false);
    final meal = MealModel(
        meal: mealTextController.text,
        health: mealState.toString(),
        howto: '',
        person: personTextController.text,
        place: placeTextController.text,
        rating: stars.toString(),
        calories: caloriesTextController.text,
        opinion: opinionTextController.text,
        photo: base64String,
        time: DateTime.now()
    );
    await MealDatabaseHelper.insertMeal(meal: meal);
    cleanData();
    mood.toMainScreen(context, 1);
  }

  insertWater(context) async{
    final mood = Provider.of<MoodProvider>(context, listen: false);
    final water = WaterModel(
        type: waterType,
        quantity: waterQuantityTextController.text,
        time: DateTime.now(),
    );
    await MealDatabaseHelper.insertWater(water: water);
    cleanData();
    mood.toMainScreen(context, 1);
  }

  void cleanData(){
    mealTextController.clear();
    personTextController.clear();
    placeTextController.clear();
    caloriesTextController.clear();
    opinionTextController.clear();
    waterQuantityTextController.clear();
    stars = 0.0;
    fileName = '';
    base64String = '';
  }

  Future<void>showDescription(context, List<MealModel> meals, int index) async{
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
                        icon: const Icon(Icons.clear), color: kBlue,),
                    ],
                  ),
                  Container(
                    height: 60,
                    width: size.width,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: kBlue.withOpacity(0.1),
                      borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(4)
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(meals[index].meal,
                          style: kBigTextStyle,),
                        const SizedBox(width: 12,),
                        Text(meals[index].opinion,
                          style: kBigTextStyle,),
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    width: size.width,
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: kBlue.withOpacity(0.1),
                        borderRadius: const BorderRadius.all(Radius.circular(4))
                    ),
                    child: meals[index].photo == ''
                        ? const SizedBox.shrink()
                        : Image.memory(base64Decode(meals[index].photo),),
                  ),
                ],
              )
          );
        });
  }


}