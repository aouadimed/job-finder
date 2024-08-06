import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/job_details_and_apply/data/models/job_offer_details.dart';
import 'package:cv_frontend/features/job_details_and_apply/domain/repository/job_details_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetJobOfferDetailUseCase
    implements UseCase<JobOfferDetailsModel, GetJobOfferDetailParams> {
  final JobDetailsRepository jobDetailsRepository;

  GetJobOfferDetailUseCase({required this.jobDetailsRepository});
  @override
  Future<Either<Failure, JobOfferDetailsModel>> call(
      GetJobOfferDetailParams params) async {
    return await jobDetailsRepository.getJobOffer(params);
  }
}

class GetJobOfferDetailParams extends Equatable {
  final String id;

  const GetJobOfferDetailParams({required this.id});

  @override
  List<Object?> get props => [id];
}
