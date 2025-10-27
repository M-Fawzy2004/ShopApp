import 'package:clothes_ecommerce_app/core/helper/get_color_status.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/widget/circle_icon.dart';
import 'package:clothes_ecommerce_app/feature/order/domain/entities/order_entity.dart';
import 'package:clothes_ecommerce_app/feature/order_details/presentation/view/widget/delivery_information_section.dart';
import 'package:clothes_ecommerce_app/feature/order_details/presentation/view/widget/order_details_info_row.dart';
import 'package:clothes_ecommerce_app/feature/order_details/presentation/view/widget/order_items_section.dart';
import 'package:clothes_ecommerce_app/feature/order_details/presentation/view/widget/order_section_card.dart';
import 'package:clothes_ecommerce_app/feature/order_details/presentation/view/widget/order_status_header.dart';
import 'package:clothes_ecommerce_app/feature/order_details/presentation/view/widget/order_summary_section.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailsViewBody extends StatelessWidget {
  const OrderDetailsViewBody({super.key, required this.order});
  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleIcon(),
          heightBox(15),
          // Order Status Card
          OrderStatusHeader(
            status: order.status,
            orderId: order.id ?? '',
            getStatusColor: () => getStatusColor(order.status),
          ),
          heightBox(24),
          // Delivery Information
          DeliveryInformationSection(order: order),
          heightBox(16),
          // Payment Information
          OrderSectionCard(
            title: 'Payment Information',
            icon: Icons.payment_outlined,
            children: [
              OrderDetailsInfoRow(
                label: 'Method',
                value: order.paymentMethod == 'cash_on_delivery'
                    ? 'Cash on Delivery'
                    : 'Stripe Payment',
              ),
              OrderDetailsInfoRow(
                label: 'Date',
                value: DateFormat('MMM dd, yyyy - hh:mm a')
                    .format(order.createdAt ?? DateTime.now()),
              ),
            ],
          ),
          heightBox(16),
          // Order Items
          OrderItemsSection(order: order),
          heightBox(16),
          // Order Summary
          OrderSummarySection(order: order),
          heightBox(24),
        ],
      ),
    );
  }
}
