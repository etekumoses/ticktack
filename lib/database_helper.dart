import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/task.dart';
import 'models/todo.dart';

class DatabaseHelper {

  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'projects.db'),
      onCreate: (db, version) async {
        await db.execute("CREATE TABLE projects(id INTEGER PRIMARY KEY, title TEXT, desc TEXT,time DATETIME,isDone BOOL)");
        await db.execute("CREATE TABLE todo(id INTEGER PRIMARY KEY, proId INTEGER, title TEXT, isDone INTEGER)");

        return db;
      },
      version: 1,
    );
  }

  Future<int> insertTask(Task task) async {
    int proId = 0;
    Database _db = await database();
    await _db.insert('projects', task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace).then((value) {
      proId = value;
    });
    return proId;
  }
  
  Future<int> updateTask(Task task) async {
    Database _db = await database();
    return await _db.update('projects', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  // Future<void> updateTaskDescription(int id, String description) async {
  //   Database _db = await database();
  //   await _db.rawUpdate("UPDATE tasks SET description = '$description' WHERE id = '$id'");
  // }

  Future<void> insertTodo(Todo todo) async {
    Database _db = await database();
    await _db.insert('todo', todo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Task>> getTasks() async {
    Database _db = await database();
    List<Map<String, dynamic>> taskMap = await _db.query('projects');
    return List.generate(taskMap.length, (index) {
      return Task(
        id: taskMap[index]['id'],
      time: taskMap[index]['time'].toString(), 
      title: taskMap[index]['title'], 
      description: taskMap[index]['desc'],
      isDone: taskMap[index]['isDone'] == 1 ? true : false,
      );
    });
  }

  Future<List<Todo>> getTodo(int proId) async {
    Database _db = await database();
    List<Map<String, dynamic>> todoMap = await _db.rawQuery("SELECT * FROM todo WHERE proId = $proId");
    return List.generate(todoMap.length, (index) {
      return Todo(id: todoMap[index]['id'], title: todoMap[index]['title'], proId: todoMap[index]['proId'], isDone: todoMap[index]['isDone']);
    });
  }

  Future<void> updateTodoDone(int id, int isDone) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE todo SET isDone = '$isDone' WHERE id = '$id'");
  }

  Future<void> deleteTask(int id) async {
    Database _db = await database();
    await _db.rawDelete("DELETE FROM projects WHERE id = '$id'");
    await _db.rawDelete("DELETE FROM todo WHERE proId = '$id'");
  }

}