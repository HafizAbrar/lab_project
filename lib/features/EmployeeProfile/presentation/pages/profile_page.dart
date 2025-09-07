import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../../data/models/create_employee_profile_dto.dart';
import '../../data/models/update_employee_profile_dto.dart';
import '../../data/models/employee_profile_dto.dart';
import '../providers/employeeProfile_providers.dart';

class EmployeeProfileScreen extends ConsumerStatefulWidget {
  final String employeeId;
  final EmployeeProfileDto? profile; // 👈 if null → create, else update

  const EmployeeProfileScreen({
    super.key,
    required this.employeeId,
    this.profile,
  });

  bool get isEditing => profile != null;

  @override
  ConsumerState<EmployeeProfileScreen> createState() =>
      _EmployeeProfileScreenState();
}

class _EmployeeProfileScreenState extends ConsumerState<EmployeeProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _jobTitleController = TextEditingController();
  final _departmentController = TextEditingController();
  final _hireDateController = TextEditingController();

  final List<String> _statuses = [
    "active",
    "inactive",
    "on_leave",
    "terminated"
  ];
  String? _selectedStatus = "active";
  File? _pickedImage;

  @override
  void initState() {
    super.initState();

    // 👇 Pre-fill fields if editing
    if (widget.isEditing) {
      final profile = widget.profile!;
      _jobTitleController.text = profile.jobTitle ?? "";
      _departmentController.text = profile.department ?? "";
      _hireDateController.text = profile.hireDate ?? "";
      _selectedStatus = profile.status ?? "active";
    }
  }

  /// Compress the image to keep it < 2MB
  Future<XFile?> _compressImage(File file) async {
    final targetPath =
        "${file.parent.path}/compressed_${file.uri.pathSegments.last}";
    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      minWidth: 800,
      minHeight: 800,
      quality: 70,
    );
    if (result != null && await result.length() <= 2 * 1024 * 1024) {
      return result;
    }
    return await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      minWidth: 600,
      minHeight: 600,
      quality: 50,
    );
  }

  /// Pick image from Camera or Gallery
  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text("Take a photo"),
                onTap: () async {
                  Navigator.of(context).pop();
                  final pickedFile =
                  await ImagePicker().pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    File file = File(pickedFile.path);
                    final compressed = await _compressImage(file);
                    setState(() {
                      _pickedImage =
                      compressed != null ? File(compressed.path) : file;
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Choose from gallery"),
                onTap: () async {
                  Navigator.of(context).pop();
                  final pickedFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    File file = File(pickedFile.path);
                    final compressed = await _compressImage(file);
                    setState(() {
                      _pickedImage =
                      compressed != null ? File(compressed.path) : file;
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    if (_pickedImage != null &&
        await _pickedImage!.length() > 2 * 1024 * 1024) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Image must be smaller than 2MB")),
      );
      return;
    }

    try {
      if (widget.isEditing) {
        // 🔹 UPDATE
        final dto = UpdateEmployeeProfileDto(
          jobTitle: _jobTitleController.text,
          department: _departmentController.text,
          hireDate: _hireDateController.text,
          status: _selectedStatus ?? "active",
        );

        await ref.read(updateEmployeeProfileProvider({
          "profileId": widget.profile!.id,
          "dto": dto,
          "file": _pickedImage, // 👈 only pass file here
        }).future);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Profile updated successfully")),
          );
          context.go('/employees/profiles');
        }
      } else {
        // 🔹 CREATE
        final dto = CreateEmployeeProfileDto(
          userId: widget.employeeId,
          hireDate: _hireDateController.text,
          jobTitle: _jobTitleController.text,
          department: _departmentController.text,
          status: _selectedStatus ?? "active",
        );

        await ref.read(createEmployeeProfileProvider(
          CreateEmployeeProfileParams(dto, _pickedImage),
        ).future);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Profile created successfully")),
          );
          context.go('/employees/profiles');
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    }
  }

  @override
  void dispose() {
    _jobTitleController.dispose();
    _departmentController.dispose();
    _hireDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing
            ? "Update Employee Profile"
            : "Create Employee Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _pickedImage != null
                        ? FileImage(_pickedImage!)
                        : (widget.profile?.profileImage != null &&
                        widget.profile!.profileImage!.isNotEmpty
                        ? NetworkImage(widget.profile!.profileImage!)
                    as ImageProvider
                        : null),
                    child: _pickedImage == null &&
                        (widget.profile?.profileImage == null ||
                            widget.profile!.profileImage!.isEmpty)
                        ? const Icon(Icons.camera_alt,
                        size: 40, color: Colors.grey)
                        : null,
                  ),
                ),
                const SizedBox(height: 24),

                // Job Title
                TextFormField(
                  controller: _jobTitleController,
                  decoration: const InputDecoration(
                    labelText: "Job Title",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty ? "Enter job title" : null,
                ),
                const SizedBox(height: 16),

                // Department
                TextFormField(
                  controller: _departmentController,
                  decoration: const InputDecoration(
                    labelText: "Department",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty ? "Enter department" : null,
                ),
                const SizedBox(height: 16),

                // Hire Date
                TextFormField(
                  controller: _hireDateController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Hire Date",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty ? "Select hire date" : null,
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.tryParse(
                          _hireDateController.text.isNotEmpty
                              ? _hireDateController.text
                              : DateTime.now().toString()) ??
                          DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _hireDateController.text =
                        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),

                // Status Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedStatus,
                  decoration: const InputDecoration(
                    labelText: "Status",
                    border: OutlineInputBorder(),
                  ),
                  items: _statuses.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value;
                    });
                  },
                  validator: (value) =>
                  value == null || value.isEmpty ? "Select status" : null,
                ),
                const SizedBox(height: 24),

                // Save / Update Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _saveProfile,
                    icon: Icon(widget.isEditing ? Icons.update : Icons.save),
                    label: Text(widget.isEditing
                        ? "Update Profile"
                        : "Save Profile"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
