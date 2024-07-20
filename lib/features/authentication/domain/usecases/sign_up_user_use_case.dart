import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/authentication/data/models/user_model.dart';
import 'package:cv_frontend/features/authentication/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SignUpUserUseCase extends UseCase<UserModel, SignUpUserParams> {
  final UserRepository userRepository;

  const SignUpUserUseCase({
    required this.userRepository,
  });

  @override
  Future<Either<Failure, UserModel>> call(SignUpUserParams params) async {
    return await userRepository.signUpUser(
      username: params.username,
      email: params.email,
      password: params.password,
      firstName: params.firstName,
      lastName: params.lastName,
      dateOfBirth: params.dateOfBirth,
      phone: params.phone,
      gender: params.gender,
      country: params.country,
      role: params.role,
      expertise: params.expertise,
      address: params.address,
    );
  }
}

class SignUpUserParams extends Equatable {
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

  const SignUpUserParams(
      {required this.firstName,
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
      required this.address});

  @override
  List<Object?> get props => [username, email, password];
}
