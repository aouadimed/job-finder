import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/network/network_info.dart';
import 'package:cv_frontend/features/job_details_and_apply/data/data_source/job_apply_remote_data_source.dart';
import 'package:cv_frontend/features/job_details_and_apply/domain/repository/job_apply_repository.dart';
import 'package:cv_frontend/features/job_details_and_apply/domain/usecases/job_apply_use_case.dart';
import 'package:dartz/dartz.dart';

class JobApplyRepositoryImpl implements JobApplyRepository {
  final NetworkInfo networkInfo;
  final JobApplyRemoteDataSource jobApplyRemoteDataSource;

  JobApplyRepositoryImpl(
      {required this.networkInfo, required this.jobApplyRemoteDataSource});

  @override
  Future<Either<Failure, void>> jobApply(JobApplyParams params) async {
    if (await networkInfo.isConnected == false) {
      return left(ConnexionFailure());
    }
    try {
      await jobApplyRemoteDataSource.jobApply(params);
      return const Right(null);
    } catch (e) {
      return Left(ConnexionFailure());
    }
  }
}
