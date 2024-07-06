class MoodModel{
  int? id;
  String mood;
  String action;
  String person;
  String place;
  String rating;
  String description;
  String photo;
  DateTime time;

  MoodModel({
    this.id,
    required this.mood,
    required this.action,
    required this.person,
    required this.place,
    required this.rating,
    required this.description,
    required this.photo,
    required this.time,
  });

  Map<String, dynamic> toMap(){
    return {
      'mood': mood,
      'action': action,
      'person': person,
      'place': place,
      'rating': rating,
      'description': description,
      'photo': photo,
      'time': time.toString(),
    };
  }
}