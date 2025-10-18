import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';

class CircleIcon extends StatelessWidget {
  const CircleIcon({
    super.key,
    this.icon,
    this.onTap,
    this.color,
    this.colorIcon,
  });

  final IconData? icon;
  final void Function()? onTap;
  final Color? color;
  final Color? colorIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            context.pop();
          },
      child: Container(
        width: 45.w,
        height: 45.w,
        decoration: BoxDecoration(
          color: color ?? AppColors.white,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            icon ?? Icons.arrow_back_ios_new,
            color: colorIcon ?? AppColors.black,
            size: 20.sp,
          ),
        ),
      ),
    );
  }
}
