import '../../data/models/create_task_dto.dart';
import '../../data/models/task_dto.dart';

abstract class TasksRepository {
  Future<void> createTask(CreateTaskDto dto);
  Future<void> updateTask(String taskId, CreateTaskDto dto);
  Future<void> deleteTask(String taskId);
  Future<List<TaskDto>> getAllTasks();
  Future<TaskDto> getTaskById(String id);
}
