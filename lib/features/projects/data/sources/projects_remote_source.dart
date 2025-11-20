import 'package:dio/dio.dart';
import '../models/create_project_dto.dart';
import '../models/project_dto.dart';

class ProjectsRemoteSource {
  final Dio dio;

  ProjectsRemoteSource(this.dio);

  // ✅ Create Project (multipart/form-data)
  Future<ProjectDto?> createProject(CreateProjectDto dto) async {
    try {
      // Convert DTO to FormData (including images)
      final formData = await dto.toFormData();

      final response = await dio.post(
        '/projects',
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      // Optional: check if API response indicates failure
      if (response.statusCode == 200) {
        return ProjectDto.fromJson(response.data);
      } else {
        // Handle unexpected status codes
        throw Exception(
            'Server returned status code ${response.statusCode}');
      }
    } on DioError catch (dioError) {
      // Handle Dio-specific errors
      String? message = 'Unknown Dio error';
      if (dioError.response != null && dioError.response?.data != null) {
        message = dioError.response?.data['message'] ??
            dioError.response?.statusMessage ??
            message;
      } else if (dioError.message!.isNotEmpty) {
        message = dioError.message;
      }
      print('❌ Dio error while creating project: $message');
      throw Exception(message);
    } catch (e) {
      // Catch-all for other errors
      print('❌ Unexpected error while creating project: $e');
      throw Exception('Unexpected error: $e');
    }
  }


  // ✅ Get all projects
  Future<List<ProjectDto>> getAllProjects() async {
    try {
      final response = await dio.get('/projects');
      final data = response.data is List ? response.data : response.data['data'];
      return (data as List).map((e) => ProjectDto.fromJson(e)).toList();
    } catch (e) {
      print('❌ Dio error while fetching projects: $e');
      rethrow;
    }
  }

  // ✅ Update Project (with image & formData support)
  Future<ProjectDto> updateProject(String id, CreateProjectDto dto) async {
    try {
      final formData = await dto.toFormData();

      final response = await dio.post(
        '/projects/$id?_method=PUT', // For Laravel-style update routes
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      return ProjectDto.fromJson(response.data);
    } catch (e) {
      print('❌ Dio error while updating project: $e');
      rethrow;
    }
  }

  // ✅ Delete Project
  Future<void> deleteProject(String id) async {
    try {
      await dio.delete('/projects/$id');
    } catch (e) {
      print('❌ Dio error while deleting project: $e');
      rethrow;
    }
  }
}
