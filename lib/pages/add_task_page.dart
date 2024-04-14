import 'package:fl_tasklist_app/data/datasource/task_remote_datasource.dart';
import 'package:fl_tasklist_app/data/models/add_task_request_model.dart';
import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  //title controller
  final titlecontroller = TextEditingController();
  //description controller
  final descriptioncontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Task',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          TextField(
            controller: titlecontroller,
            decoration: const InputDecoration(
              hintText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          TextField(
            controller: descriptioncontroller,
            decoration: const InputDecoration(
              hintText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
           ElevatedButton(
            onPressed: () async {
              final model = AddTaskRequestModel(
                data: Data(
                    title: titlecontroller.text,
                    description: descriptioncontroller.text),
              );
              final response = await TaskRemoteDatasource().addTask(model);
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
