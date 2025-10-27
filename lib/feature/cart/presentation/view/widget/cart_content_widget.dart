import 'package:clothes_ecommerce_app/core/helper/custom_snackbar.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/manager/cart_cubit/cart_state.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/view/widget/cart_item.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/view/widget/empty_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartContentWidget extends StatelessWidget {
  final CartLoaded state;
  final bool showSummaryCard;

  const CartContentWidget({
    super.key,
    required this.state,
    this.showSummaryCard = true,
  });

  @override
  Widget build(BuildContext context) {
    if (state.products.isEmpty) {
      return const SliverFillRemaining(
        child: EmptyCartWidget(),
      );
    }

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final product = state.products[index];
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
          },
          childCount: state.products.length,
        ),
      ),
    );
  }
}
