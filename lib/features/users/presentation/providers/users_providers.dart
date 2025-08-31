import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab_app/features/users/data/models/create_user_dto.dart';
import 'package:lab_app/features/users/data/models/user_dto.dart';
import 'package:lab_app/features/users/data/sources/users_remote_source.dart';
import 'package:lab_app/features/users/data/repositories/users_repository_impl.dart';
import 'package:lab_app/features/users/domain/repositories/users_repository.dart';

// <-- adjust import path to your actual dioProvider location
import 'package:lab_app/features/auth/presentation/providers/auth_providers.dart';

import '../../../permissions/data/modals/permission_dto.dart';
import '../../data/models/createUserWithPermission_dto.dart';
import '../../data/models/update_user_dto.dart';
import '../../data/models/user_permissions_dto.dart';

final usersRemoteProvider = Provider<UsersRemoteSource>((ref) {
  final dio = ref.watch(dioProvider); // same Dio with auth interceptor
  return UsersRemoteSource(dio);
});

final usersRepositoryProvider = Provider<UsersRepository>(
      (ref) => UsersRepositoryImpl(ref.watch(usersRemoteProvider)),
);

/// List all users with better error handling
final usersListProvider = FutureProvider<List<UserDto>>((ref) async {
  try {
    final authState = ref.watch(authStateProvider);

    if (authState.isLoading) {
      throw Exception('Authentication state is loading');
    }
    if (!authState.hasValue || authState.value == null) {
      throw Exception('User not authenticated');
    }

    final user = authState.value!;
    if (!user.isAdmin) {
      throw Exception('Insufficient permissions');
    }

    return await ref.watch(usersRepositoryProvider).findAll();
  } catch (e) {
    print('Error fetching users: $e');
    rethrow;
  }
});

/// Create user controller (basic create without permissions)
class CreateUserController extends StateNotifier<AsyncValue<UserDto?>> {
  CreateUserController(this._ref, this._repo)
      : super(const AsyncValue.data(null));

  final Ref _ref;
  final UsersRepository _repo;

  Future<void> submit(CreateUserDto dto) async {
    state = const AsyncValue.loading();
    try {
      final created = await _repo.createUser(dto);
      _ref.invalidate(usersListProvider);
      state = AsyncValue.data(created);
    } catch (e, st) {
      print('Error creating user: $e');
      state = AsyncValue.error(e, st);
    }
  }
}

final createUserControllerProvider =
StateNotifierProvider<CreateUserController, AsyncValue<UserDto?>>(
      (ref) => CreateUserController(ref, ref.watch(usersRepositoryProvider)),
);

/// All permissions provider
final allPermissionsProvider = FutureProvider<List<PermissionDto>>((ref) async {
  final repo = ref.watch(usersRepositoryProvider);
  return await repo.getAllPermissions();
});

/// Fetch permissions of a specific user
final userPermissionsProvider =
FutureProvider.family<UserPermissionsDto, String>((ref, userId) async {
  final repo = ref.watch(usersRepositoryProvider);
  final userPerms = await repo.getUserPermissions(userId);

  // 🚀 initialize selected permissions safely
  ref.read(selectedPermissionsProvider.notifier).setPermissions(
    (userPerms.permissions ?? []).map((p) => p.id).toSet(),
  );

  return userPerms;
});

/// Create user with permissions controller
class CreateUserWithPermissionsController
    extends StateNotifier<AsyncValue<UserDto?>> {
  CreateUserWithPermissionsController(this._ref, this._repo)
      : super(const AsyncValue.data(null));

  final Ref _ref;
  final UsersRepository _repo;

  Future<void> submit(CreateUserWithPermissionsDto dto) async {
    state = const AsyncValue.loading();
    try {
      final created = await _repo.createUserWithPermissions(dto);
      _ref.invalidate(usersListProvider);
      state = AsyncValue.data(created);
    } catch (e, st) {
      print('Error creating user with permissions: $e');
      state = AsyncValue.error(e, st);
    }
  }
}

final createUserWithPermissionsControllerProvider =
StateNotifierProvider<CreateUserWithPermissionsController,
    AsyncValue<UserDto?>>(
      (ref) => CreateUserWithPermissionsController(
      ref, ref.watch(usersRepositoryProvider)),
);

/// Delete user provider
final deleteUserProvider =
FutureProvider.family<void, String>((ref, userId) async {
  final repo = ref.watch(usersRepositoryProvider);
  await repo.deleteUser(userId);
  ref.invalidate(usersListProvider);
});

/// Update user
final updateUserProvider =
FutureProvider.family<UserDto, Map<String, dynamic>>((ref, params) async {
  final repo = ref.read(usersRepositoryProvider);
  final userId = params['id'] as String;
  final dto = params['data'] as UpdateUserDto;
  final updated = await repo.updateUser(userId, dto);

  ref.invalidate(usersListProvider);
  return updated;
});

class UpdateUserController extends StateNotifier<AsyncValue<UserDto?>> {
  UpdateUserController(this._ref, this._repo)
      : super(const AsyncValue.data(null));

  final Ref _ref;
  final UsersRepository _repo;

  Future<void> submit(String userId, UpdateUserDto dto) async {
    state = const AsyncValue.loading();
    try {
      final updated = await _repo.updateUser(userId, dto);
      _ref.invalidate(usersListProvider);
      state = AsyncValue.data(updated);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
/// Search query state for permissions
final searchQueryProvider = StateProvider<String>((ref) => "");

final updateUserControllerProvider =
StateNotifierProvider<UpdateUserController, AsyncValue<UserDto?>>(
      (ref) => UpdateUserController(ref, ref.watch(usersRepositoryProvider)),
);

/// Selected permissions state
class SelectedPermissionsNotifier extends StateNotifier<Set<String>> {
  SelectedPermissionsNotifier(super.initial);

  void togglePermission(String id) {
    if (state.contains(id)) {
      state = {...state}..remove(id); // uncheck
    } else {
      state = {...state}..add(id); // check
    }
  }

  void setPermissions(Set<String> ids) {
    state = ids;
  }
}

final selectedPermissionsProvider =
StateNotifierProvider<SelectedPermissionsNotifier, Set<String>>(
      (ref) => SelectedPermissionsNotifier({}),
);
