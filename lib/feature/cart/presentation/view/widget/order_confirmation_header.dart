import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderConfirmationHeader extends StatelessWidget {
  const OrderConfirmationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.small),
          ),
          child: Icon(
            Icons.assignment_outlined,
            color: AppColors.primaryColor,
            size: 24.w,
          ),
        ),
        widthBox(12),
        Text(
          'Order Confirmation',
          style: AppStyles.font16BlackBold(context).copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
