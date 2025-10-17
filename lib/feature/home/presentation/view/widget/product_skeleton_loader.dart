import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';

class ProductSkeletonLoader extends StatelessWidget {
  const ProductSkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170.w,
      height: 260.h,
      margin: EdgeInsets.only(right: 12.w),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.regular),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.lightBlue.withOpacity(0.25),
              borderRadius: BorderRadius.circular(AppRadius.medium),
            ),
          ),
          heightBox(12),
          Container(
            height: 14.h,
            width: 100.w,
            decoration: BoxDecoration(
              color: AppColors.lightBlue.withOpacity(0.25),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          heightBox(8),
          Container(
            height: 12.h,
            width: 60.w,
            decoration: BoxDecoration(
              color: AppColors.lightBlue.withOpacity(0.25),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Container(
                height: 14.h,
                width: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.lightBlue.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const Spacer(),
              Container(
                width: 36.w,
                height: 36.h,
                decoration: const BoxDecoration(
                  color: AppColors.lightBlue,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
