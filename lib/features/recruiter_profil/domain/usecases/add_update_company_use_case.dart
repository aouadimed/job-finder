import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/recruiter_profil/data/model/company_model.dart';
import 'package:cv_frontend/features/recruiter_profil/domain/repository/company_repository.dart';
import 'package:dartz/dartz.dart';

class CreateOrUpdateCompanyUseCase implements UseCase<void, CompanyProfileModel> {
  final CompanyRepository companyRepository;

  CreateOrUpdateCompanyUseCase({required this.companyRepository});

  @override
  Future<Either<Failure, void>> call(CompanyProfileModel params) async {
    return await companyRepository.addCompany(params);
  }
}


