import 'package:restaurant_app/data/model/restaurant/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteServices {
  static const String _databaseName = 'restaurant.db';
  static const String _tableName = 'favorite';
  static const int _version = 1;
  Future<void> createTables(Database database) async {
    await database.execute('''
    CREATE TABLE $_tableName (
    id TEXT UNIQUE,
    name TEXT,
    description TEXT,
    pictureId TEXT,
    city TEXT,
    rating NUMERIC
    )
    ''');
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      _databaseName,
      version: _version,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  Future<int> insertFavoriteRestaurant(Restaurant restaurant) async {
    final db = await _initDatabase();

    final result = await db.insert(
      _tableName,
      restaurant.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  Future<List<Restaurant>> getAllFavouriteRestaurant() async {
    final db = await _initDatabase();

    final result = await db.query(_tableName, orderBy: 'id');
    return result.map((e) => Restaurant.fromJson(e)).toList();
  }

  Future<int> removeFavoriteRestaurant(String id) async {
    final db = await _initDatabase();

    final result = await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return result;
  }
}
