import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks_for_home/data/buy_todo_list.dart';

class TodoListDB {

  TodoListDB._();
  static final TodoListDB db = TodoListDB._();
  Database? _db;


  Future get database async {
    if (_db == null) {
      _db = await init();
    }
    return _db;
  }


  Future<Database> init() async {
    String path = join(await getDatabasesPath(), "todo.db");
    Database db = await openDatabase(path, version: 1, onOpen: (db) {},
    onCreate: (database, version) async {
        await database.execute("CREATE TABLE IF NOT EXISTS todo ("
        "id INTEGER PRIMARY KEY,"
        "title TEXT,"
        "category TEXT,"
        "isDone INTEGER"
        ")");
    });
    return db;
  }

  Future addTodo(BuyList todo) async {
    Database db = await database;
    var val = await db.rawQuery("SELECT MAX(id) + 1 AS id FROM todo");
    var id = val.first["id"];
    if (id == null) {
      id = 1;
    }
    // String? category = todo.category ?? "";
    return await db.rawInsert(
      "INSERT INTO todo (id, title, category, isDone) "
      "VALUES (?, ?, ?, ?)",
      [id, todo.item, todo.category, todo.isChecked]
    );
  }

  BuyList todoFromMap(Map map) {
    BuyList todo = BuyList();
    todo.item = map["title"];
    todo.category = map["category"];
    todo.isChecked = map["isDone"];
    return todo;

  }

  Future<List<BuyList>> getAllTodo() async {
    Database db = await database;
    var records = await db.query('todo');
    List<BuyList> list = records.isNotEmpty 
    ? records.map((rec) => todoFromMap(rec)).toList() : [];
    return list;
  }
  //TODO
  void removeItem(int index) {

  }

}