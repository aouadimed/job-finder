part of 'recruiter_home_bloc.dart';

@immutable
abstract class RecruiterHomeEvent extends Equatable {
  const RecruiterHomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchRecentApplicantsEvent extends RecruiterHomeEvent {
  final String searchQuery;
  final int? page;

  const FetchRecentApplicantsEvent({required this.searchQuery, this.page});

  @override
  List<Object?> get props => [searchQuery, page];
}
