import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/recruiter_applications/data/models/job_offer_model.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/usecases/job_offer_use_cases/add_job_offer_use_cases.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/usecases/job_offer_use_cases/get_list_job_offer_use_cases.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/usecases/job_offer_use_cases/toggle_status_use_case.dart';
import 'package:dartz/dartz.dart';

abstract class JobOfferRepository {
  Future<Either<Failure, void>> addJobOffer(AddJobOfferParams params);
  Future<Either<Failure, JobOffersModel>> getJobOfferList(
      PageParams pageParams);
  Future<Either<Failure, void>> toggleStatusUseCase(ToggleStatusPararms pararms);
}
