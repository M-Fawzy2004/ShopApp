import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/utils/assets.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/view/widget/social_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthSocialForm extends StatelessWidget {
  const AuthSocialForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SocialButton(
          iconPath: Assets.imagesIconApple,
          text: 'Continue with Apple',
          onTap: () {
            context.read<AuthCubit>().signInWithApple();
          },
        ),
        heightBox(12),
        SocialButton(
          iconPath: Assets.imagesIconGoogle,
          text: 'Continue with Google',
          onTap: () {
            context.read<AuthCubit>().signInWithGoogle();
          },
        ),
      ],
    );
  }
}
