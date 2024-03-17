import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/authentication/data/models/user_model.dart';
import 'package:cv_frontend/features/authentication/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SignUpUserUseCase extends UseCase<Unit, SignUpUserParams> {
  final UserRepository userRepository;

  const SignUpUserUseCase({
    required this.userRepository,
  });

  @override
  Future<Either<Failure, Unit>> call(SignUpUserParams params) async {
    return await userRepository.signUpUser(
      username: params.username,
      email: params.email,
      password: params.password,
    );
  }
}

class SignUpUserParams extends Equatable {
  final String username;
  final String email;
  final String password;

  const SignUpUserParams({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [username, email, password];
}
