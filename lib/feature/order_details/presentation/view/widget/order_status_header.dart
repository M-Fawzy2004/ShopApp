import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';

class OrderStatusHeader extends StatelessWidget {
  final String status;
  final String orderId;
  final Color Function() getStatusColor;

  const OrderStatusHeader({
    super.key,
    required this.status,
    required this.orderId,
    required this.getStatusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            getStatusColor(),
            getStatusColor().withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.regular),
      ),
      child: Column(
        children: [
          Icon(Icons.check_circle_outline, size: 60.sp, color: Colors.white),
          heightBox(12),
          Text(
            status.toUpperCase(),
            style: AppStyles.font16BlackBold(context).copyWith(
              color: Colors.white,
              fontSize: 20.sp,
            ),
          ),
          heightBox(8),
          Text(
            'Order #${orderId.substring(0, 8)}',
            style: AppStyles.font13BlackMedium(context).copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}
