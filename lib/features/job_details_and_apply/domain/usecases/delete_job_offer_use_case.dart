import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/job_details_and_apply/domain/repository/job_details_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class DeleteJobOfferUseCase implements UseCase<void, DeleteJobOfferParams> {
  final JobDetailsRepository jobDetailsRepository;

  DeleteJobOfferUseCase({required this.jobDetailsRepository});

  @override
  Future<Either<Failure, void>> call(DeleteJobOfferParams params) async {
    return await jobDetailsRepository.deleteJobOffer(params);
  }
}

class DeleteJobOfferParams extends Equatable {
  final String id;

  const DeleteJobOfferParams({required this.id});

  @override
  List<Object?> get props => [id];
}
