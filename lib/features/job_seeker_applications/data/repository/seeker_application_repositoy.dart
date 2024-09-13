import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/network/network_info.dart';
import 'package:cv_frontend/features/job_seeker_applications/data/datasource/seeker_application_remote_data_source.dart';
import 'package:cv_frontend/features/job_seeker_applications/data/models/job_seeker_application_model.dart';
import 'package:cv_frontend/features/job_seeker_applications/domain/repository/seeker_application_repository.dart';
import 'package:cv_frontend/features/job_seeker_applications/domain/usecases/seeker_application_usecase.dart';
import 'package:dartz/dartz.dart';

class SeekerAplicationRepositoryImpl implements SeekerAplicationRepository {
  final NetworkInfo networkInfo;
  final SeekerApplicationRemoteDataSource seekerApplicationRemoteDataSource;

  SeekerAplicationRepositoryImpl(
      {required this.networkInfo,
      required this.seekerApplicationRemoteDataSource});

  @override
  Future<Either<Failure, JobSeekerAppliactionModel>> getApplcaitions(
      GetSeekerApplcaitionsParams params) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final seekerApplicationModel =
          await seekerApplicationRemoteDataSource.getApplication(params);

      return Right(seekerApplicationModel);
    } catch (e) {
      return Left(ConnexionFailure());
    }
  }
}
