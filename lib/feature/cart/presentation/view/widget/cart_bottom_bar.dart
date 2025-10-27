import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/helper/custom_snackbar.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/feature/cart/data/model/product_model.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/view/widget/confirm_order_button.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/view/widget/order_confirmation_bottom_sheet.dart';
import 'package:clothes_ecommerce_app/feature/order/presentation/manager/order_cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartBottomBar extends StatelessWidget {
  const CartBottomBar({
    super.key,
    required this.totalItems,
    required this.totalPrice,
    required this.products,
  });

  final int totalItems;
  final double totalPrice;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppRadius.regular),
          topRight: Radius.circular(AppRadius.regular),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Items: $totalItems',
                        style: AppStyles.font13BlackMedium(context),
                      ),
                      heightBox(4),
                      Text(
                        '\$${totalPrice.toStringAsFixed(2)}',
                        style: AppStyles.font24BlackMedium(context).copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 200.w,
                    child: ConfirmOrderButton(
                      onPressed: () {
                        showOrderConfirmationSheet(
                          context: context,
                          onConfirm: (
                            name,
                            governorate,
                            phoneNumber,
                            detailedAddress,
                            paymentMethod,
                          ) {
                            // Get user ID from your auth system
                            final userId =
                                Supabase.instance.client.auth.currentUser?.id;

                            if (userId == null) {
                              CustomSnackBar.show(
                                context,
                                message: 'Please login first',
                                type: SnackBarType.error,
                              );
                              return;
                            }

                            context.read<OrderCubit>().createOrder(
                                  userId: userId,
                                  fullName: name,
                                  phoneNumber: phoneNumber,
                                  governorate: governorate,
                                  detailedAddress: detailedAddress,
                                  paymentMethod: paymentMethod,
                                  products: products,
                                );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
