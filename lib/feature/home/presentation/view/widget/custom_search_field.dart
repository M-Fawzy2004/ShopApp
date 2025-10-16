import 'dart:ui';

import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({super.key, this.onChanged, this.onTap});
  final Function(String)? onChanged;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.large),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Container(
          height: 45.h,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(AppRadius.large),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5.w,
            ),
          ),
          child: TextFormField(
            onTap: onTap,
            onChanged: onChanged,
            style: AppStyles.font16BlackBold(context),
            decoration: InputDecoration(
              hintText: 'Search for products...',
              hintStyle: TextStyle(
                color: Colors.black54,
                fontSize: 14.sp,
              ),
              prefixIcon: const Icon(
                IconlyBold.search,
                color: Colors.black54,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.large),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.large),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
