import '../../data/models/create_answer_dto.dart';
import '../../data/models/answer_dto.dart';

abstract class AnswersRepository {
  Future<void> createAnswer(CreateAnswerDto dto);
  Future<List<AnswerDto>> getAnswersForQuestion(String questionId);
  Future<void> deleteAnswer(String id);
  Future<void> markAsAccepted(String id);
  Future<void> voteAnswer(String id, bool upvote);
}
