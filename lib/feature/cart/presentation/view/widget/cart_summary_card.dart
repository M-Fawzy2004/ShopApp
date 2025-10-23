import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartSummaryCard extends StatelessWidget {
  const CartSummaryCard({
    super.key,
    required this.totalItems,
    required this.totalPrice,
  });

  final int totalItems;
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.regular),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Order Summary Header
          Row(
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                color: AppColors.primaryColor,
                size: 24.w,
              ),
              widthBox(8),
              Text(
                'Order Summary',
                style: AppStyles.font16BlackBold(context).copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          heightBox(20),
          // Total Items Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Items',
                style: AppStyles.font16BlackBold(context).copyWith(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.small),
                ),
                child: Text(
                  '$totalItems',
                  style: AppStyles.font16BlackBold(context).copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          heightBox(16),

          Divider(
            color: Colors.grey.withOpacity(0.3),
            thickness: 1,
          ),
          heightBox(16),

          // Total Price Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: AppStyles.font16BlackBold(context).copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '\$${totalPrice.toStringAsFixed(2)}',
                style: AppStyles.font16BlackBold(context).copyWith(
                  fontSize: 22.sp,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          heightBox(20),
          // Confirm Order Button
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.regular),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 22.w,
                    color: AppColors.white,
                  ),
                  widthBox(8),
                  Text(
                    'Confirm Order',
                    style: AppStyles.font16WhiteMedium(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
