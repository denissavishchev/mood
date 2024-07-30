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

  factory MoodModel.fromJson(Map<String, dynamic> json) {
    return MoodModel(
      mood: json['mood'],
      action: json['action'],
      person: json['person'],
      place: json['place'],
      rating: json['rating'],
      description: json['description'],
      photo: json['photo'],
      time: json['time'],
    );
  }
}