import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

class AuthAccountText extends StatelessWidget {
  final String questionText;
  final String actionText;
  final VoidCallback? onTap;
  final MainAxisAlignment mainAxisAlignment;

  const AuthAccountText({
    super.key,
    required this.questionText,
    required this.actionText,
    this.onTap,
    required this.mainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Text(
          questionText,
          style: AppStyles.font12BlackMedium(context),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            ' $actionText',
            style: AppStyles.font12BlackBold(context),
          ),
        ),
      ],
    );
  }
}
