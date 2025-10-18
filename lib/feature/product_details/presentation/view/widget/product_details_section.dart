import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:clothes_ecommerce_app/feature/product_details/presentation/view/widget/product_info_section.dart';
import 'package:clothes_ecommerce_app/feature/product_details/presentation/view/widget/product_quantity_selector.dart';
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
          // Product Quantity
          const ProductQuantitySelector(),
          heightBox(20),
          // Product Description
          Text(
            product.description,
            textAlign: TextAlign.left,
            style: AppStyles.font16BlackBold(context),
          ),
          heightBox(24),
          // Product Information Section
          ProductInfoSection(product: product),
          heightBox(20),
        ],
      ),
    );
  }
}
