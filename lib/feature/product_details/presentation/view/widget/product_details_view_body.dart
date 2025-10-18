import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:clothes_ecommerce_app/feature/product_details/presentation/view/widget/product_details_header.dart';
import 'package:clothes_ecommerce_app/feature/product_details/presentation/view/widget/product_details_section.dart';
import 'package:flutter/material.dart';

class ProductDetailsViewBody extends StatelessWidget {
  const ProductDetailsViewBody({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // Product Details Header
          ProductDetailsHeader(product: product),
          // height
          heightBox(40),
          // Product Details Section
          ProductDetailsSection(product: product),
        ],
      ),
    );
  }
}
