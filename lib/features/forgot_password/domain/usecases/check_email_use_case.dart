import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/forgot_password/domain/repository/forgot_password_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CheckEmailUseCase implements UseCase<void, CheckEmailParams> {
  final ForgotPasswordRepository forgotPasswordRepository;

  CheckEmailUseCase({required this.forgotPasswordRepository});

  @override
  Future<Either<Failure, void>> call(CheckEmailParams params) async {
    return await forgotPasswordRepository.checkEmail(email: params.email);
  }
}

class CheckEmailParams extends Equatable {
  final String email;

  const CheckEmailParams({required this.email});

  @override
  List<Object?> get props => [email];
}
