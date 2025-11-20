import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/repositories/answers_repository_impl.dart';
import '../../data/sources/answer_remote_source.dart';
import '../../domain/repositories/answers_repository.dart';

// Remote Source Provider
final answerRemoteSourceProvider = Provider<AnswerRemoteSource>(
      (ref) => AnswerRemoteSource(ref.read(dioProvider)),
);

// Repository Provider
final answersRepositoryProvider = Provider<AnswersRepository>(
      (ref) => AnswersRepositoryImpl(
    AnswerRemoteSource(ref.read(dioProvider)),
  ),
);

