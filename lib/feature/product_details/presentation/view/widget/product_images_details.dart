import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/widget/custom_cached_image.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImagesDetails extends StatefulWidget {
  const ProductImagesDetails({super.key, required this.product});

  final ProductEntity product;

  @override
  State<ProductImagesDetails> createState() => _ProductImagesDetailsState();
}

class _ProductImagesDetailsState extends State<ProductImagesDetails> {
  int selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final images = widget.product.images;

    if (images.length == 1) {
      return _buildSingleImage(images[0]);
    }

    return Column(
      children: [
        _buildMainImage(images[selectedImageIndex]),
        SizedBox(height: 16.h),
        _buildThumbnails(images),
      ],
    );
  }

  Widget _buildSingleImage(String imageUrl) {
    return CustomCachedImage(
      imageUrl: imageUrl,
      height: 220.h,
      width: double.infinity,
      fit: BoxFit.contain,
    );
  }

  Widget _buildMainImage(String imageUrl) {
    return CustomCachedImage(
      imageUrl: imageUrl,
      height: 220.h,
      width: double.infinity,
      fit: BoxFit.contain,
    );
  }

  Widget _buildThumbnails(List<String> images) {
    return SizedBox(
      height: 70.h,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        itemCount: images.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedImageIndex;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedImageIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              width: 60.w,
              height: 60.w,
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.lightGrey : Colors.transparent,
                border: Border.all(
                  color:
                      isSelected ? AppColors.primaryColor : Colors.grey[300]!,
                  width: isSelected ? 2.5 : 1.5,
                ),
                borderRadius: BorderRadius.circular(AppRadius.regular),
              ),
              child: CustomCachedImage(
                imageUrl: images[index],
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(AppRadius.small),
                showShimmer: false,
              ),
            ),
          );
        },
      ),
    );
  }
}
