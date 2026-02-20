import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ship_flutter_starter/core/extensions/context_extensions.dart';
import 'package:ship_flutter_starter/core/utils/error_handler.dart';
import 'package:ship_flutter_starter/core/validators/email_validator.dart';
import 'package:ship_flutter_starter/core/validators/password_validator.dart';
import 'package:ship_flutter_starter/features/auth/presentation/providers/account_provider.dart';
import 'package:ship_flutter_starter/features/auth/presentation/providers/sign_up_provider.dart';
import 'package:ship_flutter_starter/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:ship_flutter_starter/features/auth/presentation/widgets/auth_button.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    await ref.read(signUpProvider.notifier).signUp(
          _emailController.text.trim(),
          _passwordController.text,
          _firstNameController.text.trim(),
          _lastNameController.text.trim(),
        );

    final signUpState = ref.read(signUpProvider);
    signUpState.when(
      data: (user) {
        if (user != null) {
          ref.invalidate(accountProvider);
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

  @override
  Widget build(BuildContext context) {
    final signUpAsync = ref.watch(signUpProvider);
    final isLoading = signUpAsync.isLoading;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),
                Text(
                  'Sign Up',
                  style: context.textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                AuthTextField(
                  controller: _firstNameController,
                  label: 'First Name',
                  validator: _validateRequired,
                  enabled: !isLoading,
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: _lastNameController,
                  label: 'Last Name',
                  validator: _validateRequired,
                  enabled: !isLoading,
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: _emailController,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: EmailValidator.validate,
                  enabled: !isLoading,
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: _passwordController,
                  label: 'Password',
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  validator: PasswordValidator.validate,
                  enabled: !isLoading,
                ),
                const SizedBox(height: 24),
                AuthButton(
                  onPressed: isLoading ? null : _handleSignUp,
                  text: 'Sign Up',
                  isLoading: signUpAsync.isLoading,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? '),
                    TextButton(
                      onPressed: isLoading
                          ? null
                          : () => context.go('/sign-in'),
                      child: const Text('Sign In'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
