part of 'save_job_bloc.dart';

@immutable
abstract class SavedJobEvent extends Equatable {
  const SavedJobEvent();

  @override
  List<Object?> get props => [];
}

class CheckSavedJobEvent extends SavedJobEvent {
  final String id;

  const CheckSavedJobEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class SaveJobOfferEvent extends SavedJobEvent {
  final String id;

  const SaveJobOfferEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class RemoveSavedJobEvent extends SavedJobEvent {
  final String id;

  const RemoveSavedJobEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
