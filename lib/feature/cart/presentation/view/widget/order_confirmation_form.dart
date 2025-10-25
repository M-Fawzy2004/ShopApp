import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/view/widget/confirm_order_button.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/view/widget/input_field_with_label.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/view/widget/order_confirmation_header.dart';
import 'package:clothes_ecommerce_app/feature/cart/presentation/view/widget/read_only_field.dart';

class OrderConfirmationForm extends StatefulWidget {
  const OrderConfirmationForm({
    super.key,
    required this.onConfirm,
  });

  final Function(String governorate, String phoneNumber, String detailedAddress)
      onConfirm;

  @override
  State<OrderConfirmationForm> createState() => _OrderConfirmationFormState();
}

class _OrderConfirmationFormState extends State<OrderConfirmationForm> {
  final _formKey = GlobalKey<FormState>();
  final _governorateController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _governorateController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppRadius.large),
          topRight: Radius.circular(AppRadius.large),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          heightBox(20),
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const OrderConfirmationHeader(),
                    heightBox(24),
                    InputFieldWithLabel(
                      controller: _nameController,
                      icon: Icons.location_city_outlined,
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
                      controller: _governorateController,
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
                      controller: _phoneController,
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
                      controller: _addressController,
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
                    const ReadOnlyField(
                      icon: Icons.payment_outlined,
                      label: 'Payment Method',
                      value: 'Cash on Delivery',
                    ),
                    heightBox(30),
                    ConfirmOrderButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pop(context);
                          widget.onConfirm(
                            _governorateController.text.trim(),
                            _phoneController.text.trim(),
                            _addressController.text.trim(),
                          );
                        }
                      },
                    ),
                    heightBox(20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
