import 'package:flutter/material.dart';
import '../models/contact_model.dart';
import '../services/contact_service.dart';
import '../widgets/contact_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Contact> allContacts = [];
  List<Contact> filteredContacts = [];
  final TextEditingController searchController = TextEditingController();

  String? selectedDept;
  String? selectedIp;
  String searchQuery = '';
  bool isLoading = true;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  Future<void> loadContacts() async {
    final contacts = await ContactService.fetchContacts();
    setState(() {
      allContacts = contacts;
      filteredContacts = contacts;
      isLoading = false;
    });
  }

  void filterContacts() {
    setState(() {
      filteredContacts =
          allContacts.where((c) {
            final matchDept =
                selectedDept == null || c.department == selectedDept;
            final matchIp = selectedIp == null || c.ip == selectedIp;
            final matchSearch = c.name.toLowerCase().contains(
              searchQuery.toLowerCase(),
            );
            return matchDept && matchIp && matchSearch;
          }).toList();
    });
  }

  List<String> getDepartments() {
    return allContacts.map((c) => c.department).toSet().toList()..sort();
  }

  List<String> getIps() {
    return allContacts.map((c) => c.ip).toSet().toList()..sort();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Office Directory'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Fetch Latest',
            onPressed: () async {
              setState(() => isLoading = true);
              await loadContacts(); // Re-fetch from network or fallback to cache
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Search Field
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search by name...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (val) {
                setState(() {
                  searchQuery = val;
                  filterContacts();
                });
              },
            ),

            const SizedBox(height: 10),

            // Dropdown Filters Row
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedDept,
                    isExpanded: true,
                    hint: const Text('Filter by Dept'),
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('All Departments ↓'),
                      ),
                      ...getDepartments()
                          .map(
                            (d) => DropdownMenuItem(value: d, child: Text(d)),
                          )
                          .toList(),
                    ],
                    onChanged: (val) {
                      setState(() {
                        selectedDept = val;
                        filterContacts();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedIp,
                    isExpanded: true,
                    hint: const Text('Filter by IP'),
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('All IP-Phone ↓'),
                      ),
                      ...getIps()
                          .map(
                            (ip) =>
                                DropdownMenuItem(value: ip, child: Text(ip)),
                          )
                          .toList(),
                    ],
                    onChanged: (val) {
                      setState(() {
                        selectedIp = val;
                        filterContacts();
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Contact List
            Expanded(
              child:
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : filteredContacts.isEmpty
                      ? const Center(child: Text('No contacts found.'))
                      : ListView.builder(
                        itemCount: filteredContacts.length,
                        itemBuilder: (context, index) {
                          return ContactCard(contact: filteredContacts[index]);
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
