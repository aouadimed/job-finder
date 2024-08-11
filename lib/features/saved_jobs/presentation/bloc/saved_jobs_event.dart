part of 'saved_jobs_bloc.dart';

@immutable
abstract class SavedJobsEvent extends Equatable {
  const SavedJobsEvent();

  @override
  List<Object?> get props => [];
}

class GetSavedJobsEvent extends SavedJobsEvent {
  final int page;
  final String? searchQuery;

  const GetSavedJobsEvent({
    this.page = 1,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [page, searchQuery];
}

class RemoveSavedJobsEvent extends SavedJobsEvent {
  final String id;

  const RemoveSavedJobsEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
