import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/forgot_password/domain/repository/forgot_password_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CodeVerificationParams extends Equatable {
  final String email;
  final String resetCode;

  const CodeVerificationParams({required this.email, required this.resetCode});

  @override
  List<Object?> get props => [email, resetCode];
}

class CodeVerificationUseCase implements UseCase<void, CodeVerificationParams> {
  final ForgotPasswordRepository forgotPasswordRepository;

  CodeVerificationUseCase({required this.forgotPasswordRepository});

  @override
  Future<Either<Failure, void>> call(CodeVerificationParams params) async {
    return await forgotPasswordRepository.checkVerificationCode(
        email: params.email, resetCode: params.resetCode);
  }
}
