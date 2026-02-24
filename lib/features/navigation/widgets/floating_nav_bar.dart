import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:ship_flutter_starter/features/routing/enums/app_routes_enum.dart';

class FloatingNavBar extends StatelessWidget {
  final String currentPath;

  const FloatingNavBar({super.key, required this.currentPath});

  int get _currentIndex {
    if (currentPath.startsWith(PrivateRoute.profile.path)) return 2;
    if (currentPath.startsWith(PrivateRoute.chats.path)) return 1;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.onPrimary;
    final unselectedColor = theme.colorScheme.onPrimary.withValues(alpha: 0.5);

    return Container(
      height: 70,
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _NavItem(
            icon: Iconsax.home_2,
            label: 'Home',
            isSelected: _currentIndex == 0,
            selectedColor: primaryColor,
            unselectedColor: unselectedColor,
            onTap: () => context.go(PrivateRoute.home.path),
          ),
          _NavItem(
            icon: Iconsax.message,
            label: 'Chat',
            isSelected: _currentIndex == 1,
            selectedColor: primaryColor,
            unselectedColor: unselectedColor,
            onTap: () => context.go(PrivateRoute.chats.path),
          ),
          _NavItem(
            icon: Iconsax.user,
            label: 'Profile',
            isSelected: _currentIndex == 2,
            selectedColor: primaryColor,
            unselectedColor: unselectedColor,
            onTap: () => context.go(PrivateRoute.profile.path),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final Color selectedColor;
  final Color unselectedColor;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.selectedColor,
    required this.unselectedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 24,
                color: isSelected ? selectedColor : unselectedColor,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? selectedColor : unselectedColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
