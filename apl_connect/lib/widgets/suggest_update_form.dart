import 'package:flutter/material.dart';
import '../models/contact_model.dart';

class SuggestUpdateForm extends StatefulWidget {
  final Contact contact;

  const SuggestUpdateForm({super.key, required this.contact});

  @override
  State<SuggestUpdateForm> createState() => _SuggestUpdateFormState();
}

class _SuggestUpdateFormState extends State<SuggestUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _designationController;
  late TextEditingController _departmentController;
  late TextEditingController _ipController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _imageUrlController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact.name);
    _designationController = TextEditingController(
      text: widget.contact.designation,
    );
    _departmentController = TextEditingController(
      text: widget.contact.department,
    );
    _ipController = TextEditingController(text: widget.contact.ip);
    _emailController = TextEditingController(text: widget.contact.email);
    _phoneController = TextEditingController(
      text: widget.contact.personalNumber,
    );
    _imageUrlController = TextEditingController(
      text: widget.contact.profileImage,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _designationController.dispose();
    _departmentController.dispose();
    _ipController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _submitSuggestion() {
    if (_formKey.currentState!.validate()) {
      // You can send this data to GitHub Issues API, Email, or Google Forms
      final suggestion = {
        "name": _nameController.text,
        "designation": _designationController.text,
        "department": _departmentController.text,
        "ip": _ipController.text,
        "email": _emailController.text,
        "personal_number": _phoneController.text,
        "profile_image": _imageUrlController.text,
        "timestamp": DateTime.now().toIso8601String(),
      }; // Show success dialog
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent closing by tapping outside
        builder:
            (dialogContext) => AlertDialog(
              title: const Text('Submitted'),
              content: const Text(
                'Your suggestion has been submitted for approval.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // Close success dialog
                    Navigator.of(context).pop(); // Close update form dialog
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
      );

      print(
        'SUGGESTION: $suggestion',
      ); // <-- replace with your submission logic
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Suggest Update'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Update for: ${widget.contact.name}'),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _designationController,
                decoration: const InputDecoration(
                  labelText: 'Designation',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _departmentController,
                decoration: const InputDecoration(
                  labelText: 'Department',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _ipController,
                decoration: const InputDecoration(
                  labelText: 'IP',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Personal Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'Profile Image URL',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitSuggestion,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
