import '../../domain/repositories/permission_repository.dart';
import '../modals/permission_dto.dart';
import '../sources/permission_remote_source.dart';

class PermissionsRepositoryImpl implements PermissionsRepository {
  final PermissionsRemoteSource _remoteSource;

  PermissionsRepositoryImpl(this._remoteSource);

  @override
  Future<List<PermissionDto>> getPermissions() {
    return _remoteSource.getPermissions();
  }
}
