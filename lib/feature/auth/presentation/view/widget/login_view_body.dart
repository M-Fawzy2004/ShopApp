import 'package:clothes_ecommerce_app/core/helper/app_router.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/view/widget/auth_account_text.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/view/widget/auth_social_form.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/view/widget/login_form.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/view/widget/or_divider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightBox(75),
          Text(
            'Sign In',
            style: AppStyles.font32BlackBold(context),
          ),
          heightBox(32),
          const LoginForm(),
          heightBox(32),
          AuthAccountText(
            mainAxisAlignment: MainAxisAlignment.center,
            questionText: "Don't have an account?",
            actionText: "Create Account",
            onTap: () {
              context.push(AppRouter.registerView);
            },
          ),
          heightBox(40),
          const OrDivider(),
          heightBox(30),
          const AuthSocialForm(),
        ],
      ),
    );
  }
}
