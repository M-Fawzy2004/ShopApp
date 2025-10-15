import 'package:clothes_ecommerce_app/core/helper/custom_loading_widget.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final double? borderRadius;
  final Color? textColor;
  final double? height;
  final double? width;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? elevation;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.primaryColor,
    this.borderRadius,
    this.textColor = Colors.white,
    this.height,
    this.width,
    this.fontSize,
    this.fontWeight = FontWeight.w600,
    this.elevation = 1,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 45.h,
        decoration: BoxDecoration(
          color:
              isLoading ? backgroundColor?.withOpacity(0.6) : backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 30.r),
          boxShadow: elevation != null && elevation! > 0
              ? [
                  BoxShadow(
                    color: backgroundColor!.withOpacity(0.3),
                    blurRadius: elevation! * 2,
                    offset: Offset(0, elevation!),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: isLoading
              ? const CustomLoadingWidget()
              : Text(
                  text,
                  style: AppStyles.font16WhiteMedium(context).copyWith(
                    color: textColor,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                  ),
                ),
        ),
      ),
    );
  }
}
