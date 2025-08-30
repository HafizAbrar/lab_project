import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab_app/features/users/presentation/pages/user_edit_page.dart';
import 'dart:async';
import '../../features/auth/data/models/user_dto.dart' as auth_models;
import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/splash_gate.dart';
import '../../features/admin/presentation/pages/admin_dashboard_page.dart';
import '../../features/roles/presentation/pages/roles_list_page.dart';
import '../../features/users/data/models/user_dto.dart';
import '../../features/users/presentation/pages/userPermissions_page.dart';
import '../../features/users/presentation/pages/users_list_page.dart';
import '../../features/users/presentation/pages/createUser_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: GoRouterRefreshStream(
      ref.watch(authStateProvider.notifier).stream,
    ),
    routes: [
      GoRoute(path: '/splash', builder: (_, __) => const SplashGate()),
      GoRoute(path: '/login', builder: (_, __) => const LoginPage()),
      GoRoute(path: '/register', builder: (_, __) => const RegisterPage()),
      GoRoute(path: '/admin', builder: (_, __) => const AdminDashboardPage()),
      GoRoute(
      path: '/users',
      builder: (context, state) => const UsersListPage(),
    ),
    GoRoute(
      path: '/users/create',
      builder: (context, state) => const UserFormPage(),
    ),
      GoRoute(
        path: '/users/:id/edit',
        builder: (context, state) {
          final userId = state.pathParameters['id']!;
          // Option A: If you pass full user via extra:
          final user = state.extra as UserDto?;
          return EditUserPage(userId: userId, user: user);
        },
      ),
      GoRoute(
        path: '/roles',
        builder: (context, state) => const RolesListPage(),
      ),
      GoRoute(
        path: '/users/:id/permissions',
        builder: (context, state) {
          final userId = state.pathParameters['id']!;
          return UserPermissionsScreen(userId: userId);
        },
      ),

    ],
    redirect: (ctx, state) {
      final user = auth.valueOrNull;
      final loggingIn = state.matchedLocation == '/login';
      final registering = state.matchedLocation == '/register';
      final atSplash = state.matchedLocation == '/splash';
      final atUsers = state.matchedLocation.startsWith('/users');

      // Let splash handle its own navigation to login
      if (atSplash) return null;

      // If user is authenticated and trying to access login/register, redirect to admin
      if (user != null && (loggingIn || registering)) return '/admin';

      // If user is not authenticated and not at login/register, redirect to login
      if (user == null && !loggingIn && !registering) return '/login';

      // If user is authenticated but not admin and trying to access admin routes
      if (user != null &&
          !user.isAdmin &&
          (state.matchedLocation.startsWith('/admin') || atUsers)) {
        return '/login';
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
