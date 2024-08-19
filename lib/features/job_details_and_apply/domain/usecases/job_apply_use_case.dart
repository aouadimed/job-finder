import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/usecases/usecase.dart';
import 'package:cv_frontend/features/job_details_and_apply/domain/repository/job_apply_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class JobApplyUseCase implements UseCase<void, JobApplyParams> {
  final JobApplyRepository jobApplyRepository;

  JobApplyUseCase({required this.jobApplyRepository});
  @override
  Future<Either<Failure, void>> call(JobApplyParams params) async {
    return await jobApplyRepository.jobApply(params);
  }
}

class JobApplyParams extends Equatable {
  final bool? userProfile;
  final String? cvUpload;
  final String? motivationLetter;
  final String jobId;

  const JobApplyParams({
    this.userProfile,
    this.cvUpload,
    this.motivationLetter,
    required this.jobId,
  });

  @override
  List<Object?> get props => [userProfile, cvUpload, motivationLetter, jobId];
}
