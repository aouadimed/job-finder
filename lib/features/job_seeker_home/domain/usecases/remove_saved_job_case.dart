import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/repository/save_job_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RemoveSavedJobUseCase implements UseCase<bool, RemoveSavedJobParams> {
  final SavedJobRepository savedJobRepository;

  RemoveSavedJobUseCase({required this.savedJobRepository});

  @override
  Future<Either<Failure, bool>> call(RemoveSavedJobParams params) async {
    return await savedJobRepository.deleteJobStatus(id: params.id);
  }
}

class RemoveSavedJobParams extends Equatable {
  final String id;

  const RemoveSavedJobParams({required this.id});

  @override
  List<Object?> get props => [id];
}
