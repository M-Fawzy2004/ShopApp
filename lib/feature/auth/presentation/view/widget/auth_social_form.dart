import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/utils/assets.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/view/widget/social_button.dart';
import 'package:flutter/material.dart';

class AuthSocialForm extends StatelessWidget {
  const AuthSocialForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SocialButton(
          iconPath: Assets.imagesIconApple,
          text: 'Continue with Apple',
          onTap: () {},
        ),
        heightBox(12),
        SocialButton(
          iconPath: Assets.imagesIconGoogle,
          text: 'Continue with Google',
          onTap: () {},
        ),
      ],
    );
  }
}
