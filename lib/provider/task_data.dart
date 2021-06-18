import 'package:flutter/foundation.dart';
import 'package:ticktack/database_helper.dart';
import '../models/task.dart';
import 'dart:collection';

class TaskData extends ChangeNotifier {
  final DatabaseHelper dbhelper = new DatabaseHelper();

  List<Task> _tasks = [];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  UnmodifiableListView<Task> get inCompleteTasks =>
      UnmodifiableListView(_tasks.where((Task task) {
        return task.isDone == false;
      }));

  UnmodifiableListView<Task> get completedTasks =>
      UnmodifiableListView(_tasks.where((Task task) {
        return task.isDone == true;
      }));

  int get taskCount {
    return _tasks.length;
  }

  fetchTasks() {
    dbhelper.getTasks().then((tasks) {
      _tasks = tasks;
      notifyListeners();
    });
  }

  addTask(
    String newTaskTitle,
    String newdesc,
    String newTime,
  ) {
    final task = Task(
        title: newTaskTitle,
        description: newdesc,
        time: newTime,
        isDone: false);
    dbhelper.insertTask(task);
    fetchTasks();
  }

  void updateTask(String newTaskTitle,
    String newdesc,
    String newTime,) {
   final task = Task(
        title: newTaskTitle,
        description: newdesc,
        time: newTime,
        isDone: false);
    dbhelper.updateTask(task);
    fetchTasks();
    notifyListeners();
  }

  void deleteTask(int id) {
    dbhelper.deleteTask(id);
    fetchTasks();
    notifyListeners();
  }

  void toggleTask(Task task) {
    final taskIndex = _tasks.indexOf(task);
    _tasks[taskIndex].toggleDone();
    dbhelper.updateTask(task);
    notifyListeners();
  }

  void remove(int taskId) {
    _tasks.removeAt(taskId);
  }
}
