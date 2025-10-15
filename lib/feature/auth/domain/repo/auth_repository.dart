import 'package:dartz/dartz.dart';
import 'package:clothes_ecommerce_app/core/error/failure.dart';
import 'package:clothes_ecommerce_app/feature/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  // Sign up with email verification
  Future<Either<Failure, void>> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  });

  // Verify email with OTP code
  Future<Either<Failure, UserEntity>> verifyEmailOTP({
    required String email,
    required String token,
  });

  // Resend verification code
  Future<Either<Failure, void>> resendVerificationCode(String email);

  // Sign in with email and password
  Future<Either<Failure, UserEntity>> signInWithEmail({
    required String email,
    required String password,
  });

  // Sign in with Google
  Future<Either<Failure, UserEntity>> signInWithGoogle();

  // Sign in with Apple
  Future<Either<Failure, UserEntity>> signInWithApple();

  // Send password reset code
  Future<Either<Failure, void>> sendPasswordResetCode(String email);

  // Verify password reset code
  Future<Either<Failure, void>> verifyPasswordResetCode({
    required String email,
    required String token,
  });

  // Reset password
  Future<Either<Failure, void>> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  });

  // Upload user profile photo
  Future<Either<Failure, String>> uploadProfilePhoto({
    required String userId,
    required String filePath,
  });

  // Delete user profile photo
  Future<Either<Failure, void>> deleteProfilePhoto(String userId);

  // Update user profile
  Future<Either<Failure, UserEntity>> updateUserProfile({
    String? displayName,
    String? photoUrl,
  });

  // Get current user
  Future<Either<Failure, UserEntity?>> getCurrentUser();

  // Sign out
  Future<Either<Failure, void>> signOut();

  // Delete account
  Future<Either<Failure, void>> deleteAccount();

  // Listen to auth state changes
  Stream<UserEntity?> get authStateChanges;
}
