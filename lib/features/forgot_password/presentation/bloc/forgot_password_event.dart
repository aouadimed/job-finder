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



