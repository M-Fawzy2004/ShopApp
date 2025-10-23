import 'package:clothes_ecommerce_app/core/helper/app_router.dart';
import 'package:clothes_ecommerce_app/core/helper/custom_loading_widget.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/core/widget/custom_search_field.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/manager/search_cubit/search_cubit.dart';
import 'package:clothes_ecommerce_app/feature/home/presentation/view/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SearchHomeView extends StatefulWidget {
  const SearchHomeView({super.key});

  @override
  State<SearchHomeView> createState() => _SearchHomeViewState();
}

class _SearchHomeViewState extends State<SearchHomeView> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      context.read<SearchCubit>().loadMoreSearchResults();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Products',
          style: AppStyles.font16BlackBold(context),
        ),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: CustomSearchField(
              hintText: 'Search for any product...',
              onChanged: (value) {
                if (value.isNotEmpty) {
                  context.read<SearchCubit>().searchProducts(value);
                } else {
                  context.read<SearchCubit>().clearSearch();
                }
              },
            ),
          ),
        ),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchInitial) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, size: 80.sp, color: Colors.grey),
                  heightBox(20),
                  Text(
                    'Start searching for products',
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          if (state is SearchLoading) {
            return const Center(
              child: CustomLoadingWidget(),
            );
          }

          if (state is SearchEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 80.sp, color: Colors.grey),
                  heightBox(20),
                  Text(
                    'No products found',
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          if (state is SearchError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(fontSize: 16.sp, color: Colors.red),
              ),
            );
          }

          if (state is SearchLoaded || state is SearchLoadingMore) {
            final products = state is SearchLoaded
                ? state.products
                : (state as SearchLoadingMore).currentProducts;

            return GridView.builder(
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              padding: EdgeInsets.all(16.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.5,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
              ),
              itemCount: products.length + (state is SearchLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == products.length) {
                  return const Center(
                    child: CustomLoadingWidget(),
                  );
                }
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
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
