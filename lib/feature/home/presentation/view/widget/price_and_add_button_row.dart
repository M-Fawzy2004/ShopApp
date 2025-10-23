import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/helper/custom_snackbar.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/feature/cart/data/model/product_model.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'package:clothes_ecommerce_app/feature/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceAndAddButtonRow extends StatelessWidget {
  const PriceAndAddButtonRow({
    super.key,
    required this.finalPrice,
    required this.product,
  });

  final double finalPrice;

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "\$${finalPrice.toStringAsFixed(2)}",
              style: AppStyles.font16BlackBold(context),
            ),
            const Spacer(),
            Container(
              width: 36.w,
              height: 36.h,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: InkWell(
                onTap: () {
                  final productModel = Product(
                    id: product.id.toString(),
                    name: product.title,
                    price: product.price,
                    image: product.thumbnail,
                  );
                  context.read<CartCubit>().addProduct(productModel);
                  CustomSnackBar.show(
                    context,
                    message: 'Product added to cart',
                    type: SnackBarType.success,
                  );
                },
                borderRadius: BorderRadius.circular(AppRadius.large),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
