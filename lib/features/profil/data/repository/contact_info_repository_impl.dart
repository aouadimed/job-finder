import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/network/network_info.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/contact_info_remote_data_source.dart';
import 'package:cv_frontend/features/profil/data/models/contact_info_model.dart';
import 'package:cv_frontend/features/profil/domain/repository/contact_info_repository.dart';
import 'package:cv_frontend/features/profil/domain/usecases/contact_info_use_cases/update_contact_info_use_case.dart';
import 'package:dartz/dartz.dart';

class ContactInfoRepositoryImpl implements ContactInfoRepository {
  final NetworkInfo networkInfo;
  final ContactInfoRemoteDataSource contactInfoRemoteDataSource;

  ContactInfoRepositoryImpl(
      {required this.networkInfo, required this.contactInfoRemoteDataSource});

  @override
  Future<Either<Failure, ContactInfoModel>> getContactInfo() async {
    if (await networkInfo.isConnected == false) {
      throw ConnexionFailure();
    }
    try {
      final contactInfoModel =
          await contactInfoRemoteDataSource.getContactInfo();
      return right(contactInfoModel);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateContactInfo(
      UpdateContactInfoParams params) async {
    if (await networkInfo.isConnected == false) {
      throw ConnexionFailure();
    }
    try {
      await contactInfoRemoteDataSource.updateContactInfo(params);
      return right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
