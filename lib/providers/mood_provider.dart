import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mood/models/mood_model.dart';
import 'package:mood/screens/mood_screen.dart';
import '../models/database_helper.dart';
import 'package:image_picker/image_picker.dart';

class MoodProvider with ChangeNotifier {

  final moodTextController = TextEditingController();
  final actionTextController = TextEditingController();
  final personTextController = TextEditingController();
  final placeTextController = TextEditingController();
  final ratingTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

  late XFile? file;
  String fileName = '';
  String base64String = '';

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
        mood: moodTextController.text,
        action: actionTextController.text,
        person: personTextController.text,
        place: placeTextController.text,
        rating: ratingTextController.text,
        description: descriptionTextController.text,
        photo: base64String,
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