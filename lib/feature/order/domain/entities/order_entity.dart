import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String? id;
  final String userId;
  final String fullName;
  final String phoneNumber;
  final String governorate;
  final String detailedAddress;
  final String paymentMethod; // 'cash' or 'stripe'
  final List<OrderItemEntity> items;
  final double totalPrice;
  final int totalQuantity;
  final String status; // 'pending', 'processing', 'completed', 'cancelled'
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const OrderEntity({
    this.id,
    required this.userId,
    required this.fullName,
    required this.phoneNumber,
    required this.governorate,
    required this.detailedAddress,
    required this.paymentMethod,
    required this.items,
    required this.totalPrice,
    required this.totalQuantity,
    this.status = 'pending',
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        fullName,
        phoneNumber,
        governorate,
        detailedAddress,
        paymentMethod,
        items,
        totalPrice,
        totalQuantity,
        status,
        createdAt,
        updatedAt,
      ];
}

class OrderItemEntity extends Equatable {
  final String productId;
  final String productName;
  final double price;
  final int quantity;
  final String? imageUrl;

  const OrderItemEntity({
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [productId, productName, price, quantity, imageUrl];
}