part of 'save_job_bloc.dart';

@immutable
abstract class SavedJobState extends Equatable {
  const SavedJobState();

  @override
  List<Object?> get props => [];
}

class SavedJobInitial extends SavedJobState {}

class SavedJobLoading extends SavedJobState {}

class SavedJobFailure extends SavedJobState {
  final String message;
  final bool isIntentFailure;

  const SavedJobFailure({
    required this.message,
    required this.isIntentFailure,
  });

  @override
  List<Object?> get props => [message, isIntentFailure];
}

class SavedJobCheckSuccess extends SavedJobState {
  final bool isSaved;

  const SavedJobCheckSuccess({required this.isSaved});

  @override
  List<Object?> get props => [isSaved];
}

class SavedJobSaveSuccess extends SavedJobState {
  final bool isSaved;

  const SavedJobSaveSuccess({required this.isSaved});

  @override
  List<Object?> get props => [isSaved];
}
