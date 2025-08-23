import 'package:lab_app/features/users/data/models/create_user_dto.dart';
import 'package:lab_app/features/users/data/models/user_dto.dart';
import 'package:lab_app/features/users/data/sources/users_remote_source.dart';
import 'package:lab_app/features/users/domain/repositories/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  UsersRepositoryImpl(this._remote);
  final UsersRemoteSource _remote;

  @override
  Future<List<UserDto>> findAll() => _remote.findAll();

  @override
  Future<UserDto> createUser(CreateUserDto dto) => _remote.createUser(dto);
  @override
  Future<void> deleteUser(String userId) => _remote.deleteUser(userId);
}
