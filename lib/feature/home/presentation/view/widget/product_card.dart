import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/discount_badge.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/price_and_add_button_row.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/product_image.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/rating_and_price_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    double finalPrice = product.price * (1 - product.discountPercentage / 100);

    return Container(
      width: 200.w,
      height: 300.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.regular),
      ),
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Stack with Discount Badge
          Stack(
            children: [
              Container(
                height: 170.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.lightBlue,
                  borderRadius: BorderRadius.circular(AppRadius.medium),
                ),
                child: ProductImage(product: product),
              ),
              if (product.discountPercentage > 0)
                Positioned(
                  top: 8.w,
                  right: 5.w,
                  child: DiscountBadge(product: product),
                ),
            ],
          ),
          heightBox(12),
          Text(
            product.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.font16BlackBold(context),
          ),
          heightBox(5),
          RatingAndPriceBadge(product: product),
          const Spacer(),
          PriceAndAddButtonRow(finalPrice: finalPrice, product: product),
        ],
      ),
    );
  }
}
