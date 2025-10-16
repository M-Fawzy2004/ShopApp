import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/utils/assets.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/home_header_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAppBarSection extends StatelessWidget {
  const HomeAppBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isExpanded = constraints.maxHeight > 150.h;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppRadius.large),
                bottomRight: Radius.circular(AppRadius.large),
              ),
              child: Image.asset(
                Assets.imagesPngImageAppbar,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            if (isExpanded)
              Positioned(
                top: 55.h,
                left: 16.w,
                right: 16.w,
                child: const HomeHeaderCard(),
              ),
          ],
        );
      },
    );
  }
}
