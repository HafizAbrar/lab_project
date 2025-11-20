import 'package:dio/dio.dart';
import '../models/create_answer_dto.dart';
import '../models/answer_dto.dart';

class AnswerRemoteSource {
  final Dio dio;

  AnswerRemoteSource(this.dio);

  Future<void> createAnswer(CreateAnswerDto dto) async {
    await dio.post('/answers', data: dto.toJson());
  }

  Future<List<AnswerDto>> getAnswersForQuestion(String questionId) async {
    final response = await dio.get('/answers/question/$questionId');
    return (response.data as List)
        .map((json) => AnswerDto.fromJson(json))
        .toList();
  }

  Future<void> deleteAnswer(String id) async {
    await dio.delete('/answers/$id');
  }

  Future<void> markAsAccepted(String id) async {
    await dio.patch('/answers/$id/accept');
  }

  Future<void> voteAnswer(String id, bool upvote) async {
    await dio.patch('/answers/$id/vote', data: {'upvote': upvote});
  }
}
