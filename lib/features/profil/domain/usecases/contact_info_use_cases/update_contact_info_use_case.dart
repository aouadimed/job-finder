import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/profil/domain/repository/contact_info_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateContactInfoUseCase
    implements UseCase<void, UpdateContactInfoParams> {
  final ContactInfoRepository contactInfoRepository;

  const UpdateContactInfoUseCase({required this.contactInfoRepository});

  @override
  Future<Either<Failure, void>> call(UpdateContactInfoParams params) async {
    return await contactInfoRepository.updateContactInfo(params);
  }
}

class UpdateContactInfoParams extends Equatable {
  final String address;
  final String phone;
  final String email;

  const UpdateContactInfoParams(
      {required this.address, required this.phone, required this.email});

  @override
  List<Object?> get props => [address, phone, email];
}
