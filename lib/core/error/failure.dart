import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure(this.message, {this.code});

  @override
  List<Object?> get props => [message, code];
}

class NetworkFailure extends Failure {
  const NetworkFailure()
      : super('No internet connection. Check your connection and try again.');
}

class ServerFailure extends Failure {
  const ServerFailure([String? message])
      : super(message ?? 'An error occurred. Please try again.');
}

class AuthFailure extends Failure {
  const AuthFailure(super.message, {super.code});

  factory AuthFailure.invalidCredentials() {
    return const AuthFailure(
      'Incorrect email or password',
      code: 'invalid-credentials',
    );
  }

  factory AuthFailure.userNotFound() {
    return const AuthFailure(
      'There is no account with this email address',
      code: 'user-not-found',
    );
  }

  factory AuthFailure.emailAlreadyInUse() {
    return const AuthFailure(
      'The email address is already in use by another account',
      code: 'email-already-in-use',
    );
  }

  factory AuthFailure.weakPassword() {
    return const AuthFailure(
      'Weak password. Must contain at least 8 characters.',
      code: 'weak-password',
    );
  }

  factory AuthFailure.invalidEmail() {
    return const AuthFailure(
      'Invalid email address',
      code: 'invalid-email',
    );
  }

  factory AuthFailure.emailNotVerified() {
    return const AuthFailure(
      'Email must be confirmed first',
      code: 'email-not-verified',
    );
  }

  factory AuthFailure.invalidVerificationCode() {
    return const AuthFailure(
      'Verification code is incorrect or expired',
      code: 'invalid-code',
    );
  }

  factory AuthFailure.tooManyRequests() {
    return const AuthFailure(
      'Too many attempts. Try again later.',
      code: 'too-many-requests',
    );
  }

  factory AuthFailure.sessionExpired() {
    return const AuthFailure(
      'Session has ended. Log in again.',
      code: 'session-expired',
    );
  }

  factory AuthFailure.googleSignInFailed() {
    return const AuthFailure(
      'Google Sign In Failed',
      code: 'google-sign-in-failed',
    );
  }

  factory AuthFailure.appleSignInFailed() {
    return const AuthFailure(
      'Apple Sign In Failed',
      code: 'apple-sign-in-failed',
    );
  }
}

class StorageFailure extends Failure {
  const StorageFailure([String? message])
      : super(
          message ?? 'Failed to upload image. Try again.',
        );
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure([String? message])
      : super(
          message ?? 'An unexpected error occurred. Please try again later.',
        );
}
