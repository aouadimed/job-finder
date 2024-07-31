import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/network/network_info.dart';
import 'package:cv_frontend/features/recruiter_applications/data/data_source/job_offer_remote_data_source.dart';
import 'package:cv_frontend/features/recruiter_applications/data/models/job_offer_model.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/repository/job_offer_repository.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/usecases/job_offer_use_cases/add_job_offer_use_cases.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/usecases/job_offer_use_cases/get_list_job_offer_use_cases.dart';
import 'package:dartz/dartz.dart';

class JobOfferRepositoryImpl implements JobOfferRepository {
  final JobOfferRemoteDataSource jobOfferRemoteDataSource;
  final NetworkInfo networkInfo;

  JobOfferRepositoryImpl(
      {required this.jobOfferRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, void>> addJobOffer(AddJobOfferParams params) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      await jobOfferRemoteDataSource.addJobOffer(params);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, JobOffersModel>> getJobOfferList(
      PageParams pageParams) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final joboffer =
          await jobOfferRemoteDataSource.getJobOfferList(pageParams);
      return Right(joboffer);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
