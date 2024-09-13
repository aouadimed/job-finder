part of 'seeker_application_bloc.dart';

@immutable
abstract class SeekerApplicationsEvent extends Equatable {
  const SeekerApplicationsEvent();

  @override
  List<Object?> get props => [];
}

class GetSeekerApplicationsEvent extends SeekerApplicationsEvent {
  final int page;
  final String? searchQuery;

  const GetSeekerApplicationsEvent({
    this.page = 1,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [page, searchQuery];
}