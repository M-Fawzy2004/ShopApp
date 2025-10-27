import 'package:clothes_ecommerce_app/feature/order_details/presentation/view/widget/order_section_card.dart';
import 'package:clothes_ecommerce_app/feature/order_details/presentation/view/widget/summary_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/feature/order/domain/entities/order_entity.dart';

class OrderSummarySection extends StatelessWidget {
  final OrderEntity order;

  const OrderSummarySection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return OrderSectionCard(
      title: 'Order Summary',
      icon: Icons.receipt_long_outlined,
      children: [
        SummaryRow(label: 'Subtotal', amount: order.totalPrice),
        const SummaryRow(label: 'Delivery Fee', amount: 0),
        heightBox(8),
        Divider(color: Colors.grey[300], thickness: 1),
        heightBox(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style:
                  AppStyles.font16BlackBold(context).copyWith(fontSize: 18.sp),
            ),
            Text(
              '\$${order.totalPrice.toStringAsFixed(2)}',
              style: AppStyles.font16BlackBold(context).copyWith(
                fontSize: 20.sp,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
