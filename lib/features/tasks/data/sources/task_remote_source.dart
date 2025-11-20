import 'package:dio/dio.dart';
import '../models/create_task_dto.dart';
import '../models/task_dto.dart';

class TaskRemoteSource {
  final Dio dio;

  TaskRemoteSource(this.dio);

  Future<void> createTask(CreateTaskDto dto) async {
    await dio.post('/tasks', data: dto.toJson());
  }

  Future<void> updateTask(String taskId, CreateTaskDto dto) async {
    await dio.put('/tasks/$taskId', data: dto.toJson());
  }

  Future<void> deleteTask(String taskId) async {
    await dio.delete('/tasks/$taskId');
  }

  Future<List<TaskDto>> getAllTasks() async {
    final response = await dio.get('/tasks');
    final data = response.data as List;
    return data.map((e) => TaskDto.fromJson(e)).toList();
  }

  Future<TaskDto> getTaskById(String id) async {
    final response = await dio.get('/tasks/$id');
    return TaskDto.fromJson(response.data);
  }
}
