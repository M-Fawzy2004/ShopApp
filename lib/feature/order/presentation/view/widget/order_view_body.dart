import 'package:clothes_ecommerce_app/core/helper/custom_loading_widget.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/feature/order/presentation/manager/order_cubit/order_cubit.dart';
import 'package:clothes_ecommerce_app/feature/order/presentation/manager/order_cubit/order_state.dart';
import 'package:clothes_ecommerce_app/feature/order/presentation/view/widget/orders_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderViewBody extends StatefulWidget {
  const OrderViewBody({super.key, this.orderId});

  final String? orderId;

  @override
  State<OrderViewBody> createState() => _OrderViewBodyState();
}

class _OrderViewBodyState extends State<OrderViewBody> {
  @override
  void initState() {
    super.initState();
    if (widget.orderId != null) {
      // Get specific order by ID
      context.read<OrderCubit>().getOrderById(widget.orderId!);
    } else {
      // Get all user orders
      final userId = Supabase.instance.client.auth.currentUser?.id;

      if (userId != null) {
        context.read<OrderCubit>().getUserOrders(userId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CustomLoadingWidget());
          }

          if (state is OrderError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 80.sp, color: Colors.red),
                  heightBox(16),
                  Text(
                    state.message,
                    style: AppStyles.font16BlackBold(context)
                        .copyWith(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (state is OrdersLoaded) {
            if (state.orders.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_bag_outlined,
                        size: 100.sp, color: Colors.grey),
                    heightBox(16),
                    Text(
                      'No orders yet',
                      style: AppStyles.font16BlackBold(context),
                    ),
                    heightBox(8),
                    Text(
                      'Start shopping to place your first order',
                      style: AppStyles.font13BlackMedium(context)
                          .copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            return OrdersListView(orders: state.orders);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
