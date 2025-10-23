import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/helper/app_router.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/feature/categories_details/presentation/view/widget/product_details_card_content.dart';
import 'package:clothes_ecommerce_app/feature/categories_details/presentation/view/widget/product_image_slider.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CategoreyProductCard extends StatelessWidget {
  final ProductEntity product;

  const CategoreyProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRouter.productDetailsView, extra: product);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        height: 140.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.regular),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Product Images
            ProductImagesSlider(product: product),
            // Product Details
            Expanded(
              child: ProductDetailsCardContent(product: product),
            ),
          ],
        ),
      ),
    );
  }
}
