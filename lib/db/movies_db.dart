import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks_for_home/domain/watch_list.dart';
import 'package:tasks_for_home/presentation/screens/watch_list_screen.dart';

class MoviesDatabase {
  MoviesDatabase._init();
  static final MoviesDatabase instance = MoviesDatabase._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('movieDB.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate:  _createDB);
  }

  /*
  String? name;
  String? id;
  String? movieIcon;
  String? movieName;
  int? movieId;
  */
  Future _createDB(Database db, int version) async {
    // final db = await instance.database;
    await db.execute(
      "CREATE TABLE movie ("
        "id INTEGER PRIMARY KEY,"
        "name TEXT,"
        "movieIcon TEXT,"
        "movieName TEXT,"
        "movieId INTEGER"")"
    );
  }

  Future<void> insertMovie(WatchListModel movie) async {
    final db = await database;
    await db.insert('movie', movie.toMap());
  }

  Future close() async {
    final db = await database;
    db.close();
  }

  Future delete(int id) async {
    final db = await database;
    await db.delete("movie", where: "id = ?", whereArgs: [id]);
  }

  Future<List<WatchListModel>> getAllMovies() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query('movie', columns: ["id", "movieIcon", "movieName", "movieId", "name"]);
    List<WatchListModel> movies = [];
    results.forEach((result) {
        WatchListModel movie = WatchListModel.fromMap(result);
        movies.add(movie);
     });
     return movies;
  }
}
