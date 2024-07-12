part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object?> get props => [];
}

class CheckEmailEvent extends ForgotPasswordEvent {
  final String email;

  const CheckEmailEvent({
    required this.email,
  });

  @override
  List<String?> get props => [email];
}

class CodeVerificationEvent extends ForgotPasswordEvent {
  final String email;
  final String resetCode;

  const CodeVerificationEvent({
    required this.resetCode,
    required this.email,
  });

  @override
  List<String?> get props => [email, resetCode];
}

class ChangePasswordEvent extends ForgotPasswordEvent {
  final String email;
  final String newPassword;

  const ChangePasswordEvent({
    required this.newPassword,
    required this.email,
  });

  @override
  List<String?> get props => [email, newPassword];
}
