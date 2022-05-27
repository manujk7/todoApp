import 'package:get/get.dart';
import 'package:to_do_app/model/task_model.dart';

import '../../model/services/database.dart';
import '../../model/services/task_manager.dart';

class HomeController extends GetxController {
  RxBool gettingData = false.obs;
  final DatabaseProvider dbProvider = DatabaseProvider.db;
  TaskManager taskManager;
  RxList<Task> todoList = RxList();
  RxBool gridView = false.obs;

  @override
  void onInit() {
    taskManager = TaskManager(dbProvider: dbProvider);
    getTaskList();
    super.onInit();
  }

  Future<void> getTaskList() async {
    todoList.value = await taskManager.loadAllTasks();
    update();
  }

  Future<void> addNewTask(Task task) async {
    await taskManager.addNewTask(task);
    getTaskList();
  }

  Future<void> updateOldTask(Task task) async {
    await taskManager.updateTask(task);
    getTaskList();
  }

  Future<void> deleteTask(Task task) async {
    taskManager.deleteTask(task);
    getTaskList();
  }
}
