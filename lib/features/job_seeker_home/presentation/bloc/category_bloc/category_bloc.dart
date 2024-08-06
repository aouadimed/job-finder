import 'package:cv_frontend/core/errors/failures.dart';
import 'package:cv_frontend/core/errors/functions.dart';
import 'package:cv_frontend/features/job_seeker_home/data/models/categorie_selection_model.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/usecases/get_categorys_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_event.dart';
part 'category_state.dart';



class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoryssUsecase getJobCategorysUse;

  CategoryBloc({required this.getJobCategorysUse}) : super(CategoryInitial()) {
    on<GetCategoryEvent>(_onGetCategoryEvent);
  }

  Future<void> _onGetCategoryEvent(
      GetCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());

    final result = await getJobCategorysUse.call(null);

    result.fold(
      (failure) => emit(CategoryFailure(
          message: mapFailureToMessage(failure),
          isIntentFailure: failure is ConnexionFailure)),
      (categories) =>
          emit(JobCategorySuccess(categorySelectionModel: categories)),
    );
  }
}
