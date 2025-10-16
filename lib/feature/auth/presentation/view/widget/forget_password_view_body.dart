import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/core/widget/icon_back.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/view/widget/forget_password_form_bloc_consumer.dart';
import 'package:flutter/material.dart';

class ForgetPasswordViewBody extends StatelessWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightBox(13),
          const IconBack(),
          heightBox(20),
          Text(
            'Forget Password',
            style: AppStyles.font32BlackBold(context),
          ),
          heightBox(10),
          Text(
            'Please enter your email address to receive a link to create a new password via email',
            style: AppStyles.font12GreyBold(context),
          ),
          heightBox(30),
          const ForgetPasswordFormBlocConsumer(),
        ],
      ),
    );
  }
}

