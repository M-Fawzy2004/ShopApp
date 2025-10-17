import 'dart:ui';

import 'package:clothes_ecommerce_app/core/helper/app_radius.dart';
import 'package:clothes_ecommerce_app/core/helper/spacing.dart';
import 'package:clothes_ecommerce_app/core/helper/user_data_helper.dart';
import 'package:clothes_ecommerce_app/core/theme/app_colors.dart';
import 'package:clothes_ecommerce_app/core/theme/app_styles.dart';
import 'package:clothes_ecommerce_app/core/utils/assets.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeaderCard extends StatelessWidget {
  const HomeHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final userHelper = state is AuthAuthenticated
            ? UserDataHelper(state.user)
            : UserDataHelper(null);

        return ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(AppRadius.large),
              ),
              child: Row(
                children: [
                  // User Avatar
                  userHelper.hasPhoto
                      ? CircleAvatar(
                          radius: 26.r,
                          backgroundImage: NetworkImage(userHelper.photoUrl!),
                        )
                      : CircleAvatar(
                          radius: 26.r,
                          backgroundColor: userHelper.getAvatarColor(),
                          child: Text(
                            userHelper.initials,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                  widthBox(10),
                  // User Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          userHelper.getGreeting().toUpperCase(),
                          style: AppStyles.font14BlackMedium(context),
                        ),
                        Text(
                          userHelper.displayName,
                          style: AppStyles.font16BlackBold(context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  // Notification Icon
                  Image.asset(
                    Assets.imagesIconNotificationIcon,
                    color: AppColors.black,
                  ),
                  widthBox(10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
