part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({
    required this.email,
    required this.password,
  });

  @override
  List<String?> get props => [email, password];
}

class RegisterEvent extends AuthEvent {
  final String username;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String email;
  final String phone;
  final String gender;
  final String country;
  final String role;
  final List<int> expertise;
  final String password;
  final String address;

  const RegisterEvent({
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.phone,
    required this.gender,
    required this.country,
    required this.role,
    required this.expertise,
    required this.username,
    required this.email,
    required this.password,
    required this.address
  });

  @override
  List<String?> get props => [username, email, password,];
}
