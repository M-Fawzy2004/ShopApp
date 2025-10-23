import 'package:clothes_ecommerce_app/core/di/get_it_service.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:clothes_ecommerce_app/feature/product_details/presentation/view/widget/product_bottom_bar.dart';
import 'package:clothes_ecommerce_app/feature/product_details/presentation/view/widget/product_details_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.product});

  final ProductEntity product;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  int quantity = 1;

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<CartCubit>(),
      child: Scaffold(
        body: ProductDetailsViewBody(
          product: widget.product,
          quantity: quantity,
          onIncrement: _incrementQuantity,
          onDecrement: _decrementQuantity,
        ),
        bottomNavigationBar: ProductBottomBar(
          product: widget.product,
          quantity: quantity,
        ),
      ),
    );
  }
}