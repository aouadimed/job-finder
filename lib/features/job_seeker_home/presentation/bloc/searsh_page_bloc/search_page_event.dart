part of 'search_page_bloc.dart';

@immutable
abstract class SearchPageEvent extends Equatable {
  const SearchPageEvent();

  @override
  List<Object?> get props => [];
}

class FilterJobOfferEvent extends SearchPageEvent {
  final FilterJobOfferParams params;

  const FilterJobOfferEvent({required this.params});

  @override
  List<Object?> get props => [params];
}
