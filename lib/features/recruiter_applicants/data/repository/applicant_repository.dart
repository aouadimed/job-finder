import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/network/network_info.dart';
import 'package:cv_frontend/features/recruiter_applicants/data/data_source/applicatnts_remote_data_source.dart';
import 'package:cv_frontend/features/recruiter_applicants/data/models/applicant_model.dart';
import 'package:cv_frontend/features/recruiter_applicants/domain/repository/applicant_repository.dart';
import 'package:cv_frontend/features/recruiter_applicants/domain/usecases/get_applicant_list_use_case.dart';
import 'package:cv_frontend/features/recruiter_applicants/domain/usecases/update_applicant_status_use_case.dart';
import 'package:dartz/dartz.dart';

class ApplicantRepositoryImpl implements ApplicantRepository {
  final NetworkInfo networkInfo;
  final ApplicantRemoteDataSource applicantRemoteDataSource;

  ApplicantRepositoryImpl(
      {required this.networkInfo, required this.applicantRemoteDataSource});

  @override
  Future<Either<Failure, ApplicantModel>> getApplicants(
      GetApplicantsListParams params) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final applicantModel =
          await applicantRemoteDataSource.getApplicants(params);
      return Right(applicantModel);
    } catch (e) {
      return Left(ConnexionFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateStatus(
      UpdateApplicantParams params) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      await applicantRemoteDataSource.updateStatus(params);
      return const Right(null);
    } catch (e) {
      return Left(ConnexionFailure());
    }
  }
}
