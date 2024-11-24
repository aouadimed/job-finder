import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/recruiter_applicants/data/models/applicant_model.dart';
import 'package:cv_frontend/features/recruiter_home/domain/usecases/get_recent_applicant_use_case.dart';
import 'package:dartz/dartz.dart';

abstract class RecruiterHomeRepository {
  Future<Either<Failure, ApplicantModel>> getApplicants(
      GetRecentApplicantParams params);
}
