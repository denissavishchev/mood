import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mood/models/mood_model.dart';
import 'package:mood/screens/mood_screen.dart';
import '../constants.dart';
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
                        color: kBlue.withOpacity(0.1),
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