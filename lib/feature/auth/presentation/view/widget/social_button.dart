import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialButton extends StatelessWidget {
  final String text;
  final String iconPath;
  final VoidCallback? onTap;

  const SocialButton({
    super.key,
    required this.text,
    required this.iconPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 45.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.large),
          color: AppColors.white,
        ),
        child: Row(
          children: [
            widthBox(20),
            Image.asset(
              iconPath,
              height: 25.h,
              width: 25.w,
              fit: BoxFit.contain,
            ),
            widthBox(70),
            Text(
              text,
              style: AppStyles.font16BlackMedium(context),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
