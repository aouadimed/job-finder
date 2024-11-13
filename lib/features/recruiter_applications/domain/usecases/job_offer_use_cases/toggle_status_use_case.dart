import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/repository/job_offer_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ToggleStatusUseCase implements UseCase<void, ToggleStatusPararms> {
  final JobOfferRepository jobOfferRepository;

  ToggleStatusUseCase({required this.jobOfferRepository});

  @override
  Future<Either<Failure, void>> call(ToggleStatusPararms params) async {
    return await jobOfferRepository.toggleStatusUseCase(params);
  }
}

class ToggleStatusPararms extends Equatable {
  final String id;

  const ToggleStatusPararms({required this.id});
  @override
  List<Object?> get props => [id];
}
