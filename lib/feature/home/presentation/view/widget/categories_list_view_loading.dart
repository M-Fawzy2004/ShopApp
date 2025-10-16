import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoriesListViewLoading extends StatelessWidget {
  const CategoriesListViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SizedBox(
        height: 120.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: 6,
          separatorBuilder: (context, index) => SizedBox(width: 16.w),
          itemBuilder: (context, index) {
            return const CategoriesItemCardSkeleton();
          },
        ),
      ),
    );
  }
}

class CategoriesItemCardSkeleton extends StatelessWidget {
  const CategoriesItemCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80.h,
          width: 70.w,
          decoration: const BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: 70.w,
          height: 14.h,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}