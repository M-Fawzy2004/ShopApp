import 'package:clothes_ecommerce_app/core/widget/icon_back.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:clothes_ecommerce_app/feature/product_details/presentation/view/widget/product_images_header.dart';
import 'package:clothes_ecommerce_app/feature/product_details/presentation/view/widget/product_title_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

class ProductDetailsHeader extends StatelessWidget {
  const ProductDetailsHeader({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ProductImagesHeader(product: product),
        Positioned(
          top: 40.h,
          left: 16.w,
          child: const IconBack(),
        ),
        Positioned(
          top: 40.h,
          right: 16.w,
          child: const IconBack(
            icon: IconlyLight.heart,
          ),
        ),
        Positioned(
          bottom: -25.h,
          right: 30.w,
          left: 30.w,
          child: ProductTitleCard(product: product),
        ),
      ],
    );
  }
}
