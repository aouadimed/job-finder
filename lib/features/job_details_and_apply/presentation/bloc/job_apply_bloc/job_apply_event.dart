part of 'job_apply_bloc.dart';

@immutable
class JobApplyEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitForJobEvent extends JobApplyEvent {
  final bool? userProfile;
  final String? cvUpload;
  final String? motivationLetter;
  final String jobId;

  SubmitForJobEvent({
    this.userProfile = false,
    this.cvUpload,
    this.motivationLetter,
    required this.jobId,
  });

  @override
  List<Object?> get props => [userProfile, cvUpload, motivationLetter, jobId];
}
