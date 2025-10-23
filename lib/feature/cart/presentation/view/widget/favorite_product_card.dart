import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/helper/custom_snackbar.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/feature/cart/data/model/product_model.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/manager/favorites_cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

class FavoriteProductCard extends StatelessWidget {
  const FavoriteProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(AppRadius.regular),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildImageSection(context),
          Expanded(
            child: _buildProductDetails(context),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.horizontal(left: Radius.circular(12.r)),
          child: Image.network(
            product.image,
            width: 110.w,
            height: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 110.w,
                height: double.infinity,
                color: AppColors.dark.withOpacity(0.1),
                child: Icon(
                  Icons.image_not_supported_outlined,
                  size: 40.sp,
                  color: AppColors.dark.withOpacity(0.5),
                ),
              );
            },
          ),
        ),
        Positioned(
          top: 8.h,
          left: 8.w,
          child: _buildFavoriteButton(context),
        ),
      ],
    );
  }

  Widget _buildFavoriteButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<FavoritesCubit>().removeFromFavorites(product.id);
        CustomSnackBar.show(
          context,
          message: 'Removed from favorites',
          type: SnackBarType.success,
        );
      },
      child: Container(
        padding: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          IconlyBold.heart,
          color: Colors.red,
          size: 16.sp,
        ),
      ),
    );
  }

  Widget _buildProductDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          product.name,
          style: AppStyles.font14BlackBold(context),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        heightBox(6),
        Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: AppStyles.font16BlackBold(context).copyWith(
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
