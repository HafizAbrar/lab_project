import 'package:dio/dio.dart';
import '../models/create_task_comment_dto.dart';
import '../models/task_comment_dto.dart';

class TaskCommentRemoteSource {
  final Dio dio;

  TaskCommentRemoteSource(this.dio);

  Future<void> createTaskComment(CreateTaskCommentDto dto) async {
    await dio.post('/task_comments', data: dto.toJson());
  }

  Future<void> updateTaskComment(String commentId, CreateTaskCommentDto dto) async {
    await dio.put('/task_comments/$commentId', data: dto.toJson());
  }

  Future<void> deleteTaskComment(String commentId) async {
    await dio.delete('/task_comments/$commentId');
  }

  Future<List<TaskCommentDto>> getCommentsByTaskId(String taskId) async {
    final response = await dio.get('/task_comments/task/$taskId');
    final data = response.data as List;
    return data.map((e) => TaskCommentDto.fromJson(e)).toList();
  }

  Future<TaskCommentDto> getTaskCommentById(String id) async {
    final response = await dio.get('/task_comments/$id');
    return TaskCommentDto.fromJson(response.data);
  }
}
