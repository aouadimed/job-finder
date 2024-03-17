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
    // user already have cnx

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
}
