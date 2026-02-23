import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;

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
      child: shadcn.TextField(
        controller: searchController,
        placeholder: const Text('Search users - Enter name or email'),
        onSubmitted: (_) => onSearch(),
        features: [
          shadcn.InputLeadingFeature(Icon(Icons.search)),
          shadcn.InputClearFeature(),
        ],
      ),
    );
  }
}
