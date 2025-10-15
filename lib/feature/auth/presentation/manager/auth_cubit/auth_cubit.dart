import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:clothes_ecommerce_app/feature/auth/domain/entities/user_entity.dart';
import 'package:clothes_ecommerce_app/feature/auth/domain/repo/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  StreamSubscription<UserEntity?>? authSubscription;

  AuthCubit({required this.authRepository}) : super(AuthInitial()) {
    initAuthListener();
  }

  void initAuthListener() {
    authSubscription?.cancel();
    authSubscription = authRepository.authStateChanges.listen((user) {
      if (!isClosed) {
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(AuthUnauthenticated());
        }
      }
    });
  }

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

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());

    final result = await authRepository.signInWithGoogle();

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> signInWithApple() async {
    emit(AuthLoading());

    final result = await authRepository.signInWithApple();

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> sendPasswordResetCode(String email) async {
    emit(AuthLoading());

    final result = await authRepository.sendPasswordResetCode(email);

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthPasswordResetVerification(email)),
    );
  }

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
        await refreshUser();
        emit(const AuthSuccess('Profile photo uploaded successfully'));
      },
    );
  }

  Future<void> deleteProfilePhoto(String userId) async {
    emit(AuthLoading());

    final result = await authRepository.deleteProfilePhoto(userId);

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) async {
        await refreshUser();
        emit(const AuthSuccess('Profile photo deleted successfully'));
      },
    );
  }

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

  Future<void> signOut() async {
    emit(AuthLoading());

    final result = await authRepository.signOut();

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthUnauthenticated()),
    );
  }

  Future<void> deleteAccount() async {
    emit(AuthLoading());

    final result = await authRepository.deleteAccount();

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthUnauthenticated()),
    );
  }

  Future<void> refreshUser() async {
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

  @override
  Future<void> close() {
    authSubscription?.cancel();
    return super.close();
  }
}