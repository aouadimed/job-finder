import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/job_seeker_home/data/models/job_card_model.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/repository/searsh_page_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class FilterJobOfferUseCase
    implements UseCase<JobCardModel, FilterJobOfferParams> {
  final SearchPageRepository searchPageRepository;

  FilterJobOfferUseCase({required this.searchPageRepository});

  @override
  Future<Either<Failure, JobCardModel>> call(
      FilterJobOfferParams params) async {
    return await searchPageRepository.getFilteredJobOffer(params);
  }
}

class FilterJobOfferParams extends Equatable {
  final int page;
  final String location;
  final List<int> workTypeIndexes;
  final List<String> jobLevel;
  final List<int> employmentTypeIndexes;
  final List<String> experience;
  final List<String> education;
  final List<String> jobFunctionIds;
  final String searchQuery;

  const FilterJobOfferParams(
      {required this.searchQuery,
      required this.page,
      required this.location,
      required this.workTypeIndexes,
      required this.jobLevel,
      required this.employmentTypeIndexes,
      required this.experience,
      required this.education,
      required this.jobFunctionIds});

  @override
  List<Object?> get props => [
        page,
        location,
        workTypeIndexes,
        jobLevel,
        employmentTypeIndexes,
        experience,
        education,
        jobFunctionIds,
        searchQuery
      ];
}
