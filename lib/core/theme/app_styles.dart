import 'package:clothes_ecommerce_app/core/helper/font_weight_helper.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyles {
  static TextStyle font32BlackBold(BuildContext context) => TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.black,
      );

  static TextStyle font16greyBold(BuildContext context) => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.darkGrey,
      );

  static TextStyle font16BlackBold(BuildContext context) => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.black,
      );

  static TextStyle font16BlackMedium(BuildContext context) => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.dark,
      );

  static TextStyle font16WhiteMedium(BuildContext context) => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.white,
      );

  static TextStyle font14WhiteMedium(BuildContext context) => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.white,
      );

  static TextStyle font12BlackMedium(BuildContext context) => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.black,
      );

  static TextStyle font14BlackMedium(BuildContext context) => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.black,
      );

  static TextStyle font12BlackBold(BuildContext context) => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.black,
      );

  static TextStyle font12GreyBold(BuildContext context) => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.darkGrey,
      );

  static TextStyle font12WhiteBold(BuildContext context) => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.white,
      );

  static TextStyle font24BlackMedium(BuildContext context) => TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.black,
      );
}
