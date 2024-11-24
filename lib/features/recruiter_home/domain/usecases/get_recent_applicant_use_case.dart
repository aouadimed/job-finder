import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/recruiter_applicants/data/models/applicant_model.dart';
import 'package:cv_frontend/features/recruiter_home/domain/repository/recruiter_home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetRecentApplicantUseCase
    implements UseCase<ApplicantModel, GetRecentApplicantParams> {
  final RecruiterHomeRepository recruiterHomeRepository;

  GetRecentApplicantUseCase({required this.recruiterHomeRepository});

  @override
  Future<Either<Failure, ApplicantModel>> call(
      GetRecentApplicantParams params) async {
    return await recruiterHomeRepository.getApplicants(params);
  }
}

class GetRecentApplicantParams extends Equatable {
  final String searshQuery;
  final int page;

  const GetRecentApplicantParams(
      {required this.searshQuery, required this.page});
  @override
  List<Object?> get props => [searshQuery, page];
}
