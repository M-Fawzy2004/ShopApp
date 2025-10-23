import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';

class ProductReturnPolicy extends StatelessWidget {
  const ProductReturnPolicy({
    super.key,
    required this.returnPolicy,
  });

  final String returnPolicy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(AppRadius.regular),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 2.w,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: const Color(0xFF666666),
            size: 24.sp,
          ),
          widthBox(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Return Policy',
                  style: AppStyles.font16BlackBold(context),
                ),
                heightBox(4),
                Text(
                  returnPolicy,
                  style: AppStyles.font12GreyBold(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
