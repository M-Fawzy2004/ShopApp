import 'package:clothes_ecommerce_app/core/helper/app_router.dart';
import 'package:clothes_ecommerce_app/core/helper/custom_loading_widget.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/manager/search_cubit/search_cubit.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SearchResultsSection extends StatelessWidget {
  const SearchResultsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomLoadingWidget(),
                  heightBox(10),
                  Text(
                    'Searching...',
                    style: AppStyles.font14BlackBold(context),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is SearchEmpty) {
          return SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 80.sp, color: Colors.grey),
                  heightBox(20),
                  Text(
                    'No products found',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  heightBox(8),
                  Text(
                    'Try searching with different keywords',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is SearchError) {
          return SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 80.sp, color: Colors.red),
                  heightBox(20),
                  Text(
                    state.message,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        if (state is SearchLoaded || state is SearchLoadingMore) {
          final products = state is SearchLoaded
              ? state.products
              : (state as SearchLoadingMore).currentProducts;

          return SliverPadding(
            padding: EdgeInsets.all(16.w),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.5,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == products.length && state is SearchLoadingMore) {
                    return const Center(
                      child: CustomLoadingWidget(),
                    );
                  }

                  if (index >= products.length) return null;

                  return GestureDetector(
                    onTap: () {
                      context.push(
                        AppRouter.productDetailsView,
                        extra: products[index],
                      );
                    },
                    child: ProductCard(
                      product: products[index],
                    ),
                  );
                },
                childCount:
                    products.length + (state is SearchLoadingMore ? 1 : 0),
              ),
            ),
          );
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
