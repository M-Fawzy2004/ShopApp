import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/feature/cart/data/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconly/iconly.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.product,
    required this.onDelete,
    required this.onIncrement,
    required this.onDecrement,
  });

  final Product product;
  final VoidCallback onDelete;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Slidable(
        key: ValueKey(product.id),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              onPressed: (context) => onDelete(),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: IconlyLight.delete,
              label: 'Delete',
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(AppRadius.regular),
                bottomRight: Radius.circular(AppRadius.regular),
              ),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppRadius.regular),
              bottomLeft: Radius.circular(AppRadius.regular),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                height: 100.h,
                width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.regular),
                  color: AppColors.primaryColor.withOpacity(0.1),
                  image: DecorationImage(
                    image: NetworkImage(product.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              widthBox(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      style: AppStyles.font16BlackBold(context),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    heightBox(8),
                    Text(
                      '\$${product.totalPrice.toStringAsFixed(2)}',
                      style: AppStyles.font14greyBold(context).copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    heightBox(12),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: product.quantity > 1 ? onDecrement : null,
                          child: Container(
                            height: 32.h,
                            width: 32.w,
                            decoration: BoxDecoration(
                              color: product.quantity > 1
                                  ? AppColors.primaryColor.withOpacity(0.1)
                                  : Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.remove,
                              size: 18.sp,
                              color: product.quantity > 1
                                  ? AppColors.primaryColor
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        widthBox(12),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            '${product.quantity}',
                            style: AppStyles.font16BlackBold(context).copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        widthBox(12),
                        GestureDetector(
                          onTap: onIncrement,
                          child: Container(
                            height: 32.h,
                            width: 32.w,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.add,
                              size: 18.sp,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}