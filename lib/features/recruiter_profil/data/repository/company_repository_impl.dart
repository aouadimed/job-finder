import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/network/network_info.dart';
import 'package:cv_frontend/features/recruiter_profil/data/data_source/company_remote_data_source.dart';
import 'package:cv_frontend/features/recruiter_profil/data/model/company_model.dart';
import 'package:cv_frontend/features/recruiter_profil/domain/repository/company_repository.dart';
import 'package:dartz/dartz.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final NetworkInfo networkInfo;
  final CompanyRemoteDataSource companyRemoteDataSource;

  CompanyRepositoryImpl(
      {required this.networkInfo, required this.companyRemoteDataSource});

  @override
  Future<Either<Failure, void>> addCompany(CompanyProfileModel params) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      await companyRemoteDataSource.createOrUpdateCompanyProfile(params);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CompanyProfileModel>> getCompany() async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final companyModel = await companyRemoteDataSource.getCompany();
      return Right(companyModel);
    } catch (e) {
      if (e is CompanyDataEmptyException) {
        return Left(CompanyDataEmptyFailure());
      } else {
        return Left(ServerFailure());
      }
    }
  }
}
