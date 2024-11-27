import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/profil/domain/repository/profil_header_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateProfilHeaderUsecase
    implements UseCase<void, UpdateProfilHeaderParams> {
  final ProfilHeaderRepository profilHeaderRepository;

  UpdateProfilHeaderUsecase({required this.profilHeaderRepository});
  @override
  Future<Either<Failure, void>> call(UpdateProfilHeaderParams params) async {
    return await profilHeaderRepository.updateProject(params);
  }
}

class UpdateProfilHeaderParams extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? profileImg;
  final bool? deletePhoto;

  const UpdateProfilHeaderParams(
      {required this.firstName,
      required this.lastName,
      required this.profileImg,
      required this.deletePhoto});

  @override
  List<Object?> get props => [firstName, lastName, profileImg, deletePhoto];
}
