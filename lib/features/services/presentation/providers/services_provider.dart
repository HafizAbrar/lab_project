import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/models/create_service_dto.dart';
import '../../data/models/service_dto.dart';
import '../../data/repositories/services_repository_impl.dart';
import '../../data/sources/services_remote_source.dart';
import '../../domain/repositories/services_repository.dart';

// Remote Source Provider
final servicesRemoteSourceProvider = Provider<ServicesRemoteSource>(
      (ref) => ServicesRemoteSource(ref.read(dioProvider)),
);

// Repository Provider
final servicesRepositoryProvider = Provider<ServicesRepository>(
      (ref) => ServicesRepositoryImpl(
    ServicesRemoteSource(ref.read(dioProvider)),
  ),
);

// Example: You can add providers for CRUD operations or state if needed
// final servicesListProvider = FutureProvider<List<ServiceDto>>((ref) async {
//   final repo = ref.watch(servicesRepositoryProvider);
//   return repo.getAllServices();
// });
