import 'dart:async';

import '../task_model.dart';
import 'database.dart';

class TaskManager {

  final DatabaseProvider dbProvider;

  TaskManager({ this.dbProvider});

  Future<void> addNewTask(Task task) async {
    return dbProvider.insert(task);
  }

  Future<void> updateTask(Task task) async {
    return dbProvider.update(task);
  }

  Future<List<Task>> loadAllTasks() async {
    return dbProvider.getAll();
  }

  Future<void> deleteTask(Task task) async {
    return dbProvider.delete(task.id);
  }
}
