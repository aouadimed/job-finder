import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/network/network_info.dart';
import 'package:cv_frontend/features/job_seeker_home/data/data_source/searsh_page_remote_data_source.dart';
import 'package:cv_frontend/features/job_seeker_home/data/models/job_card_model.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/repository/searsh_page_repository.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/usecases/filter_job_offer_use_case.dart';
import 'package:dartz/dartz.dart';

class SearchPageRepositoryImpl implements SearchPageRepository {
  final NetworkInfo networkInfo;
  final SearshPageRemoteDataSource searshPageRemoteDataSource;

  SearchPageRepositoryImpl(
      {required this.networkInfo, required this.searshPageRemoteDataSource});

  @override
  Future<Either<Failure, JobCardModel>> getFilteredJobOffer(
      FilterJobOfferParams params) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final jobOffers =
          await searshPageRemoteDataSource.getFilteredJobOffer(params);
      return Right(jobOffers);
    } catch (e) {
      return Left(ConnexionFailure());
    }
  }
}
