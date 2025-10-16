part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserEntity user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthVerificationRequired extends AuthState {
  final String email;

  const AuthVerificationRequired(this.email);

  @override
  List<Object?> get props => [email];
}

class AuthPasswordResetVerification extends AuthState {
  final String email;

  const AuthPasswordResetVerification(this.email);

  @override
  List<Object?> get props => [email];
}

class AuthPasswordResetCodeVerified extends AuthState {
  final String email;
  final String token;

  const AuthPasswordResetCodeVerified({
    required this.email,
    required this.token,
  });

  @override
  List<Object?> get props => [email, token];
}

class AuthPasswordResetInProgress extends AuthState {
  final String email;
  final String? token;

  const AuthPasswordResetInProgress({
    required this.email,
    this.token,
  });

  @override
  List<Object?> get props => [email, token];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthSuccess extends AuthState {
  final String message;

  const AuthSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
