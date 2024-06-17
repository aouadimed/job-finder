
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/network/network_info.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/summary_remote_data_source.dart';
import 'package:cv_frontend/features/profil/data/models/summary_model.dart';
import 'package:cv_frontend/features/profil/domain/repository/summarry_repository.dart';
import 'package:dartz/dartz.dart';

class SummaryRepositoryImpl implements SummaryRepository {
  final NetworkInfo networkInfo;
  final SummaryRemoteDataSource summaryRemoteDataSource;

  const SummaryRepositoryImpl(
      {required this.networkInfo, required this.summaryRemoteDataSource});

  @override
  Future<Either<Failure, bool>> createOrUpdateSummary(
      {required String description}) async {
    if (await networkInfo.isConnected == false) {
          throw ConnexionFailure();
    }
    try {
      final status = await summaryRemoteDataSource.createOrUpdateSummary(
          description: description);
     

      return right(status);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, SummaryModel>> getSummary() async {
    if (await networkInfo.isConnected == false) {
          throw ConnexionFailure();
    }
    try {
      final summaryModel = await summaryRemoteDataSource.getSummary();
      return right(summaryModel);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
