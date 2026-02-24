import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:ship_flutter_starter/features/navigation/widgets/floating_nav_bar.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  final String currentPath;

  const MainShell({super.key, required this.child, required this.currentPath});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final barColor = theme.colorScheme.primary;
    final double radius = 24.0;

    return Scaffold(
      body: BottomBar(
        body: (context, controller) => child,
        barColor: barColor,
        barDecoration: BoxDecoration(
          color: barColor,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        width: MediaQuery.sizeOf(context).width - 32,
        borderRadius: BorderRadius.circular(radius),
        showIcon: false,
        hideOnScroll: false,
        barAlignment: Alignment.bottomCenter,
        child: FloatingNavBar(currentPath: currentPath),
      ),
    );
  }
}
