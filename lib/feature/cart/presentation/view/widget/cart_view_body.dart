import 'package:clothes_ecommerce_app/core/di/app_providers.dart';
import 'package:clothes_ecommerce_app/core/helper/custom_loading_widget.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/manager/cart_cubit/cart_state.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/view/widget/cart_app_bar.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/view/widget/cart_bottom_bar.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/view/widget/cart_content_widget.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/view/widget/favourites_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartViewBody extends StatefulWidget {
  const CartViewBody({super.key});

  @override
  State<CartViewBody> createState() => _CartViewBodyState();
}

class _CartViewBodyState extends State<CartViewBody> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AppProviders.blocProviderCart(
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading && selectedTabIndex == 0) {
            return const Center(
              child: CustomLoadingWidget(),
            );
          }
          if (state is CartError && selectedTabIndex == 0) {
            return Center(
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
                    state.message,
                    style: AppStyles.font16BlackBold(context).copyWith(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    CartAppBar(
                      selectedIndex: selectedTabIndex,
                      onTabChanged: (index) {
                        setState(() {
                          selectedTabIndex = index;
                        });
                      },
                    ),
                    SliverToBoxAdapter(child: heightBox(10)),
                    if (selectedTabIndex == 0)
                      state is CartLoaded
                          ? CartContentWidget(
                              state: state,
                              showSummaryCard: false,
                            )
                          : const SliverToBoxAdapter(child: SizedBox.shrink())
                    else
                      const FavouritesContentWidget(),
                    // Add bottom padding to prevent content from being hidden behind bottom bar
                    SliverToBoxAdapter(child: heightBox(50)),
                  ],
                ),
              ),
              if (selectedTabIndex == 0 && state is CartLoaded)
                CartBottomBar(
                  totalItems: state.totalItems,
                  totalPrice: state.totalPrice,
                ),
            ],
          );
        },
      ),
    );
  }
}
