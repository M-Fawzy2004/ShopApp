import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/feature/categories_details/presentation/view/widget/product_price_and_actions_row.dart';
import 'package:clothes_ecommerce_app/feature/categories_details/presentation/view/widget/product_rating_badge.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsCardContent extends StatelessWidget {
  const ProductDetailsCardContent({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title,
            style: AppStyles.font16BlackBold(context).copyWith(
              fontSize: 14.sp,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          heightBox(6),
          ProductRatingBadge(product: product),
          const Spacer(),
          ProductPriceAndActionsRow(product: product),
        ],
      ),
    );
  }
}
