import 'package:flutter/material.dart';

class SearchFilter extends StatefulWidget {
  final List<String> departments;
  final Function(String searchText, String selectedDept) onFilterChanged;

  const SearchFilter({
    super.key,
    required this.departments,
    required this.onFilterChanged,
  });

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  String _searchText = '';
  String _selectedDept = 'All';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 🔍 Search field
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Search by name',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (val) {
              setState(() {
                _searchText = val;
              });
              widget.onFilterChanged(_searchText, _selectedDept);
            },
          ),
        ),

        // 🔽 Dropdown for department
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonFormField<String>(
            value: _selectedDept,
            items:
                ['All', ...widget.departments]
                    .map(
                      (dept) =>
                          DropdownMenuItem(value: dept, child: Text(dept)),
                    )
                    .toList(),
            decoration: const InputDecoration(
              labelText: 'Filter by department',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _selectedDept = value!;
              });
              widget.onFilterChanged(_searchText, _selectedDept);
            },
          ),
        ),
      ],
    );
  }
}
