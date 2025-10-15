import 'dart:io';

import 'package:clothes_ecommerce_app/core/error/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExceptionHandler {
  static Failure handleException(dynamic error) {
    if (error is SocketException) {
      return const NetworkFailure();
    }

    if (error is AuthException) {
      return _handleAuthException(error);
    }

    if (error is StorageException) {
      return StorageFailure(error.message);
    }

    if (error is PostgrestException) {
      return ServerFailure(error.message);
    }

    return UnexpectedFailure(error.toString());
  }

  static AuthFailure _handleAuthException(AuthException exception) {
    switch (exception.statusCode) {
      case '400':
        if (exception.message.contains('Invalid login credentials')) {
          return AuthFailure.invalidCredentials();
        }
        if (exception.message.contains('Email not confirmed')) {
          return AuthFailure.emailNotVerified();
        }
        if (exception.message.contains('User not found')) {
          return AuthFailure.userNotFound();
        }
        return AuthFailure.invalidEmail();

      case '422':
        if (exception.message.contains('Email already registered')) {
          return AuthFailure.emailAlreadyInUse();
        }
        if (exception.message.contains('Password')) {
          return AuthFailure.weakPassword();
        }
        return AuthFailure(exception.message);

      case '429':
        return AuthFailure.tooManyRequests();

      case '401':
        return AuthFailure.sessionExpired();

      default:
        return AuthFailure(
          exception.message,
          code: exception.statusCode,
        );
    }
  }

  static Failure handleStorageException(StorageException exception) {
    if (exception.statusCode == '413') {
      return const StorageFailure('The file size is too large');
    }
    if (exception.statusCode == '415') {
      return const StorageFailure('Unsupported file type');
    }
    return StorageFailure(exception.message);
  }
}
