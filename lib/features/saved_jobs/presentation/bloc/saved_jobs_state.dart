part of 'saved_jobs_bloc.dart';

@immutable
class SavedJobsState extends Equatable {
  const SavedJobsState();

  @override
  List<Object?> get props => [];
}

class SavedJobsInitial extends SavedJobsState {}

class SavedJobsLoading extends SavedJobsState {}

class SavedJobsFailure extends SavedJobsState {
  final String message;
  final bool isIntentFailure;

  const SavedJobsFailure({
    required this.message,
    required this.isIntentFailure,
  });

  @override
  List<Object?> get props => [message, isIntentFailure];
}

class SavedJobsSuccess extends SavedJobsState {
  final SavedJobsModel savedJobsModel;

  const SavedJobsSuccess({required this.savedJobsModel});
  @override
  List<Object?> get props => [savedJobsModel];
}
