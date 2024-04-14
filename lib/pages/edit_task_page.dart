import 'package:fl_tasklist_app/data/datasource/task_remote_datasource.dart';
import 'package:fl_tasklist_app/data/models/add_task_request_model.dart';
import 'package:fl_tasklist_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fl_tasklist_app/data/models/task_response_model.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;
  const EditTaskPage({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final titlecontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Task',
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
                final newModel = AddTaskRequestModel(
                  data: Data(
                      title: titlecontroller.text,
                      description: descriptioncontroller.text),
                );
                await TaskRemoteDatasource()
                    .updateTask(widget.task.id, newModel);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: const Text('Edit'),
            ),
          ],
        ));
  }
}
