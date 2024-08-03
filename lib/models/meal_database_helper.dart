import 'package:mood/models/water_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'meal_model.dart';

class MealDatabaseHelper {

  static Future<Database> _openDatabase() async{
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'databaseMeal.db'),
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE IF NOT EXISTS meals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        meal TEXT,
        health TEXT,
        howto TEXT,
        person TEXT,
        place TEXT,
        rating TEXT,
        calories TEXT,
        opinion TEXT,
        photo TEXT,
        time TEXT
      )''');
        await db.execute('''
        CREATE TABLE IF NOT EXISTS water (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT,
        quantity TEXT,
        time TEXT
      )''');
      },
      version: 1,
    );
    return database;
  }

  static Future<int> insertMeal({required MealModel meal}) async{
    final db = await _openDatabase();
    return await db.insert('meals', meal.toMap());
  }

  static Future<int> insertWater({required WaterModel water}) async{
    final db = await _openDatabase();
    return await db.insert('water', water.toMap());
  }

  static Future<List<MealModel>> getMealTimeData()async {
    final db = await _openDatabase();
    List<Map<String, dynamic>> meals = await db.rawQuery(
        'SELECT id, meal, rating, calories, time FROM meals'
    );
    return List.generate(meals.length, (i){
      return MealModel(
          id: meals[i]['id'],
          meal: '',
          health: meals[i]['meal'],
          howto: '',
          person: '',
          place: '',
          rating: meals[i]['rating'],
          calories: meals[i]['calories'],
          opinion: '',
          photo: '',
          time: DateTime.parse(meals[i]['time'])
      );
    });
  }

  static Future<List<WaterModel>> getWaterData()async {
    final db = await _openDatabase();
    final List<Map<String, dynamic>> water = await db.query('water');
    return List.generate(water.length, (i){
      return WaterModel(
          id: water[i]['id'],
          type: water[i]['type'],
          quantity: water[i]['quantity'],
          time: DateTime.parse(water[i]['time'])
      );
    });
  }

  static Future<List<MealModel>> getSingleMealData(String day) async{
    final db = await _openDatabase();
    List<Map<String, dynamic>> meals = await db.rawQuery(
        'SELECT * FROM meals WHERE time LIKE "%$day%"'
    );
    return List.generate(meals.length, (i){
      return MealModel(
          meal: meals[i]['meal'],
          health: meals[i]['health'],
          howto: meals[i]['howto'],
          person: meals[i]['person'],
          place: meals[i]['place'],
          rating: meals[i]['rating'],
          calories: meals[i]['calories'],
          opinion: meals[i]['opinion'],
          photo: meals[i]['photo'],
          time: DateTime.parse(meals[i]['time'])
      );
    });
  }

  static Future<List<WaterModel>> getSingleWaterData(String day) async{
    final db = await _openDatabase();
    List<Map<String, dynamic>> water = await db.rawQuery(
        'SELECT * FROM water WHERE time LIKE "%$day%"'
    );
    return List.generate(water.length, (i){
      return WaterModel(
          id: water[i]['id'],
          type: water[i]['type'],
          quantity: water[i]['quantity'],
          time: DateTime.parse(water[i]['time'])
      );
    });
  }

  static Future<int> deleteMeal(int id) async{
    final db = await _openDatabase();
    return await db.delete('meals', where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> deleteWater(int id) async{
    final db = await _openDatabase();
    return await db.delete('water', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> deleteDatabase() async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'databaseMeal.db');
    return databaseFactory.deleteDatabase(path);
  }

}