import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

// Employee
import '../../features/EmployeeProfile/data/models/employee_profile_dto.dart'
as employee_profile;
import '../../features/EmployeeProfile/presentation/pages/profile_page.dart';
import '../../features/EmployeeProfile/presentation/pages/employee_profiles_list_page.dart';
import '../../features/EmployeeProfile/presentation/pages/employees_list_page.dart';
import '../../features/EmployeeProfile/presentation/pages/manage_employees_page.dart';
import '../../features/EmployeeProfile/presentation/pages/create&update_profile_page.dart';

// Roles
import '../../features/categories/presentation/pages/categories_list_screen.dart';
import '../../features/categories/presentation/pages/create_category_screen.dart';
import '../../features/clients/presentation/pages/client_profile_page.dart';
import '../../features/clients/presentation/pages/clients-list_page.dart';
import '../../features/clients/presentation/pages/create&update_profile_page.dart';
import '../../features/clients/presentation/pages/manage_clients_page.dart';
import '../../features/clients/presentation/pages/profiles_list_page.dart';
import '../../features/employeeSkills/presentation/pages/create_employee_skill_screen.dart';
import '../../features/employeeSkills/presentation/pages/employee_skills_list_screen.dart';
import '../../features/projects/presentation/pages/all_projects_screen.dart';
import '../../features/projects/presentation/pages/create_new_project_screen.dart';
import '../../features/roles/presentation/pages/update_permission_page.dart';
import '../../features/roles/presentation/pages/view_permissions_page.dart';
import '../../features/roles/data/models/role_dto.dart';
import '../../features/roles/presentation/pages/create_role_page.dart';
import '../../features/roles/presentation/pages/roles_list_page.dart';

// Skills
import '../../features/skills/presentation/pages/skills_list_page.dart';

// Users
import '../../features/users/data/models/user_dto.dart' as users;
import '../../features/users/presentation/pages/features_screen.dart';
import '../../features/users/presentation/pages/userPermissions_page.dart';
import '../../features/users/presentation/pages/users_list_page.dart';
import '../../features/users/presentation/pages/createUser_page.dart';
import '../../features/users/presentation/pages/user_edit_page.dart';

// Auth
import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/splash_gate.dart';

// Admin
import '../../features/admin/presentation/pages/admin_dashboard_page.dart';

// ✅ Clients
import '../../features/clients/data/models/client_profile_dto.dart';


