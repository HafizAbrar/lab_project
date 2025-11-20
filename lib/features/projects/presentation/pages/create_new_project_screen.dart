import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../clients/presentation/providers/clients_provider.dart';
import '../../data/models/create_project_dto.dart';
import '../providers/projects_providers.dart';

class CreateNewProjectScreen extends ConsumerStatefulWidget {
  const CreateNewProjectScreen({super.key});

  @override
  ConsumerState<CreateNewProjectScreen> createState() =>
      _CreateNewProjectScreenState();
}

class _CreateNewProjectScreenState
    extends ConsumerState<CreateNewProjectScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _budgetController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  String _status = 'in_progress';
  List<File> _selectedImages = [];
  String? _selectedClientId;

  final ImagePicker _picker = ImagePicker();
  bool _isSubmitting = false;

  // -----------------------------------------------------
// PICK MULTIPLE IMAGES
// -----------------------------------------------------
  Future<void> _pickImages() async {
    try {
      // Pick multiple images from device gallery
      final pickedFiles = await _picker.pickMultiImage(
        imageQuality: 80, // optional: compress images
        maxWidth: 1024,   // optional: resize
        maxHeight: 1024,
      );

      if (pickedFiles == null || pickedFiles.isEmpty) return;

      setState(() {
        // Convert XFile to File
        _selectedImages.addAll(pickedFiles.map((xfile) => File(xfile.path)));
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Failed to pick images: $e")),
      );
    }
  }


  // -----------------------------------------------------
  // DATE SELECTOR
  // -----------------------------------------------------
  Future<void> _selectDate(bool isStart) async {
    try {
      final picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2035),
      );

      if (picked == null) return;

      setState(() {
        if (isStart) {
          _startDate = picked;

          if (_endDate != null && _endDate!.isBefore(_startDate!)) {
            _endDate = null;
          }
        } else {
          if (_startDate == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Select start date first")),
            );
            return;
          }

          if (picked.isBefore(_startDate!)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("End date cannot be before start date")),
            );
            return;
          }

          _endDate = picked;
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Could not select date: $e")),
      );
    }
  }

  // -----------------------------------------------------
  // SUBMIT PROJECT (CORRECTED SUCCESS/ERROR HANDLING)
  // -----------------------------------------------------
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedClientId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a client")),
      );
      return;
    }

    if (_startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a start date")),
      );
      return;
    }

    if (_endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an end date")),
      );
      return;
    }

    final dto = CreateProjectDto(
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      startDate: DateFormat("yyyy-MM-dd").format(_startDate!),
      endDate: DateFormat("yyyy-MM-dd").format(_endDate!),
      status: _status,
      budget: double.tryParse(_budgetController.text.trim()) ?? 0.0,
      images: _selectedImages,
    );

    setState(() => _isSubmitting = true);

    try {
      final result =
      await ref.read(projectsProvider.notifier).createProject(dto);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Project created successfully!")),
      );

      Navigator.pop(context, true);

    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Error creating project: $error")),
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  // -----------------------------------------------------
  // UI
  // -----------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final clientsAsync = ref.watch(clientsListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Create New Project")),
      body: clientsAsync.when(
        data: (clients) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Select Client"),
                    value: _selectedClientId,
                    items: clients.map((client) {
                      return DropdownMenuItem(
                        value: client.id,
                        child: Text(client.fullName),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _selectedClientId = val),
                    validator: (val) => val == null ? "Please select a client" : null,
                  ),

                  const SizedBox(height: 12),

                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: "Project Name"),
                    validator: (val) =>
                    val == null || val.isEmpty ? "Enter project name" : null,
                  ),

                  const SizedBox(height: 12),

                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 3,
                    decoration: const InputDecoration(labelText: "Description"),
                    validator: (val) => val == null || val.isEmpty
                        ? "Enter project description"
                        : null,
                  ),

                  const SizedBox(height: 12),

                  TextFormField(
                    controller: _budgetController,
                    decoration:
                    const InputDecoration(labelText: "Budget (optional)"),
                    keyboardType: TextInputType.number,
                  ),

                  const SizedBox(height: 12),

                  _dateTile(
                    label: "Start Date",
                    value: _startDate,
                    onTap: () => _selectDate(true),
                  ),
                  _dateTile(
                    label: "End Date",
                    value: _endDate,
                    onTap: () => _selectDate(false),
                  ),

                  const SizedBox(height: 12),

                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Status"),
                    value: _status,
                    items: const [
                      DropdownMenuItem(value: 'pending', child: Text("pending")),
                      DropdownMenuItem(
                          value: 'in_progress', child: Text("in_progress")),
                      DropdownMenuItem(value: 'on_hold', child: Text("on_hold")),
                      DropdownMenuItem(
                          value: 'completed', child: Text("completed")),
                      DropdownMenuItem(
                          value: 'cancelled', child: Text("cancelled")),
                      DropdownMenuItem(
                          value: 'archived', child: Text("archived")),
                    ],
                    onChanged: (v) => setState(() => _status = v!),
                  ),

                  const SizedBox(height: 12),

                  ElevatedButton.icon(
                    onPressed: _pickImages,
                    icon: const Icon(Icons.photo),
                    label: const Text("Pick Images"),
                  ),

                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _selectedImages
                        .map((img) => Stack(
                      children: [
                        Image.file(
                          img,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() => _selectedImages.remove(img));
                            },
                            child: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ))
                        .toList(),
                  ),

                  const SizedBox(height: 24),

                  _isSubmitting
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)),
                    child: const Text("Create Project"),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () =>
        const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text("Error: $err")),
      ),
    );
  }

  Widget _dateTile({
    required String label,
    required DateTime? value,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        "$label: ${value != null ? DateFormat('yyyy-MM-dd').format(value) : 'Select'}",
      ),
      trailing: const Icon(Icons.calendar_today),
      onTap: onTap,
    );
  }
}
