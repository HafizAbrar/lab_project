import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_providers.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authStateProvider);
    final error = auth is AsyncError ? auth.error.toString() : null;

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Card(
            margin: const EdgeInsets.all(24),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Admin Login',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator:
                          (v) => (v == null || v.isEmpty) ? 'Required' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: passCtrl,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password'),
                      validator:
                          (v) =>
                              (v == null || v.length < 6)
                                  ? 'Min 6 chars'
                                  : null,
                    ),
                    const SizedBox(height: 16),
                    if (error != null)
                      Text(error, style: const TextStyle(color: Colors.red)),
                    const SizedBox(height: 8),
                    FilledButton(
                      onPressed:
                          loading
                              ? null
                              : () async {
                                if (_formKey.currentState!.validate()) {
                                  if (mounted) setState(() => loading = true);

                                  try {
                                    await ref
                                        .read(authStateProvider.notifier)
                                        .login(
                                          emailCtrl.text.trim(),
                                          passCtrl.text,
                                        );

                                    // Navigate to admin dashboard after successful login
                                    if (mounted) {
                                      context.go('/admin');
                                    }
                                  } catch (e) {
                                    // Error is already handled by the auth provider
                                    // The error will show via the auth state watcher above
                                  } finally {
                                    if (mounted) {
                                      setState(() => loading = false);
                                    }
                                  }
                                }
                              },
                      child:
                          loading
                              ? const CircularProgressIndicator()
                              : const Text('Sign In'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }
}
