import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/recruiter_applicants/domain/repository/applicant_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SendMessageToApplicantUseCase
    implements UseCase<void, SendMessageToApplicantParams> {
  final ApplicantRepository applicantRepository;

  SendMessageToApplicantUseCase({required this.applicantRepository});

  @override
  Future<Either<Failure, void>> call(
      SendMessageToApplicantParams params) async {
    return await applicantRepository.sendMessageToApplicant(params);
  }
}

class SendMessageToApplicantParams extends Equatable {
  final String id;

  const SendMessageToApplicantParams({required this.id});

  @override
  List<Object?> get props => [id];
}
