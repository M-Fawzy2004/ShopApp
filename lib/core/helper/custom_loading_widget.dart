import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoadingWidget extends StatelessWidget {
  final double? height;
  final Color? color;

  const CustomLoadingWidget({
    super.key,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final double effectiveHeight = height ?? 20.h;
    final Color effectiveColor = color ?? AppColors.primaryColor;
    return Center(
      child: LoadingAnimationWidget.inkDrop(
        color: effectiveColor,
        size: effectiveHeight,
      ),
    );
  }
}
