part of 'seeker_application_bloc.dart';

@immutable
abstract class SeekerApplicationState extends Equatable {
  const SeekerApplicationState();

  @override
  List<Object?> get props => [];
}

class SeekerApplicationInitial extends SeekerApplicationState {}

class SeekerApplicationLoading extends SeekerApplicationState {}

class SeekerApplicationFailure extends SeekerApplicationState {
  final String message;
  final bool isIntentFailure;

  const SeekerApplicationFailure({
    required this.message,
    required this.isIntentFailure,
  });

  @override
  List<Object?> get props => [message, isIntentFailure];
}

class SeekerApplicationSuccess extends SeekerApplicationState {
  final JobSeekerAppliactionModel jobSeekerApplicationModel;

  const SeekerApplicationSuccess({required this.jobSeekerApplicationModel});

  @override
  List<Object?> get props => [jobSeekerApplicationModel];
}
