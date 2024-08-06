part of 'category_bloc.dart';

@immutable
class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryFailure extends CategoryState {
  final bool isIntentFailure;
  final String message;

  const CategoryFailure({
    required this.isIntentFailure,
    required this.message,
  });

  @override
  List<Object?> get props => [isIntentFailure, message];
}

class JobCategorySuccess extends CategoryState {
  final List<CategorySelectionModel> categorySelectionModel;

  const JobCategorySuccess({required this.categorySelectionModel});

  @override
  List<Object?> get props => [categorySelectionModel];
}
