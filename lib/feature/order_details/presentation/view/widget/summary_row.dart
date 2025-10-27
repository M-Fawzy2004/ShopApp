import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';

class SummaryRow extends StatelessWidget {
  final String label;
  final double amount;

  const SummaryRow({
    super.key,
    required this.label,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppStyles.font13BlackMedium(context).copyWith(
              color: Colors.grey[600],
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: AppStyles.font13BlackMedium(context),
          ),
        ],
      ),
    );
  }
}
