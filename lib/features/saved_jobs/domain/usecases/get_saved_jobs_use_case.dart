import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/saved_jobs/data/models/saved_jobs_model.dart';
import 'package:cv_frontend/features/saved_jobs/domain/repository/saved_job_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetSavedJobsUsecase
    implements UseCase<SavedJobsModel, GetSavedJobsParams> {
  final SavedJobsRepository savedJobsRepository;

  GetSavedJobsUsecase({required this.savedJobsRepository});

  @override
  Future<Either<Failure,SavedJobsModel>> call(
      GetSavedJobsParams params) async {
    return await savedJobsRepository.getSavedJobs(params);
  }
}

class GetSavedJobsParams extends Equatable {
  final int page;
  final String? searchQuery;

  const GetSavedJobsParams({required this.page, required this.searchQuery});

  @override
  List<Object?> get props => [page, searchQuery];
}
