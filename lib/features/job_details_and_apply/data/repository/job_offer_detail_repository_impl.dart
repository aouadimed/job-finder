import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/network/network_info.dart';
import 'package:cv_frontend/features/job_details_and_apply/data/data_source/job_details_remote_data_source.dart';
import 'package:cv_frontend/features/job_details_and_apply/data/models/job_offer_details.dart';
import 'package:cv_frontend/features/job_details_and_apply/domain/repository/job_details_repository.dart';
import 'package:cv_frontend/features/job_details_and_apply/domain/usecases/get_job_offer_detail.dart';
import 'package:dartz/dartz.dart';

class JobDetailsRepositoryImpl implements JobDetailsRepository {
  final JobDetailsRemoteDataSource jobDetailsRemoteDataSource;
  final NetworkInfo networkInfo;

  JobDetailsRepositoryImpl(
      {required this.jobDetailsRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, JobOfferDetailsModel>> getJobOffer(
      GetJobOfferDetailParams params) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final jobDetail =
          await jobDetailsRemoteDataSource.getJobOffer(id: params.id);
      return Right(jobDetail);
    } catch (e) {
      return Left(ConnexionFailure());
    }
  }
}