import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum PaymentMethod { cashOnDelivery, stripe }

class PaymentMethodSelector extends StatelessWidget {
  const PaymentMethodSelector({
    super.key,
    required this.selectedMethod,
    required this.onMethodChanged,
  });

  final PaymentMethod selectedMethod;
  final ValueChanged<PaymentMethod> onMethodChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: AppStyles.font16BlackBold(context).copyWith(
            fontSize: 13.sp,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        heightBox(12),
        _buildPaymentOption(
          context: context,
          icon: Icons.money,
          title: 'Cash on Delivery',
          method: PaymentMethod.cashOnDelivery,
        ),
        heightBox(12),
        _buildPaymentOption(
          context: context,
          icon: Icons.credit_card,
          title: 'Stripe Payment',
          method: PaymentMethod.stripe,
        ),
      ],
    );
  }

  Widget _buildPaymentOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required PaymentMethod method,
  }) {
    final isSelected = selectedMethod == method;

    return GestureDetector(
      onTap: () => onMethodChanged(method),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor.withOpacity(0.1)
              : Colors.grey[100],
          borderRadius: BorderRadius.circular(AppRadius.regular),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : Colors.grey.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20.w,
              color: isSelected ? AppColors.primaryColor : Colors.grey[600],
            ),
            widthBox(12),
            Expanded(
              child: Text(
                title,
                style: AppStyles.font16BlackBold(context).copyWith(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? AppColors.primaryColor : Colors.grey[800],
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                size: 20.w,
                color: AppColors.primaryColor,
              ),
          ],
        ),
      ),
    );
  }
}
