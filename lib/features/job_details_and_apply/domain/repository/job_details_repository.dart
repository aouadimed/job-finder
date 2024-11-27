import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/job_details_and_apply/data/models/job_offer_details.dart';
import 'package:cv_frontend/features/job_details_and_apply/domain/usecases/delete_job_offer_use_case.dart';
import 'package:cv_frontend/features/job_details_and_apply/domain/usecases/edit_job_offer_use_case.dart';
import 'package:cv_frontend/features/job_details_and_apply/domain/usecases/get_job_offer_detail_use_case.dart';
import 'package:dartz/dartz.dart';

abstract class JobDetailsRepository {
  Future<Either<Failure, void>> editJobOffer(EditJobOfferParams params);
  Future<Either<Failure, void>> deleteJobOffer(DeleteJobOfferParams params);

  Future<Either<Failure, JobOfferDetailsModel>> getJobOffer(
      GetJobOfferDetailParams params);
}
