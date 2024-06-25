import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Diet {
  int? id;
  String titulo;
  String text;

  Diet({required this.id, required this.titulo, required this.text});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'text': text,
    };
  }

  factory Diet.fromMap(Map<String, dynamic> map) {
    return Diet(
      id: map['id'],
      titulo: map['titulo'],
      text: map['text'],
    );
  }
}

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  late Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
  String path = join(await getDatabasesPath(), 'your_database.db');
  _database = await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE diets (id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT, text TEXT)',
      );
    },
  );
  print('Database initialized successfully.');
  return _database;
}


  Future<int> insertDiet(Diet diet) async {
    final db = await database;
    return await db.insert('diets', diet.toMap());
  }

  Future<List<Diet>> getDiets() async {
    final db = await database;
    var res = await db.query('diets');
    List<Diet> list =
        res.isNotEmpty ? res.map((c) => Diet.fromMap(c)).toList() : [];
    return list;
  }

  // En tu clase DBProvider
  Future<List<Diet>> getAllDiets() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('diets');
    return List.generate(maps.length, (i) {
      return Diet(
        id: maps[i]['id'],
        titulo: maps[i]['titulo'],
        text: maps[i]['text'],
      );
    });
  }
}
