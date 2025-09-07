import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/create_role_dto.dart';
import '../../data/models/update_role_dto.dart';
import '../../data/models/role_dto.dart';
import '../providers/roles_providers.dart';

class CreateRoleScreen extends ConsumerStatefulWidget {
  final RoleDto? existingRole; // 👈 null = create, not null = update

  const CreateRoleScreen({super.key, this.existingRole});

  @override
  ConsumerState<CreateRoleScreen> createState() => _CreateRoleScreenState();
}

class _CreateRoleScreenState extends ConsumerState<CreateRoleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();

    // Prefill fields if updating
    if (widget.existingRole != null) {
      _nameController.text = widget.existingRole!.name;
      _descriptionController.text = widget.existingRole!.description;
    }
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      if (widget.existingRole == null) {
        // CREATE
        final dto = CreateRoleDto(
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
        );

        final role = await ref.read(rolesRepositoryProvider).createRole(dto);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Role "${role.name}" created successfully!')),
          );
          Navigator.pop(context, role);
        }
      } else {
        // UPDATE
        final dto = UpdateRoleDto(
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
        );

        final updatedRole = await ref
            .read(rolesRepositoryProvider)
            .updateRole(widget.existingRole!.id, dto);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Role "${updatedRole.name}" updated successfully!')),
          );
          Navigator.pop(context, updatedRole);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Operation failed: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUpdate = widget.existingRole != null;

    return Scaffold(
      appBar: AppBar(title: Text(isUpdate ? 'Update Role' : 'Create Role')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Role Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Please enter a role name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Please enter a description' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submit,
                  child: _isSubmitting
                      ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                      : Text(isUpdate ? 'Update Role' : 'Create Role'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
