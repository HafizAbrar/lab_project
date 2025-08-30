
import '../../data/modals/permission_dto.dart';

abstract class PermissionsRepository {
  Future<List<PermissionDto>> getPermissions();
}
