part of 'job_apply_bloc.dart';

@immutable
abstract class JobApplyState extends Equatable {
  const JobApplyState();

  @override
  List<Object?> get props => [];
}

class JobApplyInitial extends JobApplyState {}

class JobApplyLoading extends JobApplyState {}

class JobApplyFailure extends JobApplyState {
  final String message;
  final bool isIntentFailure;
  const JobApplyFailure({
    required this.message,
    required this.isIntentFailure,
  });

  @override
  List<Object?> get props => [message];
}

class JobApplySuccess extends JobApplyState {}
