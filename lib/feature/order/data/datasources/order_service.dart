import 'package:clothes_ecommerce_app/core/const/app_const.dart';
import 'package:clothes_ecommerce_app/feature/order/data/models/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class OrderService {
  Future<OrderModel> createOrder(OrderModel order);
  Future<List<OrderModel>> getUserOrders(String userId);
  Future<OrderModel> getOrderById(String orderId);
  Future<OrderModel> updateOrderStatus(String orderId, String status);
}

class OrderServiceImpl implements OrderService {
  final SupabaseClient _supabase;

  OrderServiceImpl({SupabaseClient? supabase})
      : _supabase = supabase ?? Supabase.instance.client;

  @override
  Future<OrderModel> createOrder(OrderModel order) async {
    try {
      final orderJson = order.toJson();

      final response = await _supabase
          .from(AppConst.tabelOrders)
          .insert(orderJson)
          .select()
          .single();
      return OrderModel.fromJson(response);
    } on PostgrestException catch (e) {
      if (e.code == '23514') {
        throw Exception('Invalid payment method selected. Please try again.');
      } else if (e.code == '23503') {
        throw Exception('User profile not found. Please login again.');
      }
      throw Exception('Failed to create order: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error creating order: $e');
    }
  }

  @override
  Future<List<OrderModel>> getUserOrders(String userId) async {
    try {
      final response = await _supabase
          .from(AppConst.tabelOrders)
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => OrderModel.fromJson(json))
          .toList();
    } on PostgrestException catch (e) {
      throw Exception('Failed to fetch orders: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error fetching orders: $e');
    }
  }

  @override
  Future<OrderModel> getOrderById(String orderId) async {
    try {
      final response = await _supabase
          .from(AppConst.tabelOrders)
          .select()
          .eq('id', orderId)
          .single();

      return OrderModel.fromJson(response);
    } on PostgrestException catch (e) {
      throw Exception('Failed to fetch order: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error fetching order: $e');
    }
  }

  @override
  Future<OrderModel> updateOrderStatus(String orderId, String status) async {
    try {
      final response = await _supabase
          .from(AppConst.tabelOrders)
          .update({
            'status': status,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', orderId)
          .select()
          .single();

      return OrderModel.fromJson(response);
    } on PostgrestException catch (e) {
      throw Exception('Failed to update order status: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error updating order: $e');
    }
  }
}
