import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/meal_database_helper.dart';
import '../models/meal_model.dart';
import 'mood_provider.dart';

class MealProvider with ChangeNotifier {

  final mealTextController = TextEditingController();
  final healthTextController = TextEditingController();
  final howtoTextController = TextEditingController();
  final personTextController = TextEditingController();
  final placeTextController = TextEditingController();
  final ratingTextController = TextEditingController();
  final caloriesTextController = TextEditingController();
  final opinionTextController = TextEditingController();

  late XFile? file;
  String fileName = '';
  String base64String = '';

  double stars = 0.0;
  List<MealModel> dates = [];
  DateTime? selectedDate = DateTime.now();


  bool isToday(String first, String second){
    if(DateFormat('y-MM-d').format(DateTime.parse(first)) ==
        DateFormat('y-MM-d').format(DateTime.parse(second))){
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
        health: healthTextController.text,
        howto: howtoTextController.text,
        person: personTextController.text,
        place: placeTextController.text,
        rating: ratingTextController.text,
        calories: caloriesTextController.text,
        opinion: opinionTextController.text,
        photo: base64String,
        time: DateTime.now()
    );
    await MealDatabaseHelper.insertMeal(meal: meal);
    cleanData();
    mood.toMainScreen(context, 1);
  }

  void cleanData(){
    mealTextController.clear();
    healthTextController.clear();
    howtoTextController.clear();
    personTextController.clear();
    placeTextController.clear();
    caloriesTextController.clear();
    opinionTextController.clear();
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