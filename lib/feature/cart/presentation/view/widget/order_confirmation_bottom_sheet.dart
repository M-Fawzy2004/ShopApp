import 'package:clothes_ecommerce_app/feature/cart/presentation/view/widget/order_confirmation_form.dart';
import 'package:flutter/material.dart';

class OrderConfirmationBottomSheet extends StatelessWidget {
  const OrderConfirmationBottomSheet({
    super.key,
    required this.onConfirm,
  });

  final Function(String governorate, String phoneNumber, String detailedAddress)
      onConfirm;

  @override
  Widget build(BuildContext context) {
    return OrderConfirmationForm(
      onConfirm: onConfirm,
    );
  }
}

void showOrderConfirmationSheet({
  required BuildContext context,
  required Function(
          String governorate, String phoneNumber, String detailedAddress)
      onConfirm,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: OrderConfirmationBottomSheet(
        onConfirm: onConfirm,
      ),
    ),
  );
}
