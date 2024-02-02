import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  static const String dbName = 'tavern.db';

  // Singleton pattern to ensure only one instance of the database is created
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(path, version: 1, onCreate: _createTables);
  }

  Future<void> _createTables(Database db, int version) async {
    // Create the 'System' table
    await db.execute(
        '''
      CREATE TABLE System (
        id INTEGER PRIMARY KEY,
        title TEXT
      )
    ''');

    // Create the 'Category' table
    await db.execute(
        '''
      CREATE TABLE Category (
        id INTEGER PRIMARY KEY,
        title TEXT
      )
    ''');

    // Create the 'SubCategory' table
    await db.execute(
        '''
      CREATE TABLE SubCategory (
        id INTEGER PRIMARY KEY,
        categoryid INTEGER,
        title TEXT,
        FOREIGN KEY (categoryid) REFERENCES Category (id)
      )
    ''');

    // Create the 'Characters' table
    await db.execute(
        '''
      CREATE TABLE Characters (
        id INTEGER PRIMARY KEY,
        title TEXT,
        level INTEGER,
        systemId INTEGER,
        FOREIGN KEY (systemId) REFERENCES System (id)
      )
    ''');

    // Create the 'Compendium' table
    await db.execute(
        '''
      CREATE TABLE Compendium (
        id INTEGER PRIMARY KEY,
        title TEXT,
        categoryId INTEGER,
        subCategoryId INTEGER,
        FOREIGN KEY (categoryId) REFERENCES Category (id),
        FOREIGN KEY (subCategoryId) REFERENCES SubCategory (id)
      )
    ''');
  }

  // Insertion functions
  Future<int> insertSystem(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('System', row);
  }

  Future<int> insertCategory(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('Category', row);
  }

  Future<int> insertSubCategory(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('SubCategory', row);
  }

  Future<int> insertCharacter(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('Characters', row);
  }

  Future<int> insertCompendium(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('Compendium', row);
  }

  // Deletion functions
  Future<int> deleteSystem(int id) async {
    Database db = await instance.database;
    return await db.delete('System', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteCategory(int id) async {
    Database db = await instance.database;
    return await db.delete('Category', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteSubCategory(int id) async {
    Database db = await instance.database;
    return await db.delete('SubCategory', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteCharacter(int id) async {
    Database db = await instance.database;
    return await db.delete('Characters', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteCompendium(int id) async {
    Database db = await instance.database;
    return await db.delete('Compendium', where: 'id = ?', whereArgs: [id]);
  }

  // Update functions
  Future<int> updateSystem(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db
        .update('System', row, where: 'id = ?', whereArgs: [row['id']]);
  }

  Future<int> updateCategory(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db
        .update('Category', row, where: 'id = ?', whereArgs: [row['id']]);
  }

  Future<int> updateSubCategory(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db
        .update('SubCategory', row, where: 'id = ?', whereArgs: [row['id']]);
  }

  Future<int> updateCharacter(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db
        .update('Characters', row, where: 'id = ?', whereArgs: [row['id']]);
  }

  Future<int> updateCompendium(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db
        .update('Compendium', row, where: 'id = ?', whereArgs: [row['id']]);
  }

  // Get single functions
  Future<Map<String, dynamic>?> getSystem({int? id, String? title}) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query('System',
        where: title != null ? 'title = ?' : 'id = ?',
        whereArgs: [title ?? id]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<Map<String, dynamic>?> getCategory({required int id}) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result =
        await db.query('Category', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<Map<String, dynamic>?> getSubCategory({required int id}) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result =
        await db.query('SubCategory', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<Map<String, dynamic>?> getCharacter(int id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result =
        await db.query('Characters', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<Map<String, dynamic>?> getCompendium(int id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result =
        await db.query('Compendium', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

  // Get all functions
  Future<List<Map<String, dynamic>>> getAllSystems() async {
    Database db = await instance.database;
    return await db.query('System');
  }

  Future<List<Map<String, dynamic>>> getAllCategories() async {
    Database db = await instance.database;
    return await db.query('Category');
  }

  Future<List<Map<String, dynamic>>> getAllSubCategories() async {
    Database db = await instance.database;
    return await db.query('SubCategory');
  }

  Future<List<Map<String, dynamic>>> getAllCharacters({int? systemId}) async {
    Database db = await instance.database;
    List<Map<String, Object?>> ls = systemId != null
        ? await db.query('Characters',
            whereArgs: [systemId], where: 'systemId = ?')
        : await db.query('Characters');
    log(ls.toString());
    return ls;
  }

  Future<List<Map<String, dynamic>>> getAllCompendium(
      {int? catId, int? subCatId}) async {
    Database db = await instance.database;
    return await db.query('Compendium');
  }
}
