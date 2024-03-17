import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/authentication/data/models/user_model.dart';
import 'package:cv_frontend/features/authentication/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LoginUserUseCase extends UseCase<UserModel, LoginUserParams> {
  final UserRepository userRepository;

  const LoginUserUseCase({
    required this.userRepository,
  });

  @override
  Future<Either<Failure, UserModel>> call(LoginUserParams params) async {
    return await userRepository.loginUser(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginUserParams extends Equatable {
  final String email;
  final String password;

  const LoginUserParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
