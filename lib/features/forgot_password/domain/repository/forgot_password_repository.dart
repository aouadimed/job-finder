import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/forgot_password/presentation/pages/widget/change_password_page.dart';
import 'package:dartz/dartz.dart';

abstract class ForgotPasswordRepository {
  Future<Either<Failure, void>> checkEmail({required String email});

  Future<Either<Failure, void>> checkVerificationCode(
      {required String email, required String resetCode});

       Future<Either<Failure, void>> changePassword(
      {required String email, required String newPassword});
}
