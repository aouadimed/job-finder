import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/authentication/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, UserModel>> loginUser({
    required String email,
    required String password,
  });

  Future<Either<Failure,UserModel>> signUpUser({
    required String username,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    required String email,
    required String phone,
    required String gender,
    required String country,
    required String role,
    required List<int> expertise,
    required String password,
    required String address
  });
}
