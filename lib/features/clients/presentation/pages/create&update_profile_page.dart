import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:lab_app/features/clients/data/models/update_client_profile_dto.dart';
import 'package:lab_app/features/clients/data/models/client_profile_dto.dart';
import 'package:lab_app/features/clients/data/models/create_client_profile_dto.dart';
import 'package:lab_app/features/clients/presentation/providers/clients_provider.dart';

class ClientProfileScreen extends ConsumerStatefulWidget {
  final String clientId;
  final ClientProfileDto? profile; // null → create, not null → update
  final String? clientName;
  final String? clientEmail;

  const ClientProfileScreen({
    super.key,
    required this.clientId,
    this.profile,
     this.clientName,
     this.clientEmail,
  });

  bool get isEditing => profile != null;

  @override
  ConsumerState<ClientProfileScreen> createState() =>
      _ClientProfileScreenState();
}

class _ClientProfileScreenState extends ConsumerState<ClientProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _companyController = TextEditingController();
  final _addressController = TextEditingController();
  final _websiteController = TextEditingController();

  File? _pickedImage;

  @override
  void initState() {
    super.initState();

    if (widget.isEditing) {
      final profile = widget.profile!;
      _nameController.text = profile.name;
      _emailController.text = profile.email;
      _phoneController.text = profile.phone;
      _companyController.text = profile.company;
      _addressController.text = profile.address;
      _websiteController.text = profile.website;
    }else {
      // ✅ Pre-fill from passed clientName & clientEmail
      _nameController.text = widget.clientName!;
      _emailController.text = widget.clientEmail!;
    }
  }

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
        final dto = UpdateClientProfileDto(
          name: _nameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          company: _companyController.text.isEmpty
              ? null
              : _companyController.text,
          address: _addressController.text,
          website: _websiteController.text.isEmpty
              ? null
              : _websiteController.text,
        );

        await ref
            .read(
          updateClientProfileProvider(
            UpdateClientProfileParams(
              profileId: widget.profile!.user_id,
              dto: dto,
              file: _pickedImage,
            ),
          ).future,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Client updated successfully")),
          );
          ref.invalidate(clientProfilesProvider);
          context.go('/clients/profiles');
        }
      } else {
        final dto = CreateClientProfileDto(
          user_id: widget.clientId,
          name: _nameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          company: _companyController.text.isEmpty
              ? null
              : _companyController.text,
          address: _addressController.text,
          website: _websiteController.text.isEmpty
              ? null
              : _websiteController.text,
        );

        await ref
            .read(
          createClientProfileProvider(
            CreateClientProfileParams(dto, _pickedImage),
          ).future,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Client created successfully")),
          );
          ref.invalidate(clientProfilesProvider);
          context.go('/clients/profiles');
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
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _companyController.dispose();
    _addressController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Text(widget.isEditing ? "Update Client Profile" : "Create Client"),
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
                        : (widget.profile?.profilePhoto != null &&
                        widget.profile!.profilePhoto.isNotEmpty
                        ? NetworkImage(widget.profile!.profilePhoto)
                        : null) as ImageProvider<Object>?,
                    child: _pickedImage == null &&
                        (widget.profile?.profilePhoto == null ||
                            widget.profile!.profilePhoto.isEmpty)
                        ? const Icon(Icons.camera_alt,
                        size: 40, color: Colors.grey)
                        : null,
                  ),
                ),
                const SizedBox(height: 24),

                _buildTextField(_nameController, "Name",
                    validator: (value) => value == null || value.isEmpty
                        ? "Enter Name"
                        : null),
                const SizedBox(height: 16),

                _buildTextField(
                  _emailController,
                  "Email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Enter Email";
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                _buildTextField(_phoneController, "Phone",
                    keyboardType: TextInputType.phone,
                    validator: (value) => value == null || value.isEmpty
                        ? "Enter Phone"
                        : null),
                const SizedBox(height: 16),

                _buildTextField(
                  _companyController,
                  "Company",
                  validator: (value) {
                    return null; // ✅ optional
                  },
                ),
                const SizedBox(height: 16),

                _buildTextField(_addressController, "Address",
                    validator: (value) => value == null || value.isEmpty
                        ? "Enter Address"
                        : null),
                const SizedBox(height: 16),

                _buildTextField(
                  _websiteController,
                  "Website",
                  keyboardType: TextInputType.url,
                  validator: (value) {
                    if (value == null || value.isEmpty) return null; // optional
                    if (!value.startsWith("http://") &&
                        !value.startsWith("https://")) {
                      return "Website must start with http:// or https://";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _saveProfile,
                    icon: Icon(widget.isEditing ? Icons.update : Icons.save),
                    label: Text(
                        widget.isEditing ? "Update Client" : "Save Client"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String label, {
        TextInputType keyboardType = TextInputType.text,
        String? Function(String?)? validator,
      }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
