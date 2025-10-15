import 'package:clothes_ecommerce_app/core/di/app_providers.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/view/email_verf_view.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/view/forget_password_view.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/view/login_view.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/view/register_view.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/view/send_email_view.dart';
import 'package:clothes_ecommerce_app/feature/main_home/presentation/view/main_view.dart';
import 'package:clothes_ecommerce_app/feature/splash/presentation/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const splashView = '/';
  static const loginView = '/loginView';
  static const registerView = '/registerView';
  static const forgetPasswordView = '/forgetPasswordView';
  static const sendEmailView = '/sendEmailView';
  static const mainView = '/mainView';
  static const emailVerfView = '/emailVerfView';

  static var router = GoRouter(
    routes: [
      // splash view
      GoRoute(
        path: splashView,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashView();
        },
      ),
      // login
      GoRoute(
        path: loginView,
        builder: (BuildContext context, GoRouterState state) {
          return AppProviders.auth(child: const LoginView());
        },
      ),
      // register
      GoRoute(
        path: registerView,
        builder: (BuildContext context, GoRouterState state) {
          return AppProviders.auth(child: const RegisterView());
        },
      ), // register
      GoRoute(
        path: forgetPasswordView,
        builder: (BuildContext context, GoRouterState state) {
          return AppProviders.auth(child: const ForgetPasswordView());
        },
      ),
      GoRoute(
        path: sendEmailView,
        builder: (BuildContext context, GoRouterState state) {
          return const SendEmailView();
        },
      ),
      GoRoute(
        path: mainView,
        builder: (BuildContext context, GoRouterState state) {
          return const MainView();
        },
      ),
      GoRoute(
        path: emailVerfView,
        builder: (BuildContext context, GoRouterState state) {
          final data = state.extra as Map<String, dynamic>;
          return AppProviders.auth(child: EmailVerfView(data: data));
        },
      ),
    ],
  );
}
