// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fl_tasklist_app/data/datasource/task_remote_datasource.dart';
import 'package:fl_tasklist_app/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'package:fl_tasklist_app/data/models/task_response_model.dart';
import 'package:fl_tasklist_app/pages/edit_task_page.dart';

class DetailTaskPage extends StatefulWidget {
  final Task task;
  const DetailTaskPage({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<DetailTaskPage> createState() => _DetailTaskPageState();
}

class _DetailTaskPageState extends State<DetailTaskPage> {
  final titlecontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();

  @override
  void initState() {
    titlecontroller.text = widget.task.attributes.title;
    descriptioncontroller.text = widget.task.attributes.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Task Page'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          Text('Title: ${widget.task.attributes.title}'),
          const SizedBox(height: 16),
          Text('Description: ${widget.task.attributes.description}'),
          const SizedBox(height: 16),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 40),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditTaskPage(task: widget.task),
                    ),
                  );
                },
                child: const Text(
                  'Edit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 40),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white),
                onPressed: () {
                  //show dialog confirmation delete
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Confirmation'),
                          content:
                              Text('Are you sure want to delete this task?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('No'),
                            ),
                            TextButton(
                              onPressed: () async {
                                await TaskRemoteDatasource()
                                    .deleteTask(widget.task.id);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                );
                              },
                              child: Text('Yes'),
                            ),
                          ],
                        );
                      });
                  Navigator.pop(context);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
