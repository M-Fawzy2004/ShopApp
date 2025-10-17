import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceAndAddButtonRow extends StatelessWidget {
  const PriceAndAddButtonRow({super.key, required this.finalPrice});

  final double finalPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "\$${finalPrice.toStringAsFixed(2)}",
              style: AppStyles.font16BlackBold(context),
            ),
            const Spacer(),
            Container(
              width: 36.w,
              height: 36.h,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(AppRadius.large),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
