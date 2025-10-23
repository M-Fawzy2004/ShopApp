import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartAppBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChanged;

  const CartAppBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: REdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(AppRadius.large),
          ),
        ),
        child: Column(
          children: [
            heightBox(40),
            // Title
            Text(
              'My Shopping',
              style: AppStyles.font12BlackBold(context).copyWith(
                fontSize: 20.sp,
              ),
            ),
            heightBox(15),
            // Custom Tab Bar
            Container(
              padding: REdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppRadius.medium),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildTab(
                      context: context,
                      title: 'Cart',
                      index: 0,
                      icon: Icons.shopping_cart_outlined,
                    ),
                  ),
                  widthBox(8),
                  Expanded(
                    child: _buildTab(
                      context: context,
                      title: 'Favourites',
                      index: 1,
                      icon: Icons.favorite_outline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab({
    required BuildContext context,
    required String title,
    required int index,
    required IconData icon,
  }) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onTabChanged(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: REdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.medium),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18.sp,
              color: isSelected
                  ? AppColors.primaryColor
                  : Colors.white.withOpacity(0.8),
            ),
            SizedBox(width: 6.w),
            Text(
              title,
              style: AppStyles.font12BlackBold(context).copyWith(
                fontSize: 14.sp,
                color: isSelected
                    ? AppColors.primaryColor
                    : Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
