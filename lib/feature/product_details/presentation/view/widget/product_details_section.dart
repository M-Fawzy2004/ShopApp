import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:clothes_ecommerce_app/feature/product_details/presentation/view/widget/product_info_section.dart';
import 'package:clothes_ecommerce_app/feature/product_details/presentation/view/widget/product_quantity_selector.dart';
import 'package:clothes_ecommerce_app/feature/product_details/presentation/view/widget/product_rating_row.dart';
import 'package:clothes_ecommerce_app/feature/product_details/presentation/view/widget/product_return_policy.dart';
import 'package:clothes_ecommerce_app/feature/product_details/presentation/view/widget/product_reviews_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsSection extends StatelessWidget {
  const ProductDetailsSection({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Rating
          ProductRatingRow(product: product),
          heightBox(20),
          // Product Quantity
          const ProductQuantitySelector(),
          heightBox(20),
          // Product Description
          Text(
            product.description,
            textAlign: TextAlign.left,
            style: AppStyles.font16BlackBold(context).copyWith(
              height: 1.5,
              color: const Color(0xff444444),
            ),
          ),
          heightBox(24),
          // Product Information Section
          ProductInfoSection(product: product),
          heightBox(24),
          // Return Policy
          ProductReturnPolicy(
            returnPolicy: product.returnPolicy,
          ),
          heightBox(24),
          // Product Reviews
          ProductReviewsSection(
            reviews: product.reviews,
          ),
          heightBox(20),
        ],
      ),
    );
  }
}
