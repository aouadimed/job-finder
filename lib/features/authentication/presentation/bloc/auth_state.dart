part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final UserModel userModel;

  const LoginSuccess({required this.userModel});

  @override
  List<Object?> get props => [userModel];
}

class AuthFailure extends AuthState {
  final bool isIntentFailure;
  final String message;

  const AuthFailure({
    required this.isIntentFailure,
    required this.message,
  });

  @override
  List<Object?> get props => [isIntentFailure, message];
}

class RegisterSuccess extends AuthState {}
