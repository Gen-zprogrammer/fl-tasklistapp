import 'package:fl_tasklist_app/data/datasource/task_remote_datasource.dart';
import 'package:fl_tasklist_app/data/models/task_response_model.dart';
import 'package:fl_tasklist_app/pages/add_task_page.dart';
import 'package:fl_tasklist_app/pages/detail_task_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoaded = false;

  List<Task> tasks = [];

  Future<void> getTasks() async {
    setState(() {
      isLoaded = true;
    });
      try {
    final model = await TaskRemoteDatasource().getTasks();
    tasks = model.data;
  } catch (e) {
    print('ERROR DI getTask $e');
  }
    setState(() {
      isLoaded = false;
    });
  }

  @override
  void initState() {
    getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Task List',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 2,
        backgroundColor: Colors.blue,
      ),
      body: isLoaded
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailTaskPage(task: tasks[index]),
                      ),
                    );
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(tasks[index].attributes.title),
                      subtitle: Text(tasks[index].attributes.description),
                      trailing: const Icon(Icons.check_circle),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTaskPage(),
            ),
          );
          getTasks();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
