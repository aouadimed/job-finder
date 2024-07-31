import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/recruiter_applications/data/models/company_model.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/repository/company_repository.dart';
import 'package:dartz/dartz.dart';

class GetCompaniesUseCase implements UseCase<CompanyProfileModel, void> {
  final CompanyRepository companyRepository;

  GetCompaniesUseCase({required this.companyRepository});

  @override
  Future<Either<Failure, CompanyProfileModel>> call(void params) async {
    return await companyRepository.getCompany();
  }
}
