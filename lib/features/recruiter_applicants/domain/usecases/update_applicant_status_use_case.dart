import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/recruiter_applicants/domain/repository/applicant_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateApplicantUseCase implements UseCase<void, UpdateApplicantParams> {
  final ApplicantRepository applicantRepository;

  UpdateApplicantUseCase({required this.applicantRepository});

  @override
  Future<Either<Failure, void>> call(UpdateApplicantParams params) async {
    return await applicantRepository.updateStatus(params);
  }
}

class UpdateApplicantParams extends Equatable {
  final String id;
  final String status;

  const UpdateApplicantParams({required this.id, required this.status});

  @override
  List<Object?> get props => [id, status];
}
