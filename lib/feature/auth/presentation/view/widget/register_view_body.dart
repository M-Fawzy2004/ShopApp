import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/core/widget/icon_back.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/view/widget/register_form.dart';
import 'package:flutter/material.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightBox(13),
          const IconBack(),
          heightBox(20),
          Text(
            'Create Account',
            style: AppStyles.font32BlackBold(context),
          ),
          heightBox(32),
          const RegisterForm(),
        ],
      ),
    );
  }
}
