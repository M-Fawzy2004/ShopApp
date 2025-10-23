import 'package:clothes_ecommerce_app/core/helper/custom_snackbar.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/core/widget/custom_button.dart';
import 'package:clothes_ecommerce_app/feature/cart/data/model/product_model.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductBottomBar extends StatelessWidget {
  const ProductBottomBar({
    super.key,
    required this.product,
    required this.quantity,
  });

  final ProductEntity product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    final totalPrice = product.price * quantity;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                onPressed: () {
                  final productModel = Product(
                    id: product.id.toString(),
                    name: product.title,
                    price: product.price,
                    image: product.thumbnail,
                    quantity: quantity,
                  );
                  context.read<CartCubit>().addProduct(productModel);
                  CustomSnackBar.show(
                    context,
                    message: 'Product added to cart',
                    type: SnackBarType.success,
                  );
                },
                text: 'Add to Cart',
                backgroundColor: AppColors.primaryColor,
              ),
            ),
            widthBox(15),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Price',
                  style: AppStyles.font12BlackBold(context),
                ),
                Text(
                  '\$${totalPrice.toStringAsFixed(2)}',
                  style: AppStyles.font16BlackBold(context).copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
