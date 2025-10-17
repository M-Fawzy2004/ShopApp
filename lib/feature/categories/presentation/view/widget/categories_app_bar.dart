import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/core/widget/custom_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesAppBar extends StatelessWidget {
  const CategoriesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.primaryColor,
      pinned: true,
      floating: true,
      snap: true,
      collapsedHeight: 60.h,
      expandedHeight: 115.h,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppRadius.large),
          bottomRight: Radius.circular(AppRadius.large),
        ),
      ),
      title: Text(
        'Categories',
        style: AppStyles.font32BlackBold(context),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(-5),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
          child: const CustomSearchField(
            hintText: 'Search for categories...',
          ),
        ),
      ),
    );
  }
}
