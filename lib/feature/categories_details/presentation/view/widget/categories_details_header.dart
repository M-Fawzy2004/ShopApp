import 'package:clothes_ecommerce_app/core/widget/circle_icon.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesDetailsHeader extends StatelessWidget {
  const CategoriesDetailsHeader({super.key, required this.category});
  final CategoryEntity category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 10),
      child: Row(
        children: [
          const CircleIcon(),
          const Spacer(),
          Text(
            category.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 45.w,
            height: 45.w,
          ),
        ],
      ),
    );
  }
}
