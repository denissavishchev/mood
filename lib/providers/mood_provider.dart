import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mood/models/mood_model.dart';
import 'package:mood/screens/mood_screen.dart';
import '../models/database_helper.dart';
import 'package:image_picker/image_picker.dart';



class MoodProvider with ChangeNotifier {

  final actionTextController = TextEditingController();
  final personTextController = TextEditingController();
  final placeTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

  late XFile? file;
  String fileName = '';
  String base64String = '';

  bool moodState = true;
  double stars = 0.0;

  void toMoodScreen(context){
    cleanData();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) =>
        const MoodScreen()));
  }

  void updateRating(double rating){
    stars = rating;
    notifyListeners();
  }

  void switchMood(){
    moodState = !moodState;
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
    file = await image.pickImage(source: ImageSource.camera);
    if(file == null) return;
    List<int> imageBytes = File(file!.path).readAsBytesSync();
    base64String = base64Encode(imageBytes);
    fileName = DateTime.now().millisecondsSinceEpoch.toString();
    notifyListeners();
  }

  insertMood(context) async{
    final mood = MoodModel(
        mood: moodState.toString(),
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
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) =>
        const MoodScreen()));
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
    moodState = true;
    stars = 0.0;
    fileName = '';
    base64String = '';
  }


}