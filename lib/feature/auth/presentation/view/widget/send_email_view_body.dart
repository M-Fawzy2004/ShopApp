import 'package:clothes_ecommerce_app/core/helper/extension.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/core/widget/custom_button.dart';
import 'package:clothes_ecommerce_app/core/widget/icon_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/assets.dart';

class SendEmailViewBody extends StatelessWidget {
  const SendEmailViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        heightBox(13),
        const Align(
          alignment: Alignment.centerLeft,
          child: IconBack(),
        ),
        heightBox(200),
        Image.asset(Assets.imagesPngSendMail),
        heightBox(24),
        Text(
          "We Sent you an Email to reset your password.",
          textAlign: TextAlign.center,
          style: AppStyles.font24BlackMedium(context),
        ),
        heightBox(24),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 90.w),
          child: CustomButton(
            text: 'Return to Login',
            onPressed: () {
              context.pop();
              context.pop();
            },
          ),
        ),
      ],
    );
  }
}
