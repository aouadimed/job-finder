import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/network/network_info.dart';
import 'package:cv_frontend/features/job_seeker_home/data/data_source/home_remote_data_source.dart';
import 'package:cv_frontend/features/job_seeker_home/data/models/job_card_model.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/repository/home_repository.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/usecases/get_recent_jobs_use_case.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImpl implements HomeRepository {
  final NetworkInfo networkInfo;
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepositoryImpl(
      {required this.networkInfo, required this.homeRemoteDataSource});

  @override
  Future<Either<Failure,JobCardModel>> getRecentJobs(GetRecentJobsParams params) async {
    if (await networkInfo.isConnected == false) {
      return Left(ServerFailure());
    }
    try {
      final jobOfferModel = await homeRemoteDataSource.getRecentJobs(params);
      return Right(jobOfferModel);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
