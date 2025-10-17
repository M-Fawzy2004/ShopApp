import 'package:clothes_ecommerce_app/feature/categories/presentation/view/widget/animated_category_card.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategorySkeletonizerLoading extends StatefulWidget {
  const CategorySkeletonizerLoading({super.key});

  @override
  State<CategorySkeletonizerLoading> createState() =>
      _CategorySkeletonizerLoadingState();
}

class _CategorySkeletonizerLoadingState
    extends State<CategorySkeletonizerLoading> {
  List<CategoryEntity> getDummay = List.generate(
  8, 
  (index) => CategoryEntity(
    slug: 'Loading $index',
    name: 'Loading Category',
    url: 'https://via.placeholder.com/150',
    imageUrl: 'https://via.placeholder.com/150',
  ),
);

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15.w,
            mainAxisSpacing: 15.h,
            childAspectRatio: 0.90,
          ),
          itemCount: getDummay.length,
          itemBuilder: (context, index) {
            return AnimatedCategoryCard(
              index: index,
              isTall: index % 3 == 0,
              category: getDummay[index],
            );
          },
        ),
      ),
    );
  }
}
