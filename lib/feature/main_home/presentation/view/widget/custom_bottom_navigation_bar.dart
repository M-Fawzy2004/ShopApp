import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/feature/main_home/presentation/view/widget/bottom_nav_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

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
      height: 60.h,
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
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
                icon: IconlyLight.home,
                activeIcon: IconlyBold.home,
                isActive: currentIndex == 0,
                onTap: () => onTap(0),
              ),
              BottomNavItem(
                icon: IconlyLight.category,
                activeIcon: IconlyBold.category,
                isActive: currentIndex == 1,
                onTap: () => onTap(1),
              ),
              BottomNavItem(
                icon: IconlyLight.bag,
                activeIcon: IconlyBold.bag,
                isActive: currentIndex == 2,
                onTap: () => onTap(2),
              ),
              BottomNavItem(
                icon: IconlyLight.profile,
                activeIcon: IconlyBold.profile,
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
