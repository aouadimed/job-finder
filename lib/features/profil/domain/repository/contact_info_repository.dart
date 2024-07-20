import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/features/profil/data/models/contact_info_model.dart';
import 'package:cv_frontend/features/profil/domain/usecases/contact_info_use_cases/update_contact_info_use_case.dart';
import 'package:dartz/dartz.dart';

abstract class ContactInfoRepository {
  Future<Either<Failure, ContactInfoModel>> getContactInfo();

  Future<Either<Failure, void>> updateContactInfo(
      UpdateContactInfoParams params);
}
