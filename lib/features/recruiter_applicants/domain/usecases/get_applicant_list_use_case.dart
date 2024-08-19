import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/recruiter_applicants/data/models/applicant_model.dart';
import 'package:cv_frontend/features/recruiter_applicants/domain/repository/applicant_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetApplicantsListUseCase
    implements UseCase<ApplicantModel, GetApplicantsListParams> {
  final ApplicantRepository applicantRepository;

  const GetApplicantsListUseCase({required this.applicantRepository});

  @override
  Future<Either<Failure, ApplicantModel>> call(
      GetApplicantsListParams params) async {
    return await applicantRepository.getApplicants(params);
  }
}

class GetApplicantsListParams extends Equatable {
  final String id;
  final int page;

  const GetApplicantsListParams({required this.page, required this.id});

  @override
  List<Object?> get props => [page,id];
}
