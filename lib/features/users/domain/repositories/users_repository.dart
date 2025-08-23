import '../../../users/data/models/create_user_dto.dart';
import '../../../users/data/models/user_dto.dart';

abstract interface class UsersRepository {
  Future<List<UserDto>> findAll();
  Future<UserDto> createUser(CreateUserDto dto);
  Future<void> deleteUser(String userId);
}
