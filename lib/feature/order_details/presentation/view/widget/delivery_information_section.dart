import 'package:flutter/material.dart';
import 'package:clothes_ecommerce_app/feature/order/domain/entities/order_entity.dart';
import 'package:clothes_ecommerce_app/feature/order_details/presentation/view/widget/order_section_card.dart';
import 'package:clothes_ecommerce_app/feature/order_details/presentation/view/widget/order_details_info_row.dart';

class DeliveryInformationSection extends StatelessWidget {
  final OrderEntity order;

  const DeliveryInformationSection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return OrderSectionCard(
      title: 'Delivery Information',
      icon: Icons.local_shipping_outlined,
      children: [
        OrderDetailsInfoRow(
          label: 'Name',
          value: order.fullName,
        ),
        OrderDetailsInfoRow(
          label: 'Phone',
          value: order.phoneNumber,
        ),
        OrderDetailsInfoRow(
          label: 'Governorate',
          value: order.governorate,
        ),
        OrderDetailsInfoRow(
          label: 'Address',
          value: order.detailedAddress,
        ),
      ],
    );
  }
}
