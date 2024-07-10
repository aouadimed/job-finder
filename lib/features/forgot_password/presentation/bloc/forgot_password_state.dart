part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object?> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordFailure extends ForgotPasswordState {
  final bool isIntentFailure;
  final String message;

  const ForgotPasswordFailure({
    required this.isIntentFailure,
    required this.message,
  });

  @override
  List<Object?> get props => [isIntentFailure, message];
}

class ForgotPasswordSuccess extends ForgotPasswordState {}




