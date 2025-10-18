import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/helper/custom_loading_widget.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.product, this.fit, this.height});

  final ProductEntity product;
  final BoxFit? fit;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: product.thumbnail,
      height: height ?? 140.h,
      width: double.infinity,
      fit: fit ?? BoxFit.cover,
      placeholder: (context, url) => Container(
        height: 140.h,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(AppRadius.medium),
        ),
        child: const Center(
          child: CustomLoadingWidget(),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        height: 140.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: const Center(
          child: Icon(
            Icons.image_not_supported_outlined,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
