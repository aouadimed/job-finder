import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/network/network_info.dart';
import 'package:cv_frontend/features/forgot_password/data/data_source/forgot_password_remote_data_source.dart';
import 'package:cv_frontend/features/forgot_password/domain/repository/forgot_password_repository.dart';
import 'package:dartz/dartz.dart';

class ForgotPasswordRepositoryImpl extends ForgotPasswordRepository {
  final NetworkInfo networkInfo;
  final ForgotPasswordRemoteDataSource forgotPasswordRemoteDataSource;

  ForgotPasswordRepositoryImpl(
      {required this.networkInfo,
      required this.forgotPasswordRemoteDataSource});

  @override
  Future<Either<Failure, void>> checkEmail({required String email}) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final status =
          await forgotPasswordRemoteDataSource.checkEmail(email: email);
      return Right(status);
    } catch (e) {
      if (e.runtimeType == EmailFailure) {
        return Left(EmailFailure());
      } else {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> checkVerificationCode(
      {required String email, required String resetCode}) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final status = await forgotPasswordRemoteDataSource.codeVerfication(
          email: email, resetCode: resetCode);
      return Right(status);
    } catch (e) {
      if (e.runtimeType == EmailFailure) {
        return Left(EmailFailure());
      } else if (e.runtimeType == InvalidRestCodeFailure) {
        return Left(InvalidRestCodeFailure());
      } else {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> changePassword(
      {required String email, required String newPassword}) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final status = await forgotPasswordRemoteDataSource.changePassword(
          email: email, newPassword: newPassword);
      return Right(status);
    } catch (e) {
      if (e.runtimeType == EmailFailure) {
        return Left(EmailFailure());
      } else if (e.runtimeType == InvalidRestCodeFailure) {
        return Left(InvalidRestCodeFailure());
      } else {
        return Left(ServerFailure());
      }
    }
  }
}
