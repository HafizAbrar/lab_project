import '../../domain/repositories/tasks_repository.dart';
import '../models/create_task_dto.dart';
import '../models/task_dto.dart';
import '../sources/task_remote_source.dart';

class TasksRepositoryImpl implements TasksRepository {
  final TaskRemoteSource remoteSource;

  TasksRepositoryImpl(this.remoteSource);

  @override
  Future<void> createTask(CreateTaskDto dto) {
    return remoteSource.createTask(dto);
  }

  @override
  Future<void> updateTask(String taskId, CreateTaskDto dto) {
    return remoteSource.updateTask(taskId, dto);
  }

  @override
  Future<void> deleteTask(String taskId) {
    return remoteSource.deleteTask(taskId);
  }

  @override
  Future<List<TaskDto>> getAllTasks() {
    return remoteSource.getAllTasks();
  }

  @override
  Future<TaskDto> getTaskById(String id) {
    return remoteSource.getTaskById(id);
  }
}
