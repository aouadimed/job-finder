import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/network/network_info.dart';
import 'package:cv_frontend/features/job_seeker_home/data/data_source/save_job_remote_data_source.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/repository/save_job_repository.dart';
import 'package:dartz/dartz.dart';

class SavedJobRepositoryImpl implements SavedJobRepository {
  final SavedJobRemoteDataSource savedJobRemoteDataSource;
  final NetworkInfo networkInfo;

  SavedJobRepositoryImpl(
      {required this.savedJobRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, bool>> checkSavedJobStatus(
      {required String id}) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final status = await savedJobRemoteDataSource.checkSavedJob(id: id);
      return Right(status);
    } catch (e) {
      return Left(ConnexionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveJobStatus({required String id}) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final status = await savedJobRemoteDataSource.saveJob(id: id);
      return Right(status);
    } catch (e) {
      return Left(ConnexionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteJobStatus({required String id}) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final status = await savedJobRemoteDataSource.deleteJob(id: id);
      return Right(status);
    } catch (e) {
      return Left(ConnexionFailure());
    }
  }
}
