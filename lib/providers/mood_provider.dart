import 'package:flutter/material.dart';
import 'package:mood/models/mood_model.dart';
import 'package:mood/screens/mood_screen.dart';
import '../models/database_helper.dart';

class MoodProvider with ChangeNotifier {

  final moodTextController = TextEditingController();
  final actionTextController = TextEditingController();
  final personTextController = TextEditingController();
  final placeTextController = TextEditingController();
  final ratingTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  final photoTextController = TextEditingController();

  insertMood(context) async{
    final mood = MoodModel(
        mood: moodTextController.text,
        action: actionTextController.text,
        person: personTextController.text,
        place: placeTextController.text,
        rating: ratingTextController.text,
        description: descriptionTextController.text,
        photo: photoTextController.text,
        time: DateTime.now()
    );
    await MoodDatabaseHelper.insertMood(mood: mood);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) =>
        const MoodScreen()));
  }

  void deleteMood(int docId) async{
    await MoodDatabaseHelper.deleteMood(docId);
    notifyListeners();
  }


}