import 'package:clothes_ecommerce_app/feature/auth/data/service/auth_service.dart';
import 'package:clothes_ecommerce_app/feature/auth/domain/repo/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:clothes_ecommerce_app/core/error/exception_handler.dart';
import 'package:clothes_ecommerce_app/core/error/failure.dart';
import 'package:clothes_ecommerce_app/feature/auth/domain/entities/user_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;

  AuthRepositoryImpl({required this.authService});

  @override
  Future<Either<Failure, void>> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      await authService.signUpWithEmail(
        email: email,
        password: password,
        displayName: displayName,
      );
      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> verifyEmailOTP({
    required String email,
    required String token,
  }) async {
    try {
      final user = await authService.verifyEmailOTP(
        email: email,
        token: token,
      );
      return Right(user);
    } catch (e) {
      return Left(ExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, void>> resendVerificationCode(String email) async {
    try {
      await authService.resendVerificationCode(email);
      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final user = await authService.signInWithEmail(
        email: email,
        password: password,
      );
      return Right(user);
    } catch (e) {
      return Left(ExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      final user = await authService.signInWithGoogle();
      return Right(user);
    } catch (e) {
      return Left(AuthFailure.googleSignInFailed());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithApple() async {
    try {
      final user = await authService.signInWithApple();
      return Right(user);
    } catch (e) {
      return Left(AuthFailure.appleSignInFailed());
    }
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetCode(String email) async {
    try {
      await authService.sendPasswordResetCode(email);
      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, void>> verifyPasswordResetCode({
    required String email,
    required String token,
  }) async {
    try {
      await authService.verifyPasswordResetCode(
        email: email,
        token: token,
      );
      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  }) async {
    try {
      await authService.resetPassword(
        email: email,
        token: token,
        newPassword: newPassword,
      );
      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePhoto({
    required String userId,
    required String filePath,
  }) async {
    try {
      final photoUrl = await authService.uploadProfilePhoto(
        userId: userId,
        filePath: filePath,
      );
      return Right(photoUrl);
    } catch (e) {
      return Left(ExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProfilePhoto(String userId) async {
    try {
      await authService.deleteProfilePhoto(userId);
      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateUserProfile({
    String? displayName,
    String? photoUrl,
  }) async {
    try {
      final user = await authService.updateUserProfile(
        displayName: displayName,
        photoUrl: photoUrl,
      );
      return Right(user);
    } catch (e) {
      return Left(ExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final user = await authService.getCurrentUser();
      return Right(user);
    } catch (e) {
      return Left(ExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await authService.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    try {
      await authService.deleteAccount();
      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.handleException(e));
    }
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    return authService.authStateChanges;
  }
}
