part of 'job_category_bloc.dart';

@immutable
abstract class JobCategoryState extends Equatable {
  const JobCategoryState();

  @override
  List<Object?> get props => [];
}

class JobCategoryInitial extends JobCategoryState {}

class JobCategoryLoading extends JobCategoryState {}

class JobCategoryFailure extends JobCategoryState {
  final bool isIntentFailure;
  final String message;

  const JobCategoryFailure({
    required this.isIntentFailure,
    required this.message,
  });

  @override
  List<Object?> get props => [isIntentFailure, message];
}

class JobCategorySuccess extends JobCategoryState {
  final List<JobCategoryModel> jobCategoryModel;

  const JobCategorySuccess({required this.jobCategoryModel});

  @override
  List<Object?> get props => [jobCategoryModel];
}
