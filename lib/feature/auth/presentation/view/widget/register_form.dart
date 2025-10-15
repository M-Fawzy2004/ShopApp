import 'package:clothes_ecommerce_app/core/helper/app_router.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/widget/custom_button.dart';
import 'package:clothes_ecommerce_app/core/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomTextField(
          hintText: 'First Name',
          prefixIcon: Icon(
            Icons.person,
            color: AppColors.darkGrey,
          ),
        ),
        heightBox(16),
        const CustomTextField(
          hintText: 'Last Name',
          prefixIcon: Icon(
            Icons.person,
            color: AppColors.darkGrey,
          ),
        ),
        heightBox(16),
        const CustomTextField(
          hintText: 'Email',
          prefixIcon: Icon(
            Icons.email,
            color: AppColors.darkGrey,
          ),
        ),
        heightBox(16),
        const CustomTextField(
          hintText: 'Password',
          isPassword: true,
          prefixIcon: Icon(
            Icons.lock,
            color: AppColors.darkGrey,
          ),
        ),
        heightBox(40),
        CustomButton(
          text: 'Create Account',
          onPressed: () {
            context.push(AppRouter.mainView);
          },
        ),
      ],
    );
  }
}
