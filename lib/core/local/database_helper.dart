import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
@singleton
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

   static const _dbName = 'smart_coach_chat.db';
  static const _dbVersion = 1;

   static const chatTable = 'chats';
  static const messageTable = 'messages';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $chatTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        createdAt TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $messageTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        chatId INTEGER,
        role TEXT,
        content TEXT,
        createdAt TEXT,
        FOREIGN KEY(chatId) REFERENCES $chatTable(id) ON DELETE CASCADE
      )
    ''');
  }

   Future<int> createChat({String? title}) async {
    final db = await database;
    final data = {
      'title': title ?? 'New Chat',
      'createdAt': DateTime.now().toIso8601String(),
    };
    return await db.insert(chatTable, data);
  }

   Future<List<Map<String, dynamic>>> getAllChats() async {
    final db = await database;
    return await db.query(
      chatTable,
      orderBy: 'id DESC',
    );
  }

   Future<int> insertMessage(int chatId, String role, String content) async {
    final db = await database;
    final data = {
      'chatId': chatId,
      'role': role,
      'content': content,
      'createdAt': DateTime.now().toIso8601String(),
    };
    return await db.insert(messageTable, data);
  }

   Future<List<Map<String, dynamic>>> getMessagesByChat(int chatId) async {
    final db = await database;
    return await db.query(
      messageTable,
      where: 'chatId = ?',
      whereArgs: [chatId],
      orderBy: 'id ASC',
    );
  }

   Future<int> deleteChat(int chatId) async {
    final db = await database;
    return await db.delete(chatTable, where: 'id = ?', whereArgs: [chatId]);
  }

   Future<void> clearAllData() async {
    final db = await database;
    await db.delete(messageTable);
    await db.delete(chatTable);
  }
}
