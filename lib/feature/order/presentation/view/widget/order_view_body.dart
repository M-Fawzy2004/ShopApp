import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/helper/custom_loading_widget.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/feature/order/domain/entities/order_entity.dart';
import 'package:clothes_ecommerce_app/feature/order/presentation/manager/order_cubit/order_cubit.dart';
import 'package:clothes_ecommerce_app/feature/order/presentation/manager/order_cubit/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

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
      context.read<OrderCubit>().getOrderById(widget.orderId!);
    } else {
      // Get user orders
      final userId = 'user-id-here'; // Replace with actual user ID
      context.read<OrderCubit>().getUserOrders(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.orderId != null ? 'Order Details' : 'My Orders',
          style: AppStyles.font16BlackBold(context).copyWith(fontSize: 18.sp),
        ),
        centerTitle: true,
      ),
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
                    style: AppStyles.font16BlackBold(context).copyWith(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (state is OrderDetailsLoaded) {
            return OrderDetailsView(order: state.order);
          }

          if (state is OrdersLoaded) {
            if (state.orders.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_bag_outlined, size: 100.sp, color: Colors.grey),
                    heightBox(16),
                    Text(
                      'No orders yet',
                      style: AppStyles.font16BlackBold(context),
                    ),
                    heightBox(8),
                    Text(
                      'Start shopping to place your first order',
                      style: AppStyles.font13BlackMedium(context).copyWith(color: Colors.grey),
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

class OrdersListView extends StatelessWidget {
  const OrdersListView({super.key, required this.orders});

  final List<OrderEntity> orders;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      
      padding: EdgeInsets.all(16.w),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderCard(order: order);
      },
    );
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});

  final OrderEntity order;

  Color _getStatusColor() {
    switch (order.status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.blue;
      case 'shipped':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.regular),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.regular),
          onTap: () {
            Navigator.pushNamed(
              context,
              '/order-details',
              arguments: order.id,
            );
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order #${order.id?.substring(0, 8) ?? ''}',
                      style: AppStyles.font16BlackBold(context),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: _getStatusColor().withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppRadius.small),
                      ),
                      child: Text(
                        order.status.toUpperCase(),
                        style: AppStyles.font13BlackMedium(context).copyWith(
                          color: _getStatusColor(),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                heightBox(12),
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined, size: 16.sp, color: Colors.grey),
                    widthBox(8),
                    Text(
                      DateFormat('MMM dd, yyyy').format(order.createdAt ?? DateTime.now()),
                      style: AppStyles.font13BlackMedium(context).copyWith(color: Colors.grey),
                    ),
                  ],
                ),
                heightBox(8),
                Row(
                  children: [
                    Icon(Icons.shopping_bag_outlined, size: 16.sp, color: Colors.grey),
                    widthBox(8),
                    Text(
                      '${order.totalQuantity} items',
                      style: AppStyles.font13BlackMedium(context).copyWith(color: Colors.grey),
                    ),
                  ],
                ),
                heightBox(12),
                Divider(color: Colors.grey[200]),
                heightBox(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: AppStyles.font13BlackMedium(context),
                    ),
                    Text(
                      '\$${order.totalPrice.toStringAsFixed(2)}',
                      style: AppStyles.font16BlackBold(context).copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key, required this.order});

  final OrderEntity order;

  Color _getStatusColor() {
    switch (order.status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.blue;
      case 'shipped':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Status Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_getStatusColor(), _getStatusColor().withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppRadius.regular),
            ),
            child: Column(
              children: [
                Icon(Icons.check_circle_outline, size: 60.sp, color: Colors.white),
                heightBox(12),
                Text(
                  order.status.toUpperCase(),
                  style: AppStyles.font16BlackBold(context).copyWith(
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),
                ),
                heightBox(8),
                Text(
                  'Order #${order.id?.substring(0, 8) ?? ''}',
                  style: AppStyles.font13BlackMedium(context).copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          heightBox(24),

          // Delivery Information
          _buildSectionCard(
            context,
            title: 'Delivery Information',
            icon: Icons.local_shipping_outlined,
            children: [
              _buildInfoRow(context, 'Name', order.fullName),
              _buildInfoRow(context, 'Phone', order.phoneNumber),
              _buildInfoRow(context, 'Governorate', order.governorate),
              _buildInfoRow(context, 'Address', order.detailedAddress),
            ],
          ),
          heightBox(16),

          // Payment Information
          _buildSectionCard(
            context,
            title: 'Payment Information',
            icon: Icons.payment_outlined,
            children: [
              _buildInfoRow(
                context,
                'Method',
                order.paymentMethod == 'cash_on_delivery' 
                    ? 'Cash on Delivery' 
                    : 'Stripe Payment',
              ),
              _buildInfoRow(
                context,
                'Date',
                DateFormat('MMM dd, yyyy - hh:mm a').format(order.createdAt ?? DateTime.now()),
              ),
            ],
          ),
          heightBox(16),

          // Order Items
          _buildSectionCard(
            context,
            title: 'Order Items',
            icon: Icons.shopping_bag_outlined,
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: order.items.length,
                separatorBuilder: (context, index) => Divider(
                  height: 24.h,
                  color: Colors.grey[200],
                ),
                itemBuilder: (context, index) {
                  final item = order.items[index];
                  return _buildOrderItem(context, item);
                },
              ),
            ],
          ),
          heightBox(16),

          // Order Summary
          _buildSectionCard(
            context,
            title: 'Order Summary',
            icon: Icons.receipt_long_outlined,
            children: [
              _buildSummaryRow(context, 'Subtotal', order.totalPrice),
              _buildSummaryRow(context, 'Delivery Fee', 0),
              heightBox(8),
              Divider(color: Colors.grey[300], thickness: 1),
              heightBox(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: AppStyles.font16BlackBold(context).copyWith(fontSize: 18.sp),
                  ),
                  Text(
                    '\${order.totalPrice.toStringAsFixed(2)}',
                    style: AppStyles.font16BlackBold(context).copyWith(
                      fontSize: 20.sp,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          heightBox(24),
        ],
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.regular),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.small),
                ),
                child: Icon(icon, size: 20.sp, color: AppColors.primaryColor),
              ),
              widthBox(12),
              Text(
                title,
                style: AppStyles.font16BlackBold(context),
              ),
            ],
          ),
          heightBox(16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              label,
              style: AppStyles.font13BlackMedium(context).copyWith(
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppStyles.font13BlackMedium(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(BuildContext context, OrderItemEntity item) {
    return Row(
      children: [
        Container(
          width: 60.w,
          height: 60.w,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(AppRadius.small),
            image: item.imageUrl != null
                ? DecorationImage(
                    image: NetworkImage(item.imageUrl!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: item.imageUrl == null
              ? Icon(Icons.image_outlined, size: 30.sp, color: Colors.grey)
              : null,
        ),
        widthBox(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.productName,
                style: AppStyles.font13BlackMedium(context).copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              heightBox(4),
              Text(
                'Qty: ${item.quantity}',
                style: AppStyles.font13BlackMedium(context).copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Text(
          '\${(item.price * item.quantity).toStringAsFixed(2)}',
          style: AppStyles.font13BlackMedium(context).copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, double amount) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppStyles.font13BlackMedium(context).copyWith(
              color: Colors.grey[600],
            ),
          ),
          Text(
            '\${amount.toStringAsFixed(2)}',
            style: AppStyles.font13BlackMedium(context),
          ),
        ],
      ),
    );
  }
}