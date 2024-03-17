import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/authentication/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, UserModel>> loginUser({
    required String email,
    required String password,
  });

  Future<Either<Failure, Unit>> signUpUser({
    required String username,
    required String email,
    required String password,
  });

  // Future<DataState<UserEntity>> getUser(Map<String, dynamic> loginCredentials);
}
