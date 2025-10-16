import 'dart:ui';

import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeaderCard extends StatelessWidget {
  const HomeHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.medium),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 10.h,
          ),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(AppRadius.large),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 26.r,
                backgroundImage: const AssetImage(
                  Assets.imagesPngMofawzy,
                ),
              ),
              widthBox(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'W E L C O M E!',
                    style: AppStyles.font14BlackMedium(context),
                  ),
                  Text(
                    'Mohamed Fawzy',
                    style: AppStyles.font16BlackBold(context),
                  ),
                ],
              ),
              const Spacer(),
              Image.asset(
                Assets.imagesIconNotificationIcon,
                color: AppColors.black,
              ),
              widthBox(10),
            ],
          ),
        ),
      ),
    );
  }
}
