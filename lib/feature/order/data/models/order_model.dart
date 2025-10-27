import 'package:clothes_ecommerce_app/feature/order/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    super.id,
    required super.userId,
    required super.fullName,
    required super.phoneNumber,
    required super.governorate,
    required super.detailedAddress,
    required super.paymentMethod,
    required super.items,
    required super.totalPrice,
    required super.totalQuantity,
    super.status,
    super.createdAt,
    super.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String?,
      userId: json['user_id'] as String,
      fullName: json['full_name'] as String,
      phoneNumber: json['phone_number'] as String,
      governorate: json['governorate'] as String,
      detailedAddress: json['detailed_address'] as String,
      paymentMethod: json['payment_method'] as String,
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalPrice: (json['total_price'] as num).toDouble(),
      totalQuantity: json['total_quantity'] as int,
      status: json['status'] as String? ?? 'pending',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'full_name': fullName,
      'phone_number': phoneNumber,
      'governorate': governorate,
      'detailed_address': detailedAddress,
      'payment_method': paymentMethod,
      'items': items
          .map((item) => OrderItemModel.fromEntity(item).toJson())
          .toList(),
      'total_price': totalPrice,
      'total_quantity': totalQuantity,
      'status': status,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
    };
  }

  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      id: entity.id,
      userId: entity.userId,
      fullName: entity.fullName,
      phoneNumber: entity.phoneNumber,
      governorate: entity.governorate,
      detailedAddress: entity.detailedAddress,
      paymentMethod: entity.paymentMethod,
      items: entity.items,
      totalPrice: entity.totalPrice,
      totalQuantity: entity.totalQuantity,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}

class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    required super.productId,
    required super.productName,
    required super.price,
    required super.quantity,
    super.imageUrl,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: json['product_id'] as String,
      productName: json['product_name'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      imageUrl: json['image_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'price': price,
      'quantity': quantity,
      if (imageUrl != null) 'image_url': imageUrl,
    };
  }

  factory OrderItemModel.fromEntity(OrderItemEntity entity) {
    return OrderItemModel(
      productId: entity.productId,
      productName: entity.productName,
      price: entity.price,
      quantity: entity.quantity,
      imageUrl: entity.imageUrl,
    );
  }
}