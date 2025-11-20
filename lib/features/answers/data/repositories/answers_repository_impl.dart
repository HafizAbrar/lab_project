import '../../domain/repositories/answers_repository.dart';
import '../models/create_answer_dto.dart';
import '../models/answer_dto.dart';
import '../sources/answer_remote_source.dart';

class AnswersRepositoryImpl implements AnswersRepository {
  final AnswerRemoteSource remoteSource;

  AnswersRepositoryImpl(this.remoteSource);

  @override
  Future<void> createAnswer(CreateAnswerDto dto) {
    return remoteSource.createAnswer(dto);
  }

  @override
  Future<List<AnswerDto>> getAnswersForQuestion(String questionId) {
    return remoteSource.getAnswersForQuestion(questionId);
  }

  @override
  Future<void> deleteAnswer(String id) {
    return remoteSource.deleteAnswer(id);
  }

  @override
  Future<void> markAsAccepted(String id) {
    return remoteSource.markAsAccepted(id);
  }

  @override
  Future<void> voteAnswer(String id, bool upvote) {
    return remoteSource.voteAnswer(id, upvote);
  }
}
