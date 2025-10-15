import 'package:bloc/bloc.dart';
import 'package:clothes_ecommerce_app/feature/auth/domain/entities/user_entity.dart';
import 'package:clothes_ecommerce_app/feature/auth/domain/repo/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit({required this.authRepository}) : super(AuthInitial()) {
    _initAuthListener();
  }

  void _initAuthListener() {
    authRepository.authStateChanges.listen((user) {
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    });
  }

  // Sign up with email
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    emit(AuthLoading());

    final result = await authRepository.signUpWithEmail(
      email: email,
      password: password,
      displayName: displayName,
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthVerificationRequired(email)),
    );
  }

  // Verify email OTP
  Future<void> verifyEmailOTP({
    required String email,
    required String token,
  }) async {
    emit(AuthLoading());

    final result = await authRepository.verifyEmailOTP(
      email: email,
      token: token,
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  // Resend verification code
  Future<void> resendVerificationCode(String email) async {
    emit(AuthLoading());

    final result = await authRepository.resendVerificationCode(email);

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) {
        emit(AuthVerificationRequired(email));
        emit(const AuthSuccess('Verification code sent successfully'));
      },
    );
  }

  // Sign in with email
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    final result = await authRepository.signInWithEmail(
      email: email,
      password: password,
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  // Sign in with Google
  Future<void> signInWithGoogle() async {
    emit(AuthLoading());

    final result = await authRepository.signInWithGoogle();

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  // Sign in with Apple
  Future<void> signInWithApple() async {
    emit(AuthLoading());

    final result = await authRepository.signInWithApple();

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  // Send password reset code
  Future<void> sendPasswordResetCode(String email) async {
    emit(AuthLoading());

    final result = await authRepository.sendPasswordResetCode(email);

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthPasswordResetVerification(email)),
    );
  }

  // Verify password reset code
  Future<void> verifyPasswordResetCode({
    required String email,
    required String token,
  }) async {
    emit(AuthLoading());

    final result = await authRepository.verifyPasswordResetCode(
      email: email,
      token: token,
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthPasswordResetCodeVerified(email: email, token: token)),
    );
  }

  // Reset password
  Future<void> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  }) async {
    emit(AuthLoading());

    final result = await authRepository.resetPassword(
      email: email,
      token: token,
      newPassword: newPassword,
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) {
        emit(AuthUnauthenticated());
        emit(const AuthSuccess('Password reset successfully'));
      },
    );
  }

  // Upload profile photo
  Future<void> uploadProfilePhoto({
    required String userId,
    required String filePath,
  }) async {
    emit(AuthLoading());

    final result = await authRepository.uploadProfilePhoto(
      userId: userId,
      filePath: filePath,
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (photoUrl) async {
        await _refreshUser();
        emit(const AuthSuccess('Profile photo uploaded successfully'));
      },
    );
  }

  // Delete profile photo
  Future<void> deleteProfilePhoto(String userId) async {
    emit(AuthLoading());

    final result = await authRepository.deleteProfilePhoto(userId);

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) async {
        await _refreshUser();
        emit(const AuthSuccess('Profile photo deleted successfully'));
      },
    );
  }

  // Update user profile
  Future<void> updateUserProfile({
    String? displayName,
    String? photoUrl,
  }) async {
    emit(AuthLoading());

    final result = await authRepository.updateUserProfile(
      displayName: displayName,
      photoUrl: photoUrl,
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) {
        emit(AuthAuthenticated(user));
        emit(const AuthSuccess('Profile updated successfully'));
      },
    );
  }

  // Sign out
  Future<void> signOut() async {
    emit(AuthLoading());

    final result = await authRepository.signOut();

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthUnauthenticated()),
    );
  }

  // Delete account
  Future<void> deleteAccount() async {
    emit(AuthLoading());

    final result = await authRepository.deleteAccount();

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthUnauthenticated()),
    );
  }

  // Refresh current user
  Future<void> _refreshUser() async {
    final result = await authRepository.getCurrentUser();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) {
        if (user != null) {
          emit(AuthAuthenticated(user));
        }
      },
    );
  }
}
