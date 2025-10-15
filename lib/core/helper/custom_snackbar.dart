import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum SnackBarType { success, error, info }

class CustomSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    required SnackBarType type,
  }) {
    late Color bgColor;
    late IconData icon;
    late String title;

    switch (type) {
      case SnackBarType.success:
        bgColor = AppColors.primaryColor;
        icon = Icons.check_circle_outline;
        title = 'Success';
        break;
      case SnackBarType.error:
        bgColor = AppColors.error;
        icon = Icons.error_outline;
        title = 'Error';
        break;
      case SnackBarType.info:
        bgColor = AppColors.darkGrey;
        icon = Icons.info_outline;
        title = 'Info';
        break;
    }

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutBack,
        builder: (context, value, child) => Transform.scale(
          scale: value,
          child: child,
        ),
        child: Container(
          padding:  EdgeInsets.all(14.sp),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(AppRadius.medium),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 28.sp),
              widthBox(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: AppStyles.font14WhiteMedium(context),
                    ),
                    heightBox(2),
                    Text(
                      message,
                      style: AppStyles.font12WhiteBold(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
