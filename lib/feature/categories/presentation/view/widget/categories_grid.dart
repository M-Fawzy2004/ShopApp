import 'package:clothes_ecommerce_app/feature/categories/presentation/view/widget/animated_category_card.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({super.key, required this.categories});

  final List<CategoryEntity> categories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15.w,
          mainAxisSpacing: 15.h,
          childAspectRatio: 0.90,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return AnimatedCategoryCard(
            index: index,
            isTall: index % 3 == 0,
            category: categories[index],
          );
        },
      ),
    );
  }
}
