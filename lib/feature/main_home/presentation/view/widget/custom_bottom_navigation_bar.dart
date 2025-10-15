import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/utils/assets.dart';
import 'package:clothes_ecommerce_app/feature/main_home/presentation/view/widget/bottom_nav_item.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomNavItem(
                icon: Assets.imagesIconHomeIcon,
                activeIcon: Assets.imagesIconActiveHomeIcon,
                isActive: currentIndex == 0,
                onTap: () => onTap(0),
              ),
              BottomNavItem(
                icon: Assets.imagesIconNotificationIcon,
                activeIcon: Assets.imagesIconActiveNotificationIcon,
                isActive: currentIndex == 1,
                onTap: () => onTap(1),
              ),
              BottomNavItem(
                icon: Assets.imagesIconSaveIcon,
                activeIcon: Assets.imagesIconActiveSaveIcon,
                isActive: currentIndex == 2,
                onTap: () => onTap(2),
              ),
              BottomNavItem(
                icon: Assets.imagesIconPersonIcon,
                activeIcon: Assets.imagesIconActivePersonIcon,
                isActive: currentIndex == 3,
                onTap: () => onTap(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
