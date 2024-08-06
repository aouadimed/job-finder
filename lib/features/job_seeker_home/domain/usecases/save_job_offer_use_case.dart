import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/repository/save_job_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SaveJobOfferUseCase implements UseCase<bool, SaveJobOfferParams> {
  final SavedJobRepository savedJobRepository;

  SaveJobOfferUseCase({required this.savedJobRepository});

  @override
  Future<Either<Failure, bool>> call(SaveJobOfferParams params) async {
    return await savedJobRepository.saveJobStatus(id: params.id);
  }
}

class SaveJobOfferParams extends Equatable {
  final String id;

  const SaveJobOfferParams({required this.id});

  @override
  List<Object?> get props => [];
}
