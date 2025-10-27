import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/view/widget/order_details_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderConfirmationForm extends StatelessWidget {
  const OrderConfirmationForm({
    super.key,
    required this.onConfirm,
  });

  final Function(String name, String governorate, String phoneNumber, String detailedAddress, String paymentMethod) onConfirm;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppRadius.large),
          topRight: Radius.circular(AppRadius.large),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          heightBox(20),
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: OrderDetailsForm(onConfirm: onConfirm),
            ),
          ),
        ],
      ),
    );
  }
}