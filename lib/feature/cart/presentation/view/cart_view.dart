import 'package:clothes_ecommerce_app/core/di/app_providers.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/view/widget/cart_view_body.dart';
import 'package:flutter/material.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});
  @override
  Widget build(BuildContext context) {
    return AppProviders.blocProviderCartWithOrder(
      child: const Scaffold(
        body: CartViewBody(),
      ),
    );
  }
}
