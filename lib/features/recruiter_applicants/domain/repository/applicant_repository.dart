import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/recruiter_applicants/data/models/applicant_model.dart';
import 'package:cv_frontend/features/recruiter_applicants/domain/usecases/get_applicant_list_use_case.dart';
import 'package:cv_frontend/features/recruiter_applicants/domain/usecases/send_msg_applicant_use_case.dart';
import 'package:cv_frontend/features/recruiter_applicants/domain/usecases/update_applicant_status_use_case.dart';
import 'package:dartz/dartz.dart';

abstract class ApplicantRepository {
  Future<Either<Failure, ApplicantModel>> getApplicants(
      GetApplicantsListParams params);
  Future<Either<Failure, void>> updateStatus(UpdateApplicantParams params);
  Future<Either<Failure, void>> sendMessageToApplicant(
      SendMessageToApplicantParams params);
}
