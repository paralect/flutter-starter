import 'package:flutter/material.dart';

class UsersListFilters extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onSearch;

  const UsersListFilters({
    super.key,
    required this.searchController,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          labelText: 'Search users',
          hintText: 'Enter name or email',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    onSearch();
                  },
                )
              : null,
          border: const OutlineInputBorder(),
        ),
        onSubmitted: (_) => onSearch(),
      ),
    );
  }
}