final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: GoRouterRefreshStream(
      ref.watch(authStateProvider.notifier).stream.distinct(),
    ),
    routes: [
      GoRoute(path: '/splash', builder: (_, __) => const SplashGate()),
      GoRoute(path: '/login', builder: (_, __) => const LoginPage()),
      GoRoute(path: '/register', builder: (_, __) => const RegisterPage()),
      GoRoute(path: '/admin', builder: (_, __) => const AdminDashboardPage()),

      // ✅ Roles
      GoRoute(path: '/roles', builder: (_, __) => const RolesListPage()),
      GoRoute(path: '/roles/create', builder: (_, __) => const CreateRoleScreen()),
      GoRoute(
        path: '/roles/edit',
        builder: (context, state) {
          final role = state.extra as RoleDto;
          return CreateRoleScreen(existingRole: role);
        },
      ),
      GoRoute(
        path: '/roles/permissions/view',
        builder: (context, state) {
          final roleId = state.extra as String;
          return ViewPermissionsPage(roleId: roleId);
        },
      ),
      GoRoute(
        path: '/roles/:roleId/update-permissions',
        name: 'updateRolePermissions',
        builder: (context, state) {
          final roleId = state.pathParameters['roleId']!;
          return UpdatePermissionsPage(roleId: roleId);
        },
      ),

      // ✅ Users
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
          final user = extras['user'] as users.UserDto;
          final mode = extras['mode'] as PermissionMode;
          return UserPermissionsScreen(userId: user.id, mode: mode);
        },
      ),
      GoRoute(path: '/users/available-features', builder: (_, __) => const FeaturesScreen()),

      // ✅ Employees
      GoRoute(path: '/employees', builder: (_, __) => const EmployeesListPage()),
      GoRoute(path: '/employees/manage', builder: (_, __) => const ManageEmployeesScreen()),
      GoRoute(path: '/employees/profiles', builder: (_, __) => const EmployeeProfilesListScreen()),
      GoRoute(
        path: '/employees/profiles/:id',
        builder: (context, state) {
          final profileId = state.pathParameters['id']!;
          return EmployeeProfileDetailScreen(profileId: profileId);
        },
      ),
      GoRoute(
        path: '/employees/:employeeId/create-profile',
        builder: (context, state) {
          final employeeId = state.pathParameters['employeeId']!;
          return EmployeeProfileScreen(employeeId: employeeId);
        },
      ),
      GoRoute(
        path: '/employees/:employeeId/profiles/:profileId/edit',
        builder: (context, state) {
          final employeeId = state.pathParameters['employeeId']!;
          final profile = state.extra as employee_profile.EmployeeProfileDto;
          return EmployeeProfileScreen(employeeId: employeeId, profile: profile);
        },
      ),
      //create employee skill
      GoRoute(
        path: '/employee-skills/:employeeId/create',
        name: 'createEmployeeSkill',
        builder: (context, state) {
          final employeeId = state.pathParameters['employeeId']!;
          return CreateEmployeeSkillScreen(employeeId: employeeId);
        },
      ),
      //get skill of an employee
      GoRoute(
        path: '/employee-skills',
        builder: (context, state) {
          final extra = state.extra as Map?;
          final employeeId = extra?['employeeId'] ?? '';
          final profileId = extra?['profileId'] ?? '';
          final profileImageUrl = extra?['profileImageUrl'] ?? '';

          return EmployeeSkillsScreen(
            employeeId: employeeId,
            profileId: profileId,
            profileImageUrl: profileImageUrl,
          );
        },
      ),
      //update employee skill
      GoRoute(
        path: '/employee-skills/:employeeId/update/:skillId',
        name: 'updateEmployeeSkill',
        builder: (context, state) {
          final employeeId = state.pathParameters['employeeId']!;
          final skillId = state.pathParameters['skillId']!;
          final extra = state.extra as Map<String, dynamic>?; // from navigation
          final existingSkill = extra?['skill']; // EmployeeSkillDto or similar

          return CreateEmployeeSkillScreen(
            employeeId: employeeId,
            skillId: skillId,
            existingSkill: existingSkill, // prefill fields
            isEditing: true,
          );
        },
      ),
      // projects
      GoRoute(
        path: '/projects',
        builder: (context, state) => const AllProjectsScreen(),
      ),
      GoRoute(
        path: '/projects/create',
        builder: (context, state) => const CreateNewProjectScreen(),
      ),
      // ✅ Skills
      GoRoute(path: '/skills', builder: (_, __) => const SkillsScreen()),

      // ✅ Clients
      GoRoute(path: '/clients/manage', builder: (_, __) => const ManageClientsScreen()),
      GoRoute(path: '/clients', builder: (_, __) => const ClientsListPage()),
      GoRoute(path: '/clients/profiles', builder: (_, __) => const ClientProfilesListScreen()),
      GoRoute(
        path: '/clients/:clientId/create-profile',
        builder: (context, state) {
          final clientId = state.pathParameters['clientId']!;
          final extra = state.extra as Map<String, dynamic>?;

          final name = extra?['name'] as String? ?? "";
          final email = extra?['email'] as String? ?? "";

          return ClientProfileScreen(
            clientId: clientId,
            clientName: name,
            clientEmail: email,
          );
        },
      ),
      GoRoute(
        path: '/clients/profiles/:profileId/edit',
        builder: (context, state) {
          final profile = state.extra as ClientProfileDto;
          return ClientProfileScreen(clientId: profile.id, profile: profile);
        },
      ),
      GoRoute(
        path: '/clients/profiles/:profileId',
        builder: (context, state) {
          final profileId = state.pathParameters['profileId']!;
          return ClientProfileDetailScreen(profileId: profileId);
        },
      ),
      GoRoute(
        path: '/categories',
        name: 'categories',
        builder: (context, state) => const CategoriesListScreen(),
      ),
      GoRoute(
        path: '/categories/create',
        name: 'createCategory',
        builder: (context, state) => const CreateOrUpdateCategoryScreen(),
      ),
    ],

    // ✅ Redirect Logic
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
