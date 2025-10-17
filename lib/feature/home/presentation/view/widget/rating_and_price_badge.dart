import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingAndPriceBadge extends StatelessWidget {
  const RatingAndPriceBadge({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppRadius.small),
      ),
      child: Row(
        children: [
          Text(
            product.rating.toStringAsFixed(1),
            style: AppStyles.font12BlackMedium(context),
          ),
          widthBox(5),
          Icon(
            Icons.star,
            color: AppColors.primaryColor,
            size: 16.sp,
          ),
          const Spacer(),
          Text(
            product.price.toString(),
            style: AppStyles.font12BlackMedium(context).copyWith(
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }
}
