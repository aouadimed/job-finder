import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/profil/data/models/contact_info_model.dart';
import 'package:cv_frontend/features/profil/domain/repository/contact_info_repository.dart';
import 'package:cv_frontend/features/profil/domain/usecases/summary_use_cases/get_summary_use_cases.dart';
import 'package:dartz/dartz.dart';

class GetContactInfoUseCase implements UseCase<ContactInfoModel, NoParams> {
  final ContactInfoRepository contactInfoRepository;

  const GetContactInfoUseCase({required this.contactInfoRepository});

  @override
  Future<Either<Failure, ContactInfoModel>> call(NoParams params) async {
    return await contactInfoRepository.getContactInfo();
  }
}
