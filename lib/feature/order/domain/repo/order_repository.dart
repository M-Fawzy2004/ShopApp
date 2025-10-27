import 'package:clothes_ecommerce_app/feature/order/domain/entities/order_entity.dart';
import 'package:dartz/dartz.dart';

abstract class OrderRepository {
  // create order
  Future<Either<String, OrderEntity>> createOrder(OrderEntity order);

  // get user orders
  Future<Either<String, List<OrderEntity>>> getUserOrders(String userId);

  // get order by id
  Future<Either<String, OrderEntity>> getOrderById(String orderId);

  // update order status
  Future<Either<String, OrderEntity>> updateOrderStatus(
    String orderId,
    String status,
  );
}