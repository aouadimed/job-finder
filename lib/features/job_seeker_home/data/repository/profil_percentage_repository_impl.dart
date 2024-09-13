import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/network/network_info.dart';
import 'package:cv_frontend/features/job_seeker_home/data/data_source/profil_perentage_data_remote_data_source.dart';
import 'package:cv_frontend/features/job_seeker_home/data/models/profil_percentage_model.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/repository/profil_percentage_repository.dart';
import 'package:dartz/dartz.dart';

class ProfilPercentageRepositoryImpl implements ProfilPercentageRepository {
  final NetworkInfo networkInfo;
  final ProfilPercentageRemoteDataSource profilPercentageRemoteDataSource;

  ProfilPercentageRepositoryImpl(
      {required this.networkInfo,
      required this.profilPercentageRemoteDataSource});

  @override
  Future<Either<Failure, CompletionPercentage>> getPercentage() async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final profilPercentage =
          await profilPercentageRemoteDataSource.getPercentage();

      return Right(profilPercentage);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
