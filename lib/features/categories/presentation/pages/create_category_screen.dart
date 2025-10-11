import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/category_dto.dart';
import '../../data/models/create_category_dto.dart';
import '../providers/categories_providers.dart';

class CreateOrUpdateCategoryScreen extends ConsumerStatefulWidget {
  final CategoryDto? category; // null => create, not null => update

  const CreateOrUpdateCategoryScreen({super.key, this.category});

  @override
  ConsumerState<CreateOrUpdateCategoryScreen> createState() =>
      _CreateOrUpdateCategoryScreenState();
}

class _CreateOrUpdateCategoryScreenState
    extends ConsumerState<CreateOrUpdateCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _slugController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    final category = widget.category;
    if (category != null) {
      _nameController.text = category.name;
      _slugController.text = category.slug;
      _descriptionController.text = category.description ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _slugController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final dto = CreateCategoryDto(
      name: _nameController.text.trim(),
      slug: _slugController.text.trim(),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
    );

    try {
      if (widget.category == null) {
        // ✅ CREATE MODE
        await ref.read(createCategoryProvider(dto).future);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Category created successfully!')),
          );
        }
      } else {
        // ✏️ UPDATE MODE
        await ref.read(updateCategoryProvider({
          'categoryId': widget.category!.id,
          'dto': dto,
        }).future);
        if (mounted) {
          ref.invalidate(getAllCategoriesProvider);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Category updated successfully!')),
          );
        }
      }

      if (mounted) Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.category != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Category' : 'Create Category'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter name' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _slugController,
                decoration: const InputDecoration(labelText: 'Slug'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter slug' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: Icon(isEditing ? Icons.update : Icons.save),
                label: Text(
                  _isSubmitting
                      ? (isEditing ? 'Updating...' : 'Creating...')
                      : (isEditing ? 'Update Category' : 'Create Category'),
                ),
                onPressed: _isSubmitting ? null : _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
