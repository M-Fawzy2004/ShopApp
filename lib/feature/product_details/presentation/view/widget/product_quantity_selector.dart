import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/core/widget/circle_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductQuantitySelector extends StatelessWidget {
  const ProductQuantitySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.darkBlue,
        borderRadius: BorderRadius.circular(35.r),
      ),
      child: Row(
        children: [
          Text(
            'Quantity',
            style: AppStyles.font16BlackBold(context),
          ),
          const Spacer(),
          CircleIcon(
            onTap: () {},
            icon: Icons.add,
            color: AppColors.primaryColor,
            colorIcon: AppColors.white,
          ),
          widthBox(15),
          Text('1', style: AppStyles.font16BlackBold(context)),
          widthBox(15),
          CircleIcon(
            onTap: () {},
            icon: Icons.remove,
            color: AppColors.primaryColor,
            colorIcon: AppColors.white,
          ),
        ],
      ),
    );
  }
}
