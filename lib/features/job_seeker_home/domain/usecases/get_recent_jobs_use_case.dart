import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/job_seeker_home/data/models/job_card_model.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/repository/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetRecentJobsUseCases implements UseCase<JobCardModel, GetRecentJobsParams> {
  final HomeRepository homeRepository;

  GetRecentJobsUseCases({required this.homeRepository});
  @override
  Future<Either<Failure, JobCardModel>> call(GetRecentJobsParams params) async {
    return await homeRepository.getRecentJobs(params);
  }
}


class GetRecentJobsParams extends Equatable {
  final int page;

 const GetRecentJobsParams({required this.page});
  
  @override
  List<Object?> get props => [page];
}
