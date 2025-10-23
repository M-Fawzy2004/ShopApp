import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductRatingBadge extends StatelessWidget {
  const ProductRatingBadge({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.star,
                size: 12,
                color: Color(0xFFFF9800),
              ),
              widthBox(4),
              Text(
                product.rating.toStringAsFixed(1),
                style: AppStyles.font12BlackBold(context).copyWith(
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ),
        widthBox(6),
        Text(
          '(${product.reviews.length})',
          style: AppStyles.font12GreyBold(context).copyWith(
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }
}
