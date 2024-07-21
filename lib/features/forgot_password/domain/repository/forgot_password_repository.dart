import 'package:cv_frontend/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ForgotPasswordRepository {
  Future<Either<Failure, void>> checkEmail({required String email});

  Future<Either<Failure, void>> checkVerificationCode(
      {required String email, required String resetCode});

       Future<Either<Failure, void>> changePassword(
      {required String email, required String newPassword});
}
