import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;

class AuthButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final bool isSecondary;

  const AuthButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = isLoading ? null : onPressed;
    final style = isSecondary
        ? shadcn.ButtonStyle.secondary()
        : shadcn.ButtonStyle.primary();

    return shadcn.Button(
      onPressed: effectiveOnPressed,
      style: style,
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: shadcn.CircularProgressIndicator(size: 20, strokeWidth: 2),
            )
          : Text(text, textAlign: TextAlign.center),
    );
  }
}
