import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ship_flutter_starter/core/extensions/context_extensions.dart';
import 'package:ship_flutter_starter/core/utils/error_handler.dart';
import 'package:ship_flutter_starter/features/auth/presentation/providers/sign_out_provider.dart';
import 'package:ship_flutter_starter/features/profile/presentation/providers/profile_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  bool _isEditing = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> _handleUpdate() async {
    if (_firstNameController.text.trim().isEmpty ||
        _lastNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    await ref
        .read(profileProvider.notifier)
        .updateProfile(
          _firstNameController.text.trim(),
          _lastNameController.text.trim(),
          null,
        );

    final updateState = ref.read(profileProvider);
    updateState.when(
      data: (user) {
        if (user != null) {
          setState(() {
            _isEditing = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully')),
          );
        }
      },
      loading: () {},
      error: (error, stack) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ErrorHandler.handleError(context, error);
        });
      },
    );
  }

  Future<void> _handleSignOut() async {
    await ref.read(signOutProvider.notifier).signOut();
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          if (_isEditing)
            TextButton(
              onPressed: () {
                setState(() {
                  _isEditing = false;
                });
                profileAsync.whenData((user) {
                  if (user != null) {
                    _firstNameController.text = user.firstName;
                    _lastNameController.text = user.lastName;
                  }
                });
              },
              child: const Text('Cancel'),
            )
          else
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  _isEditing = true;
                });
              },
            ),
        ],
      ),
      body: profileAsync.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('No profile data'));
          }

          if (!_isEditing) {
            _firstNameController.text = user.firstName;
            _lastNameController.text = user.lastName;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: user.avatarUrl != null
                      ? CachedNetworkImageProvider(user.avatarUrl!)
                      : null,
                  child: user.avatarUrl == null
                      ? Text(
                          user.firstName[0].toUpperCase(),
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                const SizedBox(height: 24),
                if (_isEditing) ...[
                  TextField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _handleUpdate,
                    child: const Text('Save'),
                  ),
                ] else ...[
                  Text(
                    '${user.firstName} ${user.lastName}',
                    style: context.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(user.email, style: context.textTheme.bodyLarge),
                  const SizedBox(height: 32),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text('Email'),
                    subtitle: Text(user.email),
                  ),
                  ListTile(
                    leading: const Icon(Icons.verified),
                    title: const Text('Email Verified'),
                    subtitle: Text(user.isEmailVerified ? 'Yes' : 'No'),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _handleSignOut,
                    icon: const Icon(Icons.logout),
                    label: const Text('Sign Out'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                      foregroundColor: Theme.of(context).colorScheme.onError,
                    ),
                  ),
                ],
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          final isUnauthorized =
              error is DioException && error.response?.statusCode == 401;

          if (!isUnauthorized) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ErrorHandler.handleError(context, error);
            });
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Error loading profile'),
                ElevatedButton(
                  onPressed: () {
                    ref.read(profileProvider.notifier).loadProfile();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
