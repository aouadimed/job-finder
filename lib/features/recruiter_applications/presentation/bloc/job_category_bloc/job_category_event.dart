part of 'job_category_bloc.dart';

@immutable
abstract class JobCategoryEvent extends Equatable {
  const JobCategoryEvent();

  @override
  List<Object?> get props => [];
}

class GetJobCategoryEvent extends JobCategoryEvent {
  final String? searshQuery;

  const GetJobCategoryEvent({required this.searshQuery});

  @override
  List<Object?> get props => [searshQuery];
}
