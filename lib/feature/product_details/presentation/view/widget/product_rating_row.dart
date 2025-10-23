import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductRatingRow extends StatelessWidget {
  const ProductRatingRow({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          product.rating.toString(),
          style: AppStyles.font16BlackBold(context),
        ),
        widthBox(4),
        Icon(
          Icons.star,
          color: const Color(0xFFFFC107),
          size: 20.sp,
        ),
        widthBox(5),
        Text(
          '(${product.reviews.length} Reviews)',
          style: AppStyles.font14BlackMedium(context).copyWith(
            color: const Color(0xFF666666),
          ),
        ),
      ],
    );
  }
}
