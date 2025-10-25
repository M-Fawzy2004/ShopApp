import 'package:clothes_ecommerce_app/core/helper/custom_snackbar.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/feature/cart/data/model/product_model.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/manager/favorites_cubit/favorites_cubit.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/manager/favorites_cubit/favorites_state.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

class ProductPriceAndActionsRow extends StatelessWidget {
  const ProductPriceAndActionsRow({super.key, required this.product});

  final ProductEntity product;
  Product _convertToProductModel() {
    return Product(
      id: product.id.toString(),
      name: product.title,
      price: product.price,
      image: product.thumbnail,
      quantity: 1,
      isFavorite: false,
      isInCart: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final productModel = _convertToProductModel();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '\$${product.price.toStringAsFixed(0)}',
          style: AppStyles.font16BlackBold(context).copyWith(
            fontSize: 18.sp,
            color: AppColors.primaryColor,
          ),
        ),
        Row(
          children: [
            BlocBuilder<FavoritesCubit, FavoritesState>(
              builder: (context, state) {
                final isFavorite =
                    context.read<FavoritesCubit>().isFavorite(productModel.id);
                return Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      isFavorite ? IconlyBold.heart : IconlyLight.heart,
                      color: isFavorite ? AppColors.primaryColor : Colors.black,
                      size: 18.sp,
                    ),
                    onPressed: () {
                      context
                          .read<FavoritesCubit>()
                          .toggleFavorite(productModel);
                      CustomSnackBar.show(
                        context,
                        message: isFavorite
                            ? 'Removed from favorites'
                            : 'Added to favorites',
                        type: isFavorite
                            ? SnackBarType.error
                            : SnackBarType.success,
                      );
                    },
                  ),
                );
              },
            ),
            widthBox(8),
            Container(
              width: 36.w,
              height: 36.h,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  final productModel = Product(
                    id: product.id.toString(),
                    name: product.title,
                    price: product.price,
                    image: product.thumbnail,
                    quantity: 1,
                    isInCart: false,
                    isFavorite: false,
                  );
                  context.read<CartCubit>().addProduct(productModel);
                  CustomSnackBar.show(
                    context,
                    message: 'Product added to cart',
                    type: SnackBarType.success,
                  );
                },
                icon: Icon(
                  IconlyLight.buy,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
