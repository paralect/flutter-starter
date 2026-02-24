import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ship_flutter_starter/core/utils/error_handler.dart';
import 'package:ship_flutter_starter/features/users/presentation/providers/users_list_provider.dart';
import 'package:ship_flutter_starter/features/users/presentation/widgets/user_list_item.dart';
import 'package:ship_flutter_starter/features/users/presentation/widgets/users_list_filters.dart';

class UsersListScreen extends ConsumerStatefulWidget {
  const UsersListScreen({super.key});

  @override
  ConsumerState<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends ConsumerState<UsersListScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      ref.read(usersListProvider.notifier).loadMore();
    }
  }

  void _handleSearch() {
    final query = _searchController.text.trim();
    ref.read(usersListProvider.notifier).search(query);
  }

  @override
  Widget build(BuildContext context) {
    final usersAsync = ref.watch(usersListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(usersListProvider.notifier).refresh();
        },
        child: Column(
          children: [
            UsersListFilters(
              searchController: _searchController,
              onSearch: _handleSearch,
            ),
            Expanded(
              child: usersAsync.when(
                data: (usersList) {
                  if (usersList.results.isEmpty) {
                    return const Center(
                      child: Text('No users found'),
                    );
                  }
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: usersList.results.length,
                    itemBuilder: (context, index) {
                      final user = usersList.results[index];
                      return UserListItem(
                        user: user,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Clicked on ${user.firstName} ${user.lastName}'),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                loading: () => Center(
                  child: shadcn.CircularProgressIndicator(),
                ),
                error: (error, stack) {
                  final isUnauthorized = error is DioException &&
                      error.response?.statusCode == 401;

                  if (!isUnauthorized) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ErrorHandler.handleError(context, error);
                    });
                  }

                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Error loading users'),
                        shadcn.Button(
                          style: shadcn.ButtonStyle.primary(),
                          onPressed: () {
                            ref.read(usersListProvider.notifier).refresh();
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
