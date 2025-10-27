import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clothes_ecommerce_app/feature/order_details/presentation/view/widget/order_section_card.dart';
import 'package:clothes_ecommerce_app/feature/order_details/presentation/view/widget/order_item_card.dart';
import 'package:clothes_ecommerce_app/feature/order/domain/entities/order_entity.dart';

class OrderItemsSection extends StatelessWidget {
  final OrderEntity order;

  const OrderItemsSection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return OrderSectionCard(
      title: 'Order Items',
      icon: Icons.shopping_bag_outlined,
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: order.items.length,
          separatorBuilder: (context, index) => Divider(
            height: 24.h,
            color: Colors.grey[200],
          ),
          itemBuilder: (context, index) {
            final item = order.items[index];
            return OrderItemCard(item: item);
          },
        ),
      ],
    );
  }
}
