import 'package:flutter/material.dart';
import 'package:to_do_app/view-model/controller/homeController.dart';
import '../../model/task_model.dart';
import '../screens/bottom_sheet.dart';
import '../screens/new_task_page.dart';
import '../widgets/task_widget.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  final String title = 'To-Do List';

  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final HomeController homeController = Get.find();

  void _openBottomSheet() async {
    final newTask = await showCustomModalBottomSheet<Task>(
        context: context,
        builder: (context) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              color: const Color(0xFF737373),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: const NewTaskPage(),
              ),
            ),
          );
        });

    if (newTask != null) {
      homeController.addNewTask(newTask);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          elevation: 1.0,
          backgroundColor: Colors.white,
          title: Text(
            widget.title,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                homeController.gridView.value = !homeController.gridView.value;
              },
              child: Icon(
                !homeController.gridView.value ? Icons.grid_on : Icons.list,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add, size: 26, color: Colors.black),
          backgroundColor: Colors.white,
          onPressed: _openBottomSheet,
        ),
        body:

            // if (homeController) {
            //   final List<Task> tasks = state.tasks;
            //
            //   if (tasks.isEmpty) {
            //     return Center(
            //       child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: const <Widget>[
            //           Text('No Tasks',
            //               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            //           Text('Add a new Task and it\nwill show up here.',
            //               textAlign: TextAlign.center)
            //         ],
            //       ),
            //     );
            //   }
            homeController.todoList != null &&
                    homeController.todoList.isNotEmpty
                ? !homeController.gridView.value
                    ? ListView.builder(
                        itemCount: homeController.todoList.length,
                        padding: const EdgeInsets.only(top: 8),
                        itemBuilder: (BuildContext context, int index) {
                          final Task item =
                              homeController.todoList.elementAt(index);
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Dismissible(
                              background: Container(color: Colors.red),
                              direction: DismissDirection.endToStart,
                              key: ObjectKey(item),
                              child: TaskWidget(task: item),
                              onDismissed: (direction) {
                                homeController.todoList.remove(item);
                                setState(() {});
                                homeController.deleteTask(item);
                                Scaffold.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Task Deleted")));
                              },
                            ),
                          );
                        },
                      )
                    : GridView.builder(
                        itemCount: homeController.todoList.length,
                        padding: const EdgeInsets.only(top: 8),
                        itemBuilder: (BuildContext context, int index) {
                          final Task item =
                              homeController.todoList.elementAt(index);
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Dismissible(
                              background: Container(color: Colors.red),
                              direction: DismissDirection.endToStart,
                              key: ObjectKey(item),
                              child: TaskWidget(task: item),
                              onDismissed: (direction) {
                                homeController.todoList.remove(item);
                                setState(() {});
                                homeController.deleteTask(item);
                                Scaffold.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Task Deleted")));
                              },
                            ),
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 3 / 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                      )
                : Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text('No Tasks',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 8,
                        ),
                        Text('Add a new Task and it\nwill show up here.',
                            textAlign: TextAlign.center)
                      ],
                    ),
                  ),
      ),
    );
  }
}
