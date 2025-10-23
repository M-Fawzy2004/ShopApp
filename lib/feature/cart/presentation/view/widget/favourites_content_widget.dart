import 'package:clothes_ecommerce_app/core/helper/custom_loading_widget.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/manager/favorites_cubit/favorites_cubit.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/manager/favorites_cubit/favorites_state.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/view/widget/favorite_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouritesContentWidget extends StatelessWidget {
  const FavouritesContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoading) {
          return const SliverFillRemaining(
            child: Center(child: CustomLoadingWidget()),
          );
        }

        if (state is FavoritesError) {
          return _buildErrorState(context, state.message);
        }

        if (state is FavoritesLoaded) {
          if (state.favorites.isEmpty) {
            return _buildEmptyState(context);
          }

          return _buildFavoritesList(state);
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80.sp,
              color: Colors.red,
            ),
            heightBox(16),
            Text(
              message,
              style: AppStyles.font16BlackBold(context).copyWith(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite_border,
                size: 100.sp,
                color: Colors.grey.shade400,
              ),
              heightBox(24),
              Text(
                'No Favourites Yet',
                style: AppStyles.font16BlackBold(context).copyWith(
                  fontSize: 20.sp,
                ),
              ),
              heightBox(12),
              Text(
                'Start adding your favorite items to see them here',
                textAlign: TextAlign.center,
                style: AppStyles.font12BlackBold(context).copyWith(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFavoritesList(FavoritesLoaded state) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final product = state.favorites[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: FavoriteProductCard(product: product),
            );
          },
          childCount: state.favorites.length,
        ),
      ),
    );
  }
}