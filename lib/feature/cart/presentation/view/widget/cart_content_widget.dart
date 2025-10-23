import 'package:clothes_ecommerce_app/core/helper/custom_snackbar.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/manager/cart_cubit/cart_state.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/view/widget/cart_item.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/view/widget/cart_summary_card.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/view/widget/empty_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartContentWidget extends StatelessWidget {
  final CartLoaded state;

  const CartContentWidget({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    if (state.products.isEmpty) {
      return const SliverFillRemaining(
        child: EmptyCartWidget(),
      );
    }

    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: state.products.map((product) {
                return CartItem(
                  product: product,
                  onDelete: () {
                    context.read<CartCubit>().removeProduct(product.id);
                    CustomSnackBar.show(
                      context,
                      message: 'Product removed',
                      type: SnackBarType.success,
                    );
                  },
                  onIncrement: () {
                    context.read<CartCubit>().updateQuantity(
                          product.id,
                          product.quantity + 1,
                        );
                  },
                  onDecrement: () {
                    context.read<CartCubit>().updateQuantity(
                          product.id,
                          product.quantity - 1,
                        );
                  },
                );
              }).toList(),
            ),
          ),
          heightBox(60),
          CartSummaryCard(
            totalItems: state.totalItems,
            totalPrice: state.totalPrice,
          ),
        ],
      ),
    );
  }
}
