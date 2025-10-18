import 'package:clothes_ecommerce_app/core/helper/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:go_router/go_router.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const CircularProgressIndicator();
          }

          if (state is AuthUnauthenticated) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go(AppRouter.loginView);
            });
          }

          return IconButton(
            icon: const Icon(Icons.logout, color: Colors.red, size: 30),
            onPressed: () {
              context.read<AuthCubit>().signOut();
            },
          );
        },
      ),
    );
  }
}
