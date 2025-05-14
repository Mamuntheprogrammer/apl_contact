import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
  late TextEditingController _noteController;

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
    _noteController = TextEditingController();
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
    _noteController.dispose();
    super.dispose();
  }

  void _submitSuggestion() async {
    if (_formKey.currentState!.validate()) {
      final formUrl = Uri.parse(
        'https://docs.google.com/forms/d/e/1FAIpQLSf58vNHTc8SbSS00D69K7F_EO1YktyhXfIMdN4wT0yHDaXhwQ/formResponse',
      );

      final response = await http.post(
        formUrl,
        body: {
          'entry.2032671946': _nameController.text,
          'entry.1410087173': _designationController.text,
          'entry.1646783677': _departmentController.text,
          'entry.1707133359': _ipController.text,
          'entry.623302543': _emailController.text,
          'entry.888287904': _phoneController.text,
          'entry.1335000797': _imageUrlController.text,
          'entry.1721299444': _noteController.text,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 302) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder:
              (dialogContext) => AlertDialog(
                title: const Text('Submitted'),
                content: const Text('Your suggestion has been submitted.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
        );
      } else {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Submission Failed'),
                content: Text('Status code: ${response.statusCode}'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
        );
      }

      print('Submitted');
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
              const SizedBox(height: 12),

              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(
                  labelText: 'Note',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
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
