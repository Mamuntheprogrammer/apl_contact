import 'package:flutter/material.dart';
import '../models/contact_model.dart';

class EditContactScreen extends StatefulWidget {
  final Contact contact;

  const EditContactScreen({super.key, required this.contact});

  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController imageUrlController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.contact.email);
    phoneController = TextEditingController(
      text: widget.contact.personalNumber,
    );
    imageUrlController = TextEditingController(
      text: widget.contact.profileImage,
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  void submitUpdate() {
    // Simulate sending data
    final updateInfo = {
      'id': widget.contact.id,
      'name': widget.contact.name,
      'updated_email': emailController.text,
      'updated_number': phoneController.text,
      'updated_image': imageUrlController.text,
    };

    // Show dialog or send to a form/api/email
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Update Submitted'),
            content: Text('Please wait for admin approval.\n\n$updateInfo'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );

    // You can send this to a Google Form or print it to a local file if needed
    print(updateInfo); // Replace with real logic if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Contact')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: imageUrlController,
              decoration: const InputDecoration(labelText: 'Profile Image URL'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Personal Number'),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: submitUpdate,
              icon: const Icon(Icons.upload),
              label: const Text('Submit Update'),
            ),
          ],
        ),
      ),
    );
  }
}
