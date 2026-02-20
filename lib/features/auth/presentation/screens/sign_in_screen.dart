import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ship_flutter_starter/core/extensions/context_extensions.dart';
import 'package:ship_flutter_starter/core/utils/error_handler.dart';
import 'package:ship_flutter_starter/core/validators/email_validator.dart';
import 'package:ship_flutter_starter/core/validators/password_validator.dart';
import 'package:ship_flutter_starter/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:ship_flutter_starter/features/auth/presentation/providers/sign_in_provider.dart';
import 'package:ship_flutter_starter/features/auth/presentation/providers/google_sign_in_provider.dart';
import 'package:ship_flutter_starter/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:ship_flutter_starter/features/auth/presentation/widgets/auth_button.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    if (!_formKey.currentState!.validate()) return;

    await ref
        .read(signInProvider.notifier)
        .signIn(_emailController.text.trim(), _passwordController.text);

    final signInState = ref.read(signInProvider);
    signInState.when(
      data: (user) {
        if (user != null) {
          ref.invalidate(authStateProvider);
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

  Future<void> _handleGoogleSignIn() async {
    await ref.read(googleSignInProvider.notifier).signIn();

    final googleSignInState = ref.read(googleSignInProvider);
    googleSignInState.when(
      data: (user) {
        if (user != null) {
          ref.invalidate(authStateProvider);
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
    final signInAsync = ref.watch(signInProvider);
    final googleSignInAsync = ref.watch(googleSignInProvider);
    final isLoading = signInAsync.isLoading || googleSignInAsync.isLoading;

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
                  'Sign In',
                  style: context.textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
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
                  onPressed: isLoading ? null : _handleSignIn,
                  text: 'Sign In',
                  isLoading: signInAsync.isLoading,
                ),
                const SizedBox(height: 16),
                AuthButton(
                  onPressed: isLoading ? null : _handleGoogleSignIn,
                  text: 'Sign in with Google',
                  isLoading: googleSignInAsync.isLoading,
                  isSecondary: true,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    TextButton(
                      onPressed: isLoading
                          ? null
                          : () => context.go('/sign-up'),
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () => context.go('/forgot-password'),
                  child: const Text('Forgot Password?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
