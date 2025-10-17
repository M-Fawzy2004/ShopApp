import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesHeaderRow extends StatelessWidget {
  const CategoriesHeaderRow({super.key, this.onNavigateToSubjects});

    final VoidCallback? onNavigateToSubjects;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Text(
            'Categories',
            style: AppStyles.font16BlackBold(context),
          ),
          const Spacer(),
          GestureDetector(
            onTap:  onNavigateToSubjects,
            child: Text(
              'See all',
              style: AppStyles.font14BlackMedium(context).copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
