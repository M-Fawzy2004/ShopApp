import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/manager/product_cubit/product_state.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/product_card.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/product_skeleton_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductSectionListView extends StatelessWidget {
  final ProductState state;
  final ScrollController scrollController;

  const ProductSectionListView({
    super.key,
    required this.state,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    if (state is ProductLoading) {
      return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (_, __) => widthBox(15),
        itemBuilder: (_, __) => const ProductSkeletonLoader(),
      );
    }

    if (state is ProductLoaded || state is ProductLoadingMore) {
      final products = state is ProductLoaded
          ? (state as ProductLoaded).products
          : (state as ProductLoadingMore).currentProducts;

      final hasMore =
          state is ProductLoaded ? (state as ProductLoaded).hasMoreData : true;

      return ListView.builder(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: products.length + (hasMore && products.length > 5 ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == products.length) {
            return const ProductSkeletonLoader();
          }
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 15.w : 0,
              right: 15.w,
            ),
            child: ProductCard(product: products[index]),
          );
        },
      );
    }

    return const SizedBox.shrink();
  }
}
