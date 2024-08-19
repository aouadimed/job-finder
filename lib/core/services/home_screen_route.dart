import 'package:cv_frontend/features/job_seeker_home/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/pages/job_seeker_home_screen.dart';
import 'package:cv_frontend/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

MultiBlocProvider homeScreenProvider() {
  return MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => sl<CategoryBloc>()..add(GetCategoryEvent()),
      ),
      BlocProvider(
        create: (context) => sl<HomeBloc>()..add(const GetRecentJobOffer()),
      )
    ],
    child: const HomeScreen(),
  );
}
