import 'package:mood/models/mood_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MoodDatabaseHelper {

  static Future<Database> _openDatabase() async{
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE IF NOT EXISTS moods (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        mood TEXT,
        action TEXT,
        person TEXT,
        place TEXT,
        rating TEXT,
        description TEXT,
        photo TEXT,
        time TEXT
      )''');
      },
      version: 1,
    );
    return database;
  }

  static Future<int> insertMood({required MoodModel mood}) async{
    final db = await _openDatabase();
    return await db.insert('moods', mood.toMap());
  }

  static Future<List<MoodModel>> getTimeData()async {
    final db = await _openDatabase();
    List<Map<String, dynamic>> moods = await db.rawQuery(
        'SELECT id, mood, rating, time FROM moods'
    );
    return List.generate(moods.length, (i){
      return MoodModel(
          id: moods[i]['id'],
          mood: moods[i]['mood'],
          action: '',
          person: '',
          place: '',
          rating: moods[i]['rating'],
          description: '',
          photo: '',
          time: DateTime.parse(moods[i]['time'])
      );
    });
  }

  static Future<List<MoodModel>> getData()async {
    final db = await _openDatabase();
    final List<Map<String, dynamic>> moods = await db.query('moods');
    return List.generate(moods.length, (i){
      return MoodModel(
          id: moods[i]['id'],
          mood: moods[i]['mood'],
          action: moods[i]['action'],
          person: moods[i]['person'],
          place: moods[i]['place'],
          rating: moods[i]['rating'],
          description: moods[i]['description'],
          photo: '',
          time: DateTime.parse(moods[i]['time'])
      );
    });
  }

  static Future<List<MoodModel>> getSingleData(String day) async{
    final db = await _openDatabase();
    List<Map<String, dynamic>> moods = await db.rawQuery(
        'SELECT * FROM moods WHERE time LIKE "%$day%"'
    );
    return List.generate(moods.length, (i){
      return MoodModel(
          id: moods[i]['id'],
          mood: moods[i]['mood'],
          action: moods[i]['action'],
          person: moods[i]['person'],
          place: moods[i]['place'],
          rating: moods[i]['rating'],
          description: moods[i]['description'],
          photo: moods[i]['photo'],
          time: DateTime.parse(moods[i]['time'])
      );
    });
  }

  static Future<int> deleteMood(int id) async{
    final db = await _openDatabase();
    return await db.delete('moods', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> deleteDatabase() async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'database.db');
    return databaseFactory.deleteDatabase(path);
  }

}