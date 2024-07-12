import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/forgot_password/domain/repository/forgot_password_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ChangePasswordParams extends Equatable {
  final String email;
  final String newPassword;

  const ChangePasswordParams({required this.email, required this.newPassword});

  @override
  List<Object?> get props => [email, newPassword];
}

class ChangePasswordUseCase implements UseCase<void, ChangePasswordParams> {
  final ForgotPasswordRepository forgotPasswordRepository;

  ChangePasswordUseCase({required this.forgotPasswordRepository});

  @override
  Future<Either<Failure, void>> call(ChangePasswordParams params) async {
    return await forgotPasswordRepository.changePassword(
        email: params.email, newPassword: params.newPassword);
  }
}
