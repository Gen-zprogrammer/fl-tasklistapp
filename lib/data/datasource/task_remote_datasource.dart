import "package:fl_tasklist_app/data/models/task_response_model.dart";
import "package:http/http.dart" as http;

class TaskRemoteDatasource {
  Future<TasksResponseModel> getTasks() async {
    final response = await http.get(
      Uri.parse('https://fic9.flutterdev.my.id/api/tasks'),
    );
    if (response.statusCode == 200) {
      return TasksResponseModel.fromJson(response.body);
    } else {
      throw Exception('Failed to load tasks');
    }
  }
}
