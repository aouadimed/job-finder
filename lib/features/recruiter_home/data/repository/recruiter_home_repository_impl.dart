import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/network/network_info.dart';
import 'package:cv_frontend/features/recruiter_applicants/data/models/applicant_model.dart';
import 'package:cv_frontend/features/recruiter_home/data/data_source/recruiter_home_data_source.dart';
import 'package:cv_frontend/features/recruiter_home/domain/repository/recruiter_home_repository.dart';
import 'package:cv_frontend/features/recruiter_home/domain/usecases/get_recent_applicant_use_case.dart';
import 'package:dartz/dartz.dart';

class RecruiterHomeRepositoryImpl implements RecruiterHomeRepository {
  final NetworkInfo networkInfo;
  final RecruiterHomeDataSource recruiterHomeDataSource;

  RecruiterHomeRepositoryImpl(
      {required this.networkInfo, required this.recruiterHomeDataSource});

  @override
  Future<Either<Failure, ApplicantModel>> getApplicants(
      GetRecentApplicantParams params) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final applciantModel = await recruiterHomeDataSource.getApplciant(params);
      return Right(applciantModel);
    } catch (e) {
      return Left(ConnexionFailure());
    }
  }
}
