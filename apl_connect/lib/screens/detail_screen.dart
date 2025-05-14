import 'package:flutter/material.dart';
import '../models/contact_model.dart';
import '../widgets/suggest_update_form.dart';
import 'package:flutter/services.dart';

class DetailScreen extends StatelessWidget {
  final Contact contact;

  const DetailScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(contact.name),
              background:
                  contact.profileImage.isNotEmpty
                      ? Image.network(contact.profileImage, fit: BoxFit.cover)
                      : Container(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        child: const Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.grey,
                        ),
                      ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Position Details Card
                  Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Position Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            leading: Icon(
                              Icons.work,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Text(contact.designation),
                            subtitle: const Text('Designation'),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.business,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Text(contact.department),
                            subtitle: const Text('Department'),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.phone,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Text(contact.ip),
                            subtitle: const Text('IP Phone'),
                            trailing: IconButton(
                              icon: const Icon(Icons.copy),
                              onPressed: () {
                                Clipboard.setData(
                                  ClipboardData(text: contact.ip),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('IP copied to clipboard'),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Contact Information Card
                  Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contact Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            leading: Icon(
                              Icons.email,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Text(
                              contact.email.isEmpty
                                  ? 'Not provided'
                                  : contact.email,
                            ),
                            subtitle: const Text('Email'),
                            trailing:
                                contact.email.isNotEmpty
                                    ? IconButton(
                                      icon: const Icon(Icons.copy),
                                      onPressed: () {
                                        Clipboard.setData(
                                          ClipboardData(text: contact.email),
                                        );
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Email copied to clipboard',
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                    : null,
                          ),

                          // Personal Number ListTile
                          ListTile(
                            leading: Icon(
                              Icons.phone,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Text(
                              contact.personalNumber.isEmpty
                                  ? 'Not provided'
                                  : contact.personalNumber,
                            ),
                            subtitle: const Text('Personal Number'),
                            trailing:
                                contact.personalNumber.isNotEmpty
                                    ? IconButton(
                                      icon: const Icon(Icons.copy),
                                      onPressed: () {
                                        Clipboard.setData(
                                          ClipboardData(
                                            text: contact.personalNumber,
                                          ),
                                        );
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Number copied to clipboard',
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                    : null,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Update Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      icon: const Icon(Icons.edit_outlined, size: 18),
                      label: const Text('Suggest Update'),
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => SuggestUpdateForm(contact: contact),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
