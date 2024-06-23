import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/profil/domain/repository/education_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class DeleteEducationUseCase extends UseCase<bool, DeleteEducationParams> {
  final EducationRepository educationRepository;

  DeleteEducationUseCase({required this.educationRepository});

  @override
  Future<Either<Failure, bool>> call(DeleteEducationParams params) {
    return educationRepository.deleteEducation(id: params.id);
  }
}

class DeleteEducationParams extends Equatable {
  final String id;

  const DeleteEducationParams({required this.id});

  @override
  List<Object?> get props => [id];
}
