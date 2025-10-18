import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductTitleCard extends StatelessWidget {
  const ProductTitleCard({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 50.h),
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 16.w,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.regular),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        product.title,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppStyles.font16BlackBold(context).copyWith(
          height: 1.3,
        ),
      ),
    );
  }
}
