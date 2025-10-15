import 'package:clothes_ecommerce_app/core/helper/app_router.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/widget/custom_button.dart';
import 'package:clothes_ecommerce_app/core/widget/custom_text_field.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/view/widget/auth_account_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomTextField(
          hintText: 'Email Address',
          prefixIcon: Icon(
            Icons.email,
            color: AppColors.darkGrey,
          ),
        ),
        heightBox(10),
        const CustomTextField(
          hintText: 'Password',
          isPassword: true,
          prefixIcon: Icon(
            Icons.lock,
            color: AppColors.darkGrey,
          ),
        ),
        heightBox(10),
        AuthAccountText(
          mainAxisAlignment: MainAxisAlignment.start,
          questionText: 'Forget Password?',
          actionText: ' Reset',
          onTap: () {
            context.push(AppRouter.forgetPasswordView);
          },
        ),
        heightBox(30),
        CustomButton(
          text: 'Sign In',
          onPressed: () {
            context.push(AppRouter.mainView);
          },
        ),
      ],
    );
  }
}
