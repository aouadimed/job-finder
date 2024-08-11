import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/network/network_info.dart';
import 'package:cv_frontend/features/saved_jobs/data/data_source/saved_jobs_remote_data_source.dart';
import 'package:cv_frontend/features/saved_jobs/data/models/saved_jobs_model.dart';
import 'package:cv_frontend/features/saved_jobs/domain/repository/saved_job_repository.dart';
import 'package:cv_frontend/features/saved_jobs/domain/usecases/get_saved_jobs_use_case.dart';
import 'package:dartz/dartz.dart';

class SavedJobsRepositoryImpl implements SavedJobsRepository {
  final NetworkInfo networkInfo;
  final SavedJobsRemoteDataSource savedJobsRemoteDataSource;

  SavedJobsRepositoryImpl(
      {required this.networkInfo, required this.savedJobsRemoteDataSource});

  @override
  Future<Either<Failure, SavedJobsModel>> getSavedJobs(
      GetSavedJobsParams params) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final savedJobsModel =
          await savedJobsRemoteDataSource.getSavedJobs(params);

      return Right(savedJobsModel);
    } catch (e) {
      return Left(ConnexionFailure());
    }
  }
}
