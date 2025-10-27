import 'package:clothes_ecommerce_app/feature/cart/data/model/product_model.dart';
import 'package:clothes_ecommerce_app/feature/order/domain/entities/order_entity.dart';
import 'package:clothes_ecommerce_app/feature/order/domain/repo/order_repository.dart';
import 'package:clothes_ecommerce_app/feature/order/presentation/manager/order_cubit/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository orderRepository;

  OrderCubit({required this.orderRepository}) : super(OrderInitial());

  Future<void> createOrder({
    required String userId,
    required String fullName,
    required String phoneNumber,
    required String governorate,
    required String detailedAddress,
    required String paymentMethod,
    required List<Product> products,
  }) async {
    if (isClosed) return;

    emit(OrderLoading());

    try {
      // Convert products to order items
      final items = products
          .map((product) => OrderItemEntity(
                productId: product.id,
                productName: product.name,
                price: product.price,
                quantity: product.quantity,
                imageUrl: product.image,
              ))
          .toList();

      // Calculate totals
      final totalPrice = products.fold<double>(
        0,
        (sum, product) => sum + product.totalPrice,
      );

      final totalQuantity = products.fold<int>(
        0,
        (sum, product) => sum + product.quantity,
      );

      // Create order entity
      final orderEntity = OrderEntity(
        userId: userId,
        fullName: fullName,
        phoneNumber: phoneNumber,
        governorate: governorate,
        detailedAddress: detailedAddress,
        paymentMethod: paymentMethod,
        items: items,
        totalPrice: totalPrice,
        totalQuantity: totalQuantity,
      );

      final result = await orderRepository.createOrder(orderEntity);

      result.fold(
        (error) {
          if (!isClosed) emit(OrderError(error));
        },
        (order) {
          if (!isClosed) emit(OrderCreated(order));
        },
      );
    } catch (e) {
      if (!isClosed) emit(OrderError('Failed to create order: $e'));
    }
  }

  Future<void> getUserOrders(String userId) async {
    if (isClosed) return;

    emit(OrderLoading());

    final result = await orderRepository.getUserOrders(userId);

    result.fold(
      (error) {
        if (!isClosed) emit(OrderError(error));
      },
      (orders) {
        if (!isClosed) emit(OrdersLoaded(orders));
      },
    );
  }

  Future<void> getOrderById(String orderId) async {
    if (isClosed) return;

    emit(OrderLoading());

    final result = await orderRepository.getOrderById(orderId);

    result.fold(
      (error) {
        if (!isClosed) emit(OrderError(error));
      },
      (order) {
        if (!isClosed) emit(OrderDetailsLoaded(order));
      },
    );
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    if (isClosed) return;

    emit(OrderLoading());

    final result = await orderRepository.updateOrderStatus(orderId, status);

    result.fold(
      (error) {
        if (!isClosed) emit(OrderError(error));
      },
      (order) {
        if (!isClosed) emit(OrderStatusUpdated(order));
      },
    );
  }
}
