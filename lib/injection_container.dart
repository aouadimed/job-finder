import 'package:connectivity/connectivity.dart';
import 'package:cv_frontend/features/authentication/data/data_sources/remote_data_source/authentification_remote_data_source.dart';
import 'package:cv_frontend/features/authentication/data/repository/user_repository_impl.dart';
import 'package:cv_frontend/features/authentication/domain/repository/user_repository.dart';
import 'package:cv_frontend/features/authentication/domain/usecases/sign_up_user_use_case.dart';
import 'package:cv_frontend/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/summary_remote_data_source.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/work_experience_data_source.dart';
import 'package:cv_frontend/features/profil/data/repository/summary_repository_impl.dart';
import 'package:cv_frontend/features/profil/data/repository/work_experience_impl.dart';
import 'package:cv_frontend/features/profil/domain/repository/summarry_repository.dart';
import 'package:cv_frontend/features/profil/domain/repository/work_experience_repository.dart';
import 'package:cv_frontend/features/profil/domain/usecases/summary_use_cases/create_or_update_sammary_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/summary_use_cases/get_summary_use_cases.dart';
import 'package:cv_frontend/features/profil/domain/usecases/work_experience_use_cases/create_work_experience_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/work_experience_use_cases/delete_work_experince_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/work_experience_use_cases/get_all_work_experience_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/work_experience_use_cases/get_single_work_experiance.dart';
import 'package:cv_frontend/features/profil/domain/usecases/work_experience_use_cases/update_work_experince_use_case.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/summary_bloc/summary_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/work_experience_bloc/work_experience_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';
import 'features/authentication/domain/usecases/login_user_use_case.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //----------------------- External  -----------------------
  sl.registerLazySingleton(() => http.Client());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

/* ----------------------------------------------------- */
/*
 * Authentication
 */
/* ----------------------------------------------------- */
  // BLOC
  sl.registerFactory(
    () => AuthBloc(
      loginUserUseCase: sl(),
      signUpUserUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(
    () => LoginUserUseCase(userRepository: sl()),
  );
  sl.registerLazySingleton(
    () => SignUpUserUseCase(userRepository: sl()),
  );

  // repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      networkInfo: sl(),
      authRemoteDataSource: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      client: sl(),
    ),
  );

/* ----------------------------------------------------- */
/*
 * profile/Summary
 */
/* ----------------------------------------------------- */
//bloc
  sl.registerFactory(
      () => SummaryBloc(summaryUseCase: sl(), getSummaryUseCase: sl()));
//use cases
  sl.registerLazySingleton(
      () => CreateOrUpdateSummaryUseCase(summaryRepository: sl()));
  sl.registerLazySingleton(() => GetSummaryUseCase(summaryRepository: sl()));
//repositories
  sl.registerLazySingleton<SummaryRepository>(
    () => SummaryRepositoryImpl(
      networkInfo: sl(),
      summaryRemoteDataSource: sl(),
    ),
  );
// Data Sources
  sl.registerLazySingleton<SummaryRemoteDataSource>(
    () => SummaryRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  /* ----------------------------------------------------- */
/*
 * profile/WorkExperience
 */
/* ----------------------------------------------------- */
//bloc
  sl.registerFactory(() => WorkExperienceBloc(
        createWorkExperienceUseCase: sl(),
        getAllWorkExperiencesUseCase: sl(),
        getSingleWorkExperienceUseCase: sl(),
        updateWorkExperienceUseCase: sl(),
        deleteWorkExperienceUseCase: sl(),
      ));
//use cases
  sl.registerLazySingleton(
      () => CreateWorkExperienceUseCase(workExperienceRepository: sl()));
  sl.registerLazySingleton(
      () => GetAllWorkExperiencesUseCase(workExperienceRepository: sl()));
  sl.registerLazySingleton(
      () => GetSingleWorkExperienceUseCase(workExperienceRepository: sl()));
  sl.registerLazySingleton(
      () => UpdateWorkExperianceUseCase(workExperienceRepository: sl()));
  sl.registerLazySingleton(
      () => DeleteWorkExperienceUseCase(workExperienceRepository: sl()));
//repositories
  sl.registerLazySingleton<WorkExperienceRepository>(
    () => WorkExperienceRepositoryImpl(
        networkInfo: sl(), workExperienceDataSource: sl()),
  );
// Data Sources
  sl.registerLazySingleton<WorkExperienceDataSource>(
    () => WorkExperienceDataSourceImpl(
      client: sl(),
    ),
  );
}
