import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../../features/EmployeeProfile/data/models/employee_profile_dto.dart'
as employee_profile;
import '../../features/users/data/models/user_dto.dart' as users;

//port '../../features/EmployeeProfile/data/models/employee_profile_dto.dart';
import '../../features/EmployeeProfile/presentation/pages/employee_profiles_page.dart';
import '../../features/EmployeeProfile/presentation/pages/employees_list_page.dart';
import '../../features/EmployeeProfile/presentation/pages/manage_employees_page.dart';
import '../../features/EmployeeProfile/presentation/pages/profile_page.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/splash_gate.dart';
import '../../features/admin/presentation/pages/admin_dashboard_page.dart';
import '../../features/roles/data/models/role_dto.dart';
import '../../features/roles/presentation/pages/create_role_page.dart';
import '../../features/roles/presentation/pages/roles_list_page.dart';
//port '../../features/users/data/models/user_dto.dart';
import '../../features/users/presentation/pages/features_screen.dart';
import '../../features/users/presentation/pages/userPermissions_page.dart';
import '../../features/users/presentation/pages/users_list_page.dart';
import '../../features/users/presentation/pages/createUser_page.dart';
import '../../features/users/presentation/pages/user_edit_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: GoRouterRefreshStream(
      // ✅ listen directly to auth state stream
      ref.watch(authStateProvider.notifier).stream.distinct(),
    ),
    routes: [
      GoRoute(path: '/splash', builder: (_, __) => const SplashGate()),
      GoRoute(path: '/login', builder: (_, __) => const LoginPage()),
      GoRoute(path: '/register', builder: (_, __) => const RegisterPage()),
      GoRoute(path: '/admin', builder: (_, __) => const AdminDashboardPage()),
      GoRoute(path: '/roles', builder: (_, __) => const RolesListPage()),
      GoRoute(
        path: '/roles/create',
        builder: (context, state) => const CreateRoleScreen(),
      ),
      GoRoute(
        path: '/roles/edit',
        builder: (context, state) {
          final role = state.extra as RoleDto;
          return CreateRoleScreen(existingRole: role);
        },
      ),

      GoRoute(path: '/users', builder: (_, __) => const UsersListPage()),
      GoRoute(path: '/users/create', builder: (_, __) => const UserFormPage()),
      GoRoute(
        path: '/users/:id/edit',
        builder: (context, state) {
          final userId = state.pathParameters['id']!;
          final user = state.extra as users.UserDto?;
          return EditUserPage(userId: userId, user: user);
        },
      ),
      GoRoute(
        path: '/users/:id/permissions',
        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>;
          final user = extras['user'] as users.UserDto; // ✅ CORRECT
          final mode = extras['mode'] as PermissionMode;
          return UserPermissionsScreen(userId: user.id, mode: mode);
        },
      ),
      GoRoute(
        path: '/users/available-features',
        builder: (context, state) => const FeaturesScreen(),
      ),
      // ✅ Employees
      GoRoute(path: '/employees', builder: (_, __) => const EmployeesListPage()),
      GoRoute(path: '/employees/manage', builder: (_, __) => const ManageEmployeesScreen()),
      // ✅get Employee Profiles
      GoRoute(
        path: '/employees/profiles',
        builder: (_, __) => const EmployeeProfilesListScreen(),
      ),
      // ✅ create Employee Profile
      GoRoute(
        path: '/employees/:employeeId/create-profile',
        builder: (context, state) {
          final employeeId = state.pathParameters['employeeId']!;
          return EmployeeProfileScreen(employeeId: employeeId);
        },
      ),
      // ✅ Update Employee Profile
      GoRoute(
        path: '/employees/:employeeId/profiles/:profileId/edit',
        builder: (context, state) {
          final employeeId = state.pathParameters['employeeId']!;
          /// ✅ Expect EmployeeProfileDto from extra
          final profile = state.extra as employee_profile.EmployeeProfileDto;

          return EmployeeProfileScreen(
            employeeId: employeeId,
            profile: profile, // ✅ Correct: send DTO object
          );
        },
      ),
    ],
    redirect: (ctx, state) {
      final user = auth.valueOrNull;

      final loggingIn = state.matchedLocation == '/login';
      final registering = state.matchedLocation == '/register';
      final atSplash = state.matchedLocation == '/splash';
      final atUsers = state.matchedLocation.startsWith('/users');
      final atAdmin = state.matchedLocation.startsWith('/admin');

      if (atSplash) return null;

      if (user != null && (loggingIn || registering)) {
        return state.matchedLocation == '/admin' ? null : '/admin';
      }

      if (user == null && !loggingIn && !registering) {
        return state.matchedLocation == '/login' ? null : '/login';
      }

      if (user != null && !user.isAdmin && (atAdmin || atUsers)) {
        return state.matchedLocation == '/login' ? null : '/login';
      }

      return null;
    },
  );
});

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListener = () => notifyListeners();
    _sub = stream.asBroadcastStream().listen((_) => notifyListener());
  }
  late final VoidCallback notifyListener;
  late final StreamSubscription _sub;

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
