import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/job_details_and_apply/data/models/job_offer_details.dart';
import 'package:cv_frontend/features/job_details_and_apply/domain/usecases/get_job_offer_detail.dart';
import 'package:dartz/dartz.dart';

abstract class JobDetailsRepository {
  Future<Either<Failure, JobOfferDetailsModel>> getJobOffer(
      GetJobOfferDetailParams params);
}
