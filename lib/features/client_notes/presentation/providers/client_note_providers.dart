import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/sources/client_note_remote_source.dart';
import '../../data/repositories/client_notes_repository_impl.dart';
import '../../domain/repositories/client_notes_repository.dart';

// Remote Source Provider
final clientNoteRemoteSourceProvider = Provider<ClientNoteRemoteSource>(
      (ref) => ClientNoteRemoteSource(ref.read(dioProvider)),
);

// Repository Provider
final clientNotesRepositoryProvider = Provider<ClientNotesRepository>(
      (ref) => ClientNotesRepositoryImpl(ref.read(clientNoteRemoteSourceProvider)),
);
