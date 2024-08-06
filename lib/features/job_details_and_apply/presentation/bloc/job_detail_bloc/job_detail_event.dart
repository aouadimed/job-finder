part of 'job_detail_bloc.dart';

@immutable
class JobDetailEvent extends Equatable {
  const JobDetailEvent();

  @override
  List<Object?> get props => [];
}

class GetJobDetailEvent extends JobDetailEvent {
  final String id;

  const GetJobDetailEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
