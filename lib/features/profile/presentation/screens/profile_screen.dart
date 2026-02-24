import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;
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
        automaticallyImplyLeading: false,
        title: const Text('Profile'),
        actions: [
          if (_isEditing)
            shadcn.GhostButton(
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
            shadcn.IconButton.ghost(
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
                  shadcn.TextField(
                    controller: _firstNameController,
                    placeholder: const Text('First Name'),
                  ),
                  const SizedBox(height: 16),
                  shadcn.TextField(
                    controller: _lastNameController,
                    placeholder: const Text('Last Name'),
                  ),
                  const SizedBox(height: 24),
                  shadcn.Button(
                    style: shadcn.ButtonStyle.primary(),
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
                  shadcn.Button.destructive(
                    onPressed: _handleSignOut,
                    leading: const Icon(Icons.logout),
                    child: const Text('Sign Out'),
                  ),
                ],
              ],
            ),
          );
        },
        loading: () => Center(child: shadcn.CircularProgressIndicator()),
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
                shadcn.Button(
                  style: shadcn.ButtonStyle.primary(),
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
