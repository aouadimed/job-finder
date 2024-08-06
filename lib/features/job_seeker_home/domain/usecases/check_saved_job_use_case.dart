import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/repository/save_job_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CheckSavedJobUseCase implements UseCase<bool, CheckSavedJobParams> {
  final SavedJobRepository savedJobRepository;

  CheckSavedJobUseCase({required this.savedJobRepository});

  @override
  Future<Either<Failure, bool>> call(CheckSavedJobParams params) async {
    return await savedJobRepository.checkSavedJobStatus(id: params.id);
  }
}

class CheckSavedJobParams extends Equatable {
  final String id;

  const CheckSavedJobParams({required this.id});

  @override
  List<Object?> get props => [id];
}
