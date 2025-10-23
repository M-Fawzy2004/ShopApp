import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            IconlyLight.bag_2,
            size: 120.sp,
            color: Colors.grey.withOpacity(0.5),
          ),
          heightBox(24),
          Text(
            'Shopping cart is empty',
            style: AppStyles.font16BlackBold(context).copyWith(
              fontSize: 20.sp,
            ),
          ),
          heightBox(12),
          Text(
            'Start adding products to your cart',
            style: AppStyles.font14greyBold(context),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
