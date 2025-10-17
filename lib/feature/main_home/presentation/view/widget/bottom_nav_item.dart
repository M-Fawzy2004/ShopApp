import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final IconData? activeIcon;
  final bool isActive;
  final VoidCallback onTap;

  const BottomNavItem({
    super.key,
    required this.icon,
    this.activeIcon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isActive ? activeIcon ?? icon : icon,
        color: isActive ? AppColors.primaryColor : AppColors.darkGrey,
        size: isActive ? 30.0 : 27.0,
      ),
    );
  }
}
