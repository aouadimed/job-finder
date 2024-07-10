import 'package:cv_frontend/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ForgotPasswordRepository {
    Future<Either<Failure, void>> checkEmail({required String email});
}