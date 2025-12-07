import 'package:flutter/material.dart';
import '../utils/db_helper.dart';

class ToDoListApp extends StatefulWidget {
  @override
  State createState() => _ToDoListAppState();
}

class _ToDoListAppState extends State<ToDoListApp> {
  final TextEditingController _taskController = TextEditingController();
  List<Map<String, dynamic>> _tasks = [];
  List<bool> checkboxValues = []; // List.filled(20, false);
  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    final data = await DBHelper.instance.getTasks();
    setState(() {
      _tasks = data;
    });
  }

  void _addTask() async {
    if (_taskController.text.isNotEmpty) {
      await DBHelper.instance.addTask(_taskController.text);
      _taskController.clear();
      _loadTasks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      labelText: 'Add a Task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addTask,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                if (checkboxValues.length < index + 1){
                  checkboxValues.add(_tasks[index]['isDone'] == 1? true : false);
                }

                print("is done first stage $_tasks[index]['isDone']");
                return CheckboxListTile(
                  title: Text(_tasks[index]['title']),
                  value: checkboxValues[index],
                  onChanged: (bool? value) async {
                    print("$index $value");
                    int updatedStatus = await DBHelper.instance.updateTask(
                        _tasks[index]['id'], value!?1:0);
                    setState(() {
                      checkboxValues[index] = value ? true : false;
                    });
                    print('updatedStatus $updatedStatus');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

