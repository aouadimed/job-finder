import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/profil/data/models/education_model.dart';
import 'package:cv_frontend/features/profil/domain/repository/education_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetSingleEducationUseCase extends UseCase<EducationModel, GetSingleEducationParams> {
  final EducationRepository educationRepository;

  const GetSingleEducationUseCase({required this.educationRepository});

  @override
  Future<Either<Failure, EducationModel>> call(GetSingleEducationParams params) {
    return educationRepository.getSingleEducation(id: params.id);
  }
}

class GetSingleEducationParams extends Equatable {
  final String id;

  const GetSingleEducationParams({required this.id});

  @override
  List<Object?> get props => [id];
}
