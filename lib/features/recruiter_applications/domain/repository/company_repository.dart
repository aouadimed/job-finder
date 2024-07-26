import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/recruiter_applications/data/models/company_model.dart';
import 'package:dartz/dartz.dart';

abstract class CompanyRepository {
  Future<Either<Failure, void>> addCompany(CompanyProfileModel params);
  Future<Either<Failure, CompanyProfileModel>> getCompany();

}
