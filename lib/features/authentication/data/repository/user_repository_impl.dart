import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/network/network_info.dart';
import 'package:cv_frontend/features/authentication/data/data_sources/remote_data_source/authentification_remote_data_source.dart';
import 'package:cv_frontend/features/authentication/data/models/user_model.dart';
import 'package:cv_frontend/features/authentication/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final NetworkInfo networkInfo;
  final AuthRemoteDataSource authRemoteDataSource;

  const UserRepositoryImpl({
    required this.networkInfo,
    required this.authRemoteDataSource,
  });

  @override
  Future<Either<Failure, UserModel>> loginUser({
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected == false) {
      throw ConnexionFailure();
    }
    try {
      final userModel = await authRemoteDataSource.loginUser(
        email: email,
        password: password,
      );
      return Right(userModel);
    } catch (e) {
      if (e.runtimeType == WrongCredentialException) {
        return Left(UserCredentialFailure());
      } else {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, UserModel>> signUpUser(
      {required String username,
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
      required String address}) async {
    if (await networkInfo.isConnected == false) {
      throw ConnexionFailure();
    }
    try {
      final userModel = await authRemoteDataSource.signUpUser(
        username: username,
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        dateOfBirth: dateOfBirth,
        phone: phone,
        gender: gender,
        country: country,
        role: role,
        expertise: expertise,
        address: address,
      );
      return Right(userModel);
    } catch (e) {
      if (e.runtimeType == EmailExistsFailure) {
        return Left(EmailExistsFailure());
      } else if (e.runtimeType == UsernameFailure) {
        return Left(UsernameFailure());
      } else {
        return Left(ServerFailure());
      }
    }
  }
}
