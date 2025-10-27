import 'package:clothes_ecommerce_app/core/helper/custom_snackbar.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/view/widget/confirm_order_button.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/view/widget/input_field_with_label.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/view/widget/order_confirmation_header.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/view/widget/payment_method_selector.dart';
import 'package:flutter/material.dart';

class OrderDetailsForm extends StatefulWidget {
  const OrderDetailsForm({super.key});

  @override
  State<OrderDetailsForm> createState() => _OrderDetailsFormState();
}

class _OrderDetailsFormState extends State<OrderDetailsForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController governorateController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  PaymentMethod selectedPaymentMethod = PaymentMethod.cashOnDelivery;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OrderConfirmationHeader(),
          heightBox(24),
          InputFieldWithLabel(
            controller: nameController,
            icon: Icons.person_outline,
            label: 'Name',
            hint: 'Enter your name',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter name';
              }
              return null;
            },
          ),
          heightBox(16),
          InputFieldWithLabel(
            controller: governorateController,
            icon: Icons.location_city_outlined,
            label: 'Governorate',
            hint: 'Enter your governorate',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter governorate';
              }
              return null;
            },
          ),
          heightBox(16),
          InputFieldWithLabel(
            controller: phoneController,
            icon: Icons.phone_outlined,
            label: 'Phone Number',
            hint: '01xxxxxxxxx',
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter phone number';
              }
              if (value.length < 11) {
                return 'Invalid phone number';
              }
              return null;
            },
          ),
          heightBox(16),
          InputFieldWithLabel(
            controller: addressController,
            icon: Icons.location_on_outlined,
            label: 'Detailed Address',
            hint: 'Street, area, landmarks...',
            maxLines: 3,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter detailed address';
              }
              return null;
            },
          ),
          heightBox(16),
          PaymentMethodSelector(
            selectedMethod: selectedPaymentMethod,
            onMethodChanged: (method) {
              setState(() {
                selectedPaymentMethod = method;
              });
            },
          ),
          heightBox(30),
          ConfirmOrderButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(context);

                final paymentMethodText =
                    selectedPaymentMethod == PaymentMethod.cashOnDelivery
                        ? 'Cash on Delivery'
                        : 'Stripe Payment';

                CustomSnackBar.show(
                  context,
                  message: 'Order placed successfully with $paymentMethodText',
                  type: SnackBarType.success,
                );
                if (selectedPaymentMethod == PaymentMethod.stripe) {
                  print('Processing Stripe payment...');
                }
              }
            },
          ),
          heightBox(20),
        ],
      ),
    );
  }
}
