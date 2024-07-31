import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/network/network_info.dart';
import 'package:cv_frontend/features/recruiter_applications/data/data_source/job_category_remote_data_source.dart';
import 'package:cv_frontend/features/recruiter_applications/data/models/job_category_model.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/repository/job_category_repository.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/usecases/job_category_use_cases/get_job_category_use_case.dart';
import 'package:dartz/dartz.dart';

class JobCategoryRepositoryImpl implements JobCategoryRepository {
  final JobCategoryRemoteDataSource jobCategoryRemoteDataSource;
  final NetworkInfo networkInfo;

  JobCategoryRepositoryImpl(
      {required this.jobCategoryRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<JobCategoryModel>>> getJobCategory(
      GetJobCategoryParams params) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final jobCategoryModel =
          await jobCategoryRemoteDataSource.getJobCategory(params);
      return Right(jobCategoryModel);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
