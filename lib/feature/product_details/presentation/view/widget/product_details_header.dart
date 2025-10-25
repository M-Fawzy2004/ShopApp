import 'package:clothes_ecommerce_app/core/helper/custom_snackbar.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/widget/circle_icon.dart';
import 'package:clothes_ecommerce_app/feature/cart/data/model/product_model.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/manager/favorites_cubit/favorites_cubit.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/manager/favorites_cubit/favorites_state.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:clothes_ecommerce_app/feature/product_details/presentation/view/widget/product_images_header.dart';
import 'package:clothes_ecommerce_app/feature/product_details/presentation/view/widget/product_title_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

class ProductDetailsHeader extends StatelessWidget {
  const ProductDetailsHeader({super.key, required this.product});

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

    return Stack(
      clipBehavior: Clip.none,
      children: [
        ProductImagesHeader(product: product),
        Positioned(
          top: 40.h,
          left: 16.w,
          child: const CircleIcon(),
        ),
        Positioned(
          top: 40.h,
          right: 16.w,
          child: BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              final isFavorite =
                  context.read<FavoritesCubit>().isFavorite(productModel.id);

              return CircleIcon(
                icon: isFavorite ? IconlyBold.heart : IconlyLight.heart,
                colorIcon: isFavorite ? AppColors.primaryColor : Colors.black,
                color: Colors.white,
                onTap: () {
                  context.read<FavoritesCubit>().toggleFavorite(productModel);
                  CustomSnackBar.show(
                    context,
                    message: isFavorite
                        ? 'Removed from favorites'
                        : 'Added to favorites',
                    type:
                        isFavorite ? SnackBarType.error : SnackBarType.success,
                  );
                },
              );
            },
          ),
        ),
        Positioned(
          bottom: -25.h,
          right: 30.w,
          left: 30.w,
          child: ProductTitleCard(product: product),
        ),
      ],
    );
  }
}
