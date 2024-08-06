part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class GetRecentJobOffer extends HomeEvent {
  final int page;

  const GetRecentJobOffer({this.page = 1});
  @override
  List<Object?> get props => [page];
}
