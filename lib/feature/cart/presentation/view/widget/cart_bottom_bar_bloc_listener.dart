import 'package:clothes_ecommerce_app/core/helper/app_router.dart';
import 'package:clothes_ecommerce_app/core/helper/custom_snackbar.dart';
import 'package:clothes_ecommerce_app/feature/cart/data/model/product_model.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/view/widget/cart_bottom_bar.dart';
import 'package:clothes_ecommerce_app/feature/order/presentation/manager/order_cubit/order_cubit.dart';
import 'package:clothes_ecommerce_app/feature/order/presentation/manager/order_cubit/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartBottomBarBlocListener extends StatelessWidget {
  const CartBottomBarBlocListener({
    super.key,
    required this.totalItems,
    required this.totalPrice,
    required this.products,
  });

  final int totalItems;
  final double totalPrice;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state is OrderCreated) {
          context.read<CartCubit>().clearCart();

          CustomSnackBar.show(
            context,
            message: 'Order placed successfully!',
            type: SnackBarType.success,
          );

          // Navigate to order detailss
          context.push(
            AppRouter.orderView,
            extra: state.order.id,
          );
        } else if (state is OrderError) {
          CustomSnackBar.show(
            context,
            message: state.message,
            type: SnackBarType.error,
          );
        }
      },
      child: CartBottomBar(
        totalItems: totalItems,
        totalPrice: totalPrice,
        products: products,
      ),
    );
  }
}
