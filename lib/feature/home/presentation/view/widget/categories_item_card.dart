import 'package:clothes_ecommerce_app/core/helper/custom_loading_widget.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesItemCard extends StatelessWidget {
  final CategoryEntity category;

  const CategoriesItemCard({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            height: 65.h,
            width: 65.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.r),
              child: Image.network(
                category.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CustomLoadingWidget(),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    child: Icon(
                      Icons.image_not_supported,
                      color: AppColors.primaryColor,
                      size: 24.sp,
                    ),
                  );
                },
              ),
            ),
          ),
          heightBox(5),
          SizedBox(
            width: 65.w,
            child: Text(
              category.name,
              style: AppStyles.font13BlackMedium(context),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
