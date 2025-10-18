import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:clothes_ecommerce_app/feature/product_details/presentation/view/widget/product_images_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImagesHeader extends StatelessWidget {
  const ProductImagesHeader({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppRadius.large),
          bottomRight: Radius.circular(AppRadius.large),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppRadius.large),
          bottomRight: Radius.circular(AppRadius.large),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(bottom: 35.h),
            child: ProductImagesDetails(product: product),
          ),
        ),
      ),
    );
  }
}
