import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cv_frontend/global/common_widget/loading_widget.dart';

Widget handleLoadingState(BuildContext context, BlocBuilder builder, List<Type> loadingStates) {
  return BlocBuilder(
    builder: (context, state) {
      if (loadingStates.contains(state.runtimeType)) {
        return const LoadingWidget();
      } else {
        return builder;
      }
    },
  );
}
