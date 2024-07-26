class MealModel{
  int? id;
  String meal;
  String health;
  String howto;
  String person;
  String place;
  String rating;
  String calories;
  String opinion;
  String photo;
  DateTime time;

  MealModel({
    this.id,
    required this.meal,
    required this.health,
    required this.howto,
    required this.person,
    required this.place,
    required this.rating,
    required this.calories,
    required this.opinion,
    required this.photo,
    required this.time,
  });

  Map<String, dynamic> toMap(){
    return {
      'meal': meal,
      'health': health,
      'howto': howto,
      'person': person,
      'place': place,
      'rating': rating,
      'calories': calories,
      'opinion': opinion,
      'photo': photo,
      'time': time.toString(),
    };
  }
}