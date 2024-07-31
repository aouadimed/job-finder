import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/recruiter_applications/data/models/job_offer_model.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/repository/job_offer_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetListJobOfferUseCase implements UseCase<JobOffersModel, PageParams> {
  final JobOfferRepository jobOfferRepository;

  GetListJobOfferUseCase({required this.jobOfferRepository});

  @override
  Future<Either<Failure,JobOffersModel>> call(PageParams params) async {
    return await jobOfferRepository.getJobOfferList(params);
  }
}

class PageParams extends Equatable {
  final int page;
  final String? searchQuery;
  final int? filterIndex;

  const PageParams({required this.page, required this.searchQuery, required this.filterIndex});
  
  @override
  List<Object?> get props => [page,searchQuery,filterIndex];
}
