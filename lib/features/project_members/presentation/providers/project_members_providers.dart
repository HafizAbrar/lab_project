import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab_app/features/roles/presentation/providers/roles_providers.dart';


import '../../data/repositories/project_members_repository_impl.dart';
import '../../data/sources/project_member_remote_source.dart';
import '../../domain/repositories/project_members_repository.dart';

// Remote Source Provider
final projectMemberRemoteSourceProvider = Provider<ProjectMemberRemoteSource>(
      (ref) => ProjectMemberRemoteSource(ref.read(dioProvider)),
);

// Repository Provider
final projectMembersRepositoryProvider = Provider<ProjectMembersRepository>(
      (ref) => ProjectMembersRepositoryImpl(
    ProjectMemberRemoteSource(ref.read(dioProvider)),
  ),
);
