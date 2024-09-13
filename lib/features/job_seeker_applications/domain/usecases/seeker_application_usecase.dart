import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/job_seeker_applications/data/models/job_seeker_application_model.dart';
import 'package:cv_frontend/features/job_seeker_applications/domain/repository/seeker_application_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetSeekerApplcaitionsUsecase
    implements UseCase<JobSeekerAppliactionModel, GetSeekerApplcaitionsParams> {
  final SeekerAplicationRepository seekerAplicationRepository;

  GetSeekerApplcaitionsUsecase({required this.seekerAplicationRepository});
  @override
  Future<Either<Failure, JobSeekerAppliactionModel>> call(
      GetSeekerApplcaitionsParams params) async {
    return await seekerAplicationRepository.getApplcaitions(params);
  }
}

class GetSeekerApplcaitionsParams extends Equatable {
  final int page;
  final String? searchQuery;

  const GetSeekerApplcaitionsParams(
      {required this.page, required this.searchQuery});

  @override
  List<Object?> get props => [page, searchQuery];
}
