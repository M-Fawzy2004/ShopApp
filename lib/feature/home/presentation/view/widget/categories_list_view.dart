import 'package:clothes_ecommerce_app/feature/home/domain/entities/category_entity.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/categories_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesListView extends StatelessWidget {
  final List<CategoryEntity> categories;

  const CategoriesListView({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 16.w),
        itemBuilder: (context, index) {
          return CategoriesItemCard(category: categories[index]);
        },
      ),
    );
  }
}