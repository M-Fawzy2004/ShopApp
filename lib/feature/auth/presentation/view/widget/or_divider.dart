import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            height: 1,
            color: AppColors.darkGrey,
          ),
        ),
        widthBox(10),
        Text(
          'OR',
          style: AppStyles.font12GreyBold(context),
        ),
        widthBox(10),
        const Expanded(
          child: Divider(
            height: 1,
            color: AppColors.darkGrey,
          ),
        ),
      ],
    );
  }
}
