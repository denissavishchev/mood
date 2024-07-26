class WaterModel{
  int? id;
  String type;
  String quantity;
  DateTime time;

  WaterModel({
    this.id,
    required this.type,
    required this.quantity,
    required this.time,
  });

  Map<String, dynamic> toMap(){
    return {
      'type': type,
      'quantity': quantity,
      'time': time.toString(),
    };
  }
}