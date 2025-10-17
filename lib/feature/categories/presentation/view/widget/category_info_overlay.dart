import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/feature/categories/presentation/view/widget/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryInfoOverlay extends StatelessWidget {
  const CategoryInfoOverlay({super.key, required this.widget});

  final CategoryCard widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.category.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          heightBox(4),
          Row(
            children: [
              Text(
                'Explore',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              widthBox(5),
              Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white.withOpacity(0.9),
                size: 14.sp,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
