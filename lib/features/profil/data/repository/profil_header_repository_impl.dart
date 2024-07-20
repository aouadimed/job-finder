import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/network/network_info.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/profil_header_remote_date_source.dart';
import 'package:cv_frontend/features/profil/data/models/profil_header_model.dart';
import 'package:cv_frontend/features/profil/domain/repository/profil_header_repository.dart';
import 'package:dartz/dartz.dart';

class ProfilHeaderRepositoryImpl implements ProfilHeaderRepository {
  final NetworkInfo networkInfo;
  final ProfilHeaderRemoteDataSource profilHeaderRemoteDataSource;

  ProfilHeaderRepositoryImpl(
      {required this.networkInfo, required this.profilHeaderRemoteDataSource});

  @override
  Future<Either<Failure, ProfilHeaderModel>> getProfilHeader() async {
    if (await networkInfo.isConnected == false) {
      throw ConnexionFailure();
    }
    try {
      final profilHeaderModel =
          await profilHeaderRemoteDataSource.getProfilHeader();
      return right(profilHeaderModel);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
