import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/helper/extension.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/feature/order/domain/entities/order_entity.dart';
import 'package:clothes_ecommerce_app/feature/order_details/presentation/view/order_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});

  final OrderEntity order;

  Color _getStatusColor() {
    switch (order.status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.blue;
      case 'shipped':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(AppRadius.regular),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.regular),
          onTap: () {
            context.navigateWithSlideTransition(
              OrderDetailsView(order: order),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order #${order.id?.substring(0, 8) ?? ''}',
                      style: AppStyles.font16BlackBold(context),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: _getStatusColor().withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppRadius.small),
                      ),
                      child: Text(
                        order.status.toUpperCase(),
                        style: AppStyles.font13BlackMedium(context).copyWith(
                          color: _getStatusColor(),
                        ),
                      ),
                    ),
                  ],
                ),
                heightBox(12),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 16.sp,
                      color: AppColors.primaryColor,
                    ),
                    widthBox(8),
                    Text(
                      DateFormat('MMM dd, yyyy')
                          .format(order.createdAt ?? DateTime.now()),
                      style: AppStyles.font13GreyMedium(context),
                    ),
                  ],
                ),
                heightBox(8),
                Row(
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 16.sp,
                      color: AppColors.primaryColor,
                    ),
                    widthBox(8),
                    Text(
                      '${order.totalQuantity} items',
                      style: AppStyles.font13GreyMedium(context),
                    ),
                  ],
                ),
                heightBox(12),
                Divider(color: Colors.grey[400]),
                heightBox(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: AppStyles.font13BlackMedium(context),
                    ),
                    Text(
                      '\$${order.totalPrice.toStringAsFixed(2)}',
                      style: AppStyles.font16BlackBold(context).copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
