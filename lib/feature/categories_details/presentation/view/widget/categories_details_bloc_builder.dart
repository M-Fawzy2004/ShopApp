import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/feature/categories_details/presentation/view/widget/categorey_product_card.dart';
import 'package:clothes_ecommerce_app/feature/categories_details/presentation/view/widget/categories_product_skeleton_loader.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/category_entity.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/manager/product_cubit/product_cubit.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/manager/product_cubit/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesDetailsBlocBuilder extends StatefulWidget {
  const CategoriesDetailsBlocBuilder({super.key, required this.category});

  final CategoryEntity category;

  @override
  State<CategoriesDetailsBlocBuilder> createState() =>
      _CategoriesDetailsBlocBuilderState();
}

class _CategoriesDetailsBlocBuilderState
    extends State<CategoriesDetailsBlocBuilder> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().getProductsByCategory(widget.category.slug);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      context.read<ProductCubit>().loadMoreProducts();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return CategoriesProductSkeletonLoader(
              category: widget.category,
              itemCount: 10,
            );
          }

          if (state is ProductError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  heightBox(15),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<ProductCubit>()
                          .getProductsByCategory(widget.category.slug);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is ProductLoaded || state is ProductLoadingMore) {
            final products = state is ProductLoaded
                ? state.products
                : (state as ProductLoadingMore).currentProducts;

            if (products.isEmpty) {
              return const Center(
                child: Text('No products found'),
              );
            }

            return ListView.builder(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              itemCount:
                  products.length + (state is ProductLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == products.length) {
                  return CategoriesProductSkeletonLoader(
                    category: widget.category,
                    itemCount: 10,
                  );
                }

                return CategoreyProductCard(
                  product: products[index],
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
