import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouritesContentWidget extends StatelessWidget {
  const FavouritesContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite_border,
                size: 100.sp,
                color: Colors.grey.shade400,
              ),
              heightBox(24),
              Text(
                'No Favourites Yet',
                style: AppStyles.font16BlackBold(context).copyWith(
                  fontSize: 20.sp,
                ),
              ),
              heightBox(12),
              Text(
                'Start adding your favorite items to see them here',
                textAlign: TextAlign.center,
                style: AppStyles.font12BlackBold(context).copyWith(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
