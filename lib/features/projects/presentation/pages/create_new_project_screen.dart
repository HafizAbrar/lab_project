import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../clients/presentation/providers/clients_provider.dart';
import '../../data/models/create_project_dto.dart';
import '../../data/models/project_dto.dart';
import '../providers/projects_providers.dart';

class CreateNewProjectScreen extends ConsumerStatefulWidget {
  final ProjectDto? project; // NULL = create, NOT NULL = update

  const CreateNewProjectScreen({super.key, this.project});

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

  List<File> _selectedImages = []; // new images (File)
  List<String> _previousImages = []; // existing image URLs (String)

  String? _selectedClientId;

  final ImagePicker _picker = ImagePicker();
  bool _isSubmitting = false;

  bool get isEdit => widget.project != null;

  @override
  void initState() {
    super.initState();

    if (isEdit) {
      final p = widget.project!;
      print("Editing Project ID: ${p.id}");
      print("Name: ${p.name}");
      print("Description: ${p.description}");
      print("Start Date: ${p.startDate}");
      print("End Date: ${p.endDate}");
      print("Status: ${p.status}");
      print("Budget: ${p.budget}");
      print("Images: ${p.images}");
      print("Client ID: ${p.clientId}");

      _nameController.text = p.name;
      _descriptionController.text = p.description;
      _budgetController.text = p.budget.toString();

      _startDate = DateTime.tryParse(p.startDate);
      _endDate = DateTime.tryParse(p.endDate);

      _status = p.status;
      _previousImages = List<String>.from(p.images);

      _selectedClientId = p.clientId;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() {});
      });
    }
  }

  // -----------------------------------------------------
  // PICK MULTIPLE IMAGES
  // -----------------------------------------------------
  Future<void> _pickImages() async {
    try {
      final pickedFiles = await _picker.pickMultiImage(
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (pickedFiles == null || pickedFiles.isEmpty) return;

      setState(() {
        _selectedImages.addAll(pickedFiles.map((x) => File(x.path)));
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
        initialDate: _startDate ?? DateTime.now(),
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
  // SUBMIT PROJECT (CREATE + UPDATE)
  // -----------------------------------------------------
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (!isEdit && _selectedClientId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a client")),
      );
      return;
    }

    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select start and end dates")),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      if (isEdit) {
        // UPDATE MODE
        await ref.read(projectsProvider.notifier).updateProject(
          widget.project!.id,
          CreateProjectDto(
            name: _nameController.text.trim(),
            description: _descriptionController.text.trim(),
            startDate: DateFormat("yyyy-MM-dd").format(_startDate!),
            endDate: DateFormat("yyyy-MM-dd").format(_endDate!),
            status: _status,
            budget: double.tryParse(_budgetController.text.trim()) ?? 0.0,
            images: _selectedImages,
            clientId: _selectedClientId,
          ),
        );

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Project updated successfully!")),
        );
      } else {
        // CREATE MODE
        final dto = CreateProjectDto(
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          startDate: DateFormat("yyyy-MM-dd").format(_startDate!),
          endDate: DateFormat("yyyy-MM-dd").format(_endDate!),
          status: _status,
          budget: double.tryParse(_budgetController.text.trim()) ?? 0.0,
          images: _selectedImages,
          clientId: _selectedClientId,
        );

        await ref.read(projectsProvider.notifier).createProject(dto);

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Project created successfully!")),
        );
      }

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Error: $e")),
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
      appBar: AppBar(
        title: Text(isEdit ? "Update Project" : "Create New Project"),
      ),
      body: clientsAsync.when(
        data: (clients) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isEdit)
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: "Select Client"),
                      value: _selectedClientId,
                      items: clients.map((c) {
                        return DropdownMenuItem(
                          value: c.id,
                          child: Text(c.fullName),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _selectedClientId = val),
                      validator: (val) =>
                      val == null ? "Please select a client" : null,
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
                    decoration: const InputDecoration(labelText: "Budget"),
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

                  // ---------------- Images ----------------
                  ElevatedButton.icon(
                    onPressed: _pickImages,
                    icon: const Icon(Icons.photo),
                    label: Text(isEdit ? "Add More Images" : "Pick Images"),
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      // EXISTING IMAGES (network)
                      ..._previousImages.map((img) => Stack(
                        children: [
                          Image.network(img,
                              width: 80, height: 80, fit: BoxFit.cover),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: GestureDetector(
                              onTap: () => setState(
                                      () => _previousImages.remove(img)),
                              child:
                              const Icon(Icons.cancel, color: Colors.red),
                            ),
                          ),
                        ],
                      )),

                      // NEW IMAGES (file)
                      ..._selectedImages.map((img) => Stack(
                        children: [
                          Image.file(img,
                              width: 80, height: 80, fit: BoxFit.cover),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: GestureDetector(
                              onTap: () => setState(
                                      () => _selectedImages.remove(img)),
                              child:
                              const Icon(Icons.cancel, color: Colors.red),
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),

                  const SizedBox(height: 24),

                  _isSubmitting
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)),
                    child: Text(isEdit ? "Update Project" : "Create Project"),
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
