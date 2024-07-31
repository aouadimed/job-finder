import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/recruiter_applications/data/models/job_category_model.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/repository/job_category_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetJobCategoryUseCase
    implements UseCase<List<JobCategoryModel>, GetJobCategoryParams> {
  final JobCategoryRepository jobCategoryRepository;

  GetJobCategoryUseCase({required this.jobCategoryRepository});
  @override
  Future<Either<Failure, List<JobCategoryModel>>> call(
      GetJobCategoryParams params) async {
    return await jobCategoryRepository.getJobCategory(params);
  }
}

class GetJobCategoryParams extends Equatable {
  final String? searchQuery;

  const GetJobCategoryParams({required this.searchQuery});

  @override
  List<Object?> get props => [searchQuery];
}
