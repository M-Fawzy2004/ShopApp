import 'package:clothes_ecommerce_app/core/di/app_providers.dart';
import 'package:clothes_ecommerce_app/feature/order/presentation/view/widget/order_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key, this.orderId});

  final String? orderId;

  @override
  Widget build(BuildContext context) {
    return AppProviders.blocProviderOrder(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: OrderViewBody(orderId: orderId),
          ),
        ),
      ),
    );
  }
}
