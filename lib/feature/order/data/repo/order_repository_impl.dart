import 'package:clothes_ecommerce_app/feature/order/data/datasources/order_service.dart';
import 'package:clothes_ecommerce_app/feature/order/data/models/order_model.dart';
import 'package:clothes_ecommerce_app/feature/order/domain/entities/order_entity.dart';
import 'package:clothes_ecommerce_app/feature/order/domain/repo/order_repository.dart';
import 'package:dartz/dartz.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderService orderService;

  OrderRepositoryImpl({required this.orderService});

  @override
  Future<Either<String, OrderEntity>> createOrder(OrderEntity order) async {
    try {
      final orderModel = OrderModel.fromEntity(order);
      final result = await orderService.createOrder(orderModel);
      return Right(result);
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<String, List<OrderEntity>>> getUserOrders(
    String userId,
  ) async {
    try {
      final result = await orderService.getUserOrders(userId);
      return Right(result);
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<String, OrderEntity>> getOrderById(String orderId) async {
    try {
      final result = await orderService.getOrderById(orderId);
      return Right(result);
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<String, OrderEntity>> updateOrderStatus(
    String orderId,
    String status,
  ) async {
    try {
      final result = await orderService.updateOrderStatus(orderId, status);
      return Right(result);
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  String _handleError(dynamic error) {
    if (error is Exception) {
      return error.toString().replaceAll('Exception: ', '');
    }
    return 'An unexpected error occurred';
  }
}