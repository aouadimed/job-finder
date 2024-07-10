import 'package:connectivity/connectivity.dart';
import 'package:cv_frontend/features/authentication/data/data_sources/remote_data_source/authentification_remote_data_source.dart';
import 'package:cv_frontend/features/authentication/data/repository/user_repository_impl.dart';
import 'package:cv_frontend/features/authentication/domain/repository/user_repository.dart';
import 'package:cv_frontend/features/authentication/domain/usecases/sign_up_user_use_case.dart';
import 'package:cv_frontend/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:cv_frontend/features/forgot_password/data/repository/forgot_password_repository_impl.dart';
import 'package:cv_frontend/features/forgot_password/domain/repository/forgot_password_repository.dart';
import 'package:cv_frontend/features/forgot_password/domain/usecases/check_email_use_case.dart';
import 'package:cv_frontend/features/forgot_password/presentation/bloc/forgot_password_bloc.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/edcation_remote_data_source.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/language_remote_data_source.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/project_remote_data_source.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/skill_remote_data_source.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/summary_remote_data_source.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/work_experience_data_source.dart';
import 'package:cv_frontend/features/profil/data/repository/education_repository_impl.dart';
import 'package:cv_frontend/features/profil/data/repository/language_repository_impl.dart';
import 'package:cv_frontend/features/profil/data/repository/project_repository_impl.dart';
import 'package:cv_frontend/features/profil/data/repository/skill_repository_impl.dart';
import 'package:cv_frontend/features/profil/data/repository/summary_repository_impl.dart';
import 'package:cv_frontend/features/profil/data/repository/work_experience_repository_impl.dart';
import 'package:cv_frontend/features/profil/domain/repository/education_repository.dart';
import 'package:cv_frontend/features/profil/domain/repository/languages_repository.dart';
import 'package:cv_frontend/features/profil/domain/repository/project_repository.dart';
import 'package:cv_frontend/features/profil/domain/repository/skill_repository.dart';
import 'package:cv_frontend/features/profil/domain/repository/summarry_repository.dart';
import 'package:cv_frontend/features/profil/domain/repository/work_experience_repository.dart';
import 'package:cv_frontend/features/profil/domain/usecases/education_use_cases/create_education_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/education_use_cases/delete_education_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/education_use_cases/get_all_education_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/education_use_cases/get_single_education_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/education_use_cases/update_education_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/language_use_cases/DeleteLanguageUseCase.dart';
import 'package:cv_frontend/features/profil/domain/usecases/language_use_cases/GetAllLanguagesUseCase.dart';
import 'package:cv_frontend/features/profil/domain/usecases/language_use_cases/GetSingleLanguageUseCase.dart';
import 'package:cv_frontend/features/profil/domain/usecases/language_use_cases/UpdateLanguageUseCase.dart';
import 'package:cv_frontend/features/profil/domain/usecases/language_use_cases/create_language_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/project_use_cases/create_project_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/project_use_cases/delete_project_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/project_use_cases/get_all_project_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/project_use_cases/get_single_project_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/project_use_cases/update_project_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/skill_use_cases/create_skill_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/skill_use_cases/delete_skill_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/skill_use_cases/get_skill_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/summary_use_cases/create_or_update_sammary_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/summary_use_cases/get_summary_use_cases.dart';
import 'package:cv_frontend/features/profil/domain/usecases/work_experience_use_cases/create_work_experience_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/work_experience_use_cases/delete_work_experince_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/work_experience_use_cases/get_all_work_experience_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/work_experience_use_cases/get_single_work_experiance.dart';
import 'package:cv_frontend/features/profil/domain/usecases/work_experience_use_cases/update_work_experince_use_case.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/education_bloc/education_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/languages_bloc/language_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/project_bloc/project_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/skill_bloc/skill_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/summary_bloc/summary_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/work_experience_bloc/work_experience_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';
import 'features/authentication/domain/usecases/login_user_use_case.dart';
import 'features/forgot_password/data/data_source/forgot_password_remote_data_source.dart';

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
 * forgotPassword
 */
/* ----------------------------------------------------- */
  // Bloc
  sl.registerFactory(() => ForgotPasswordBloc(checkEmailUseCase:  sl(),      
    ));

// Use Cases
  sl.registerLazySingleton(
      () => CheckEmailUseCase(forgotPasswordRepository:  sl()));



// Repositories
  sl.registerLazySingleton<ForgotPasswordRepository>(
    () => ForgotPasswordRepositoryImpl(networkInfo: sl(), forgotPasswordRemoteDataSource:  sl(),),
  );

// Data Sources
  sl.registerLazySingleton<ForgotPasswordRemoteDataSource>(
    () => ForgotPasswordRemoteDataSourceImpl(
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

  /* ----------------------------------------------------- */
/*
 * profile/education
 */
/* ----------------------------------------------------- */
//bloc
  sl.registerFactory(() => EducationBloc(
        createEducationUseCase: sl(),
        getAllEducationsUseCase: sl(),
        getSingleEducationUseCase: sl(),
        updateEducationUseCase: sl(),
        deleteEducationUseCase: sl(),
      ));
//use cases
  sl.registerLazySingleton(
      () => CreateEducationUseCase(educationRepository: sl()));
  sl.registerLazySingleton(
      () => GetAllEducationsUseCase(educationRepository: sl()));
  sl.registerLazySingleton(
      () => GetSingleEducationUseCase(educationRepository: sl()));
  sl.registerLazySingleton(
      () => UpdateEducationUseCase(educationRepository: sl()));
  sl.registerLazySingleton(
      () => DeleteEducationUseCase(educationRepository: sl()));
//repositories
  sl.registerLazySingleton<EducationRepository>(
    () => EducationRepositoryImpl(networkInfo: sl(), educationDataSource: sl()),
  );
// Data Sources
  sl.registerLazySingleton<EducationDataSource>(
    () => EducationDataSourceImpl(
      client: sl(),
    ),
  );
/* ----------------------------------------------------- */
/*
 * profile/project
 */
/* ----------------------------------------------------- */
  // Bloc
  sl.registerFactory(() => ProjectBloc(
        createProjectUseCase: sl(),
        getAllProjectsUseCase: sl(),
        getSingleProjectUseCase: sl(),
        updateProjectUseCase: sl(),
        deleteProjectUseCase: sl(),
      ));

// Use Cases
  sl.registerLazySingleton(() => CreateProjectUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAllProjectsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetSingleProjectUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateProjectUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteProjectUseCase(repository: sl()));

// Repositories
  sl.registerLazySingleton<ProjectRepository>(
    () => ProjectRepositoryImpl(dataSource: sl(), networkInfo: sl()),
  );

// Data Sources
  sl.registerLazySingleton<ProjectDataSource>(
    () => ProjectDataSourceImpl(
      client: sl(),
    ),
  );
/* ----------------------------------------------------- */
/*
 * profile/language
 */
/* ----------------------------------------------------- */
  // Bloc
  sl.registerFactory(() => LanguageBloc(
        createLanguageUseCase: sl(),
        getAllLanguagesUseCase: sl(),
        getSingleLanguageUseCase: sl(),
        updateLanguageUseCase: sl(),
        deleteLanguageUseCase: sl(),
      ));

// Use Cases
  sl.registerLazySingleton(
      () => CreateLanguageUseCase(languageRepository: sl()));
  sl.registerLazySingleton(
      () => GetAllLanguagesUseCase(languageRepository: sl()));
  sl.registerLazySingleton(
      () => GetSingleLanguageUseCase(languageRepository: sl()));
  sl.registerLazySingleton(
      () => UpdateLanguageUseCase(languageRepository: sl()));
  sl.registerLazySingleton(
      () => DeleteLanguageUseCase(languageRepository: sl()));

// Repositories
  sl.registerLazySingleton<LanguageRepository>(
    () => LanguageRepositoryImpl(languageDataSource: sl(), networkInfo: sl()),
  );

// Data Sources
  sl.registerLazySingleton<LanguageDataSource>(
    () => LanguageDataSourceImpl(
      client: sl(),
    ),
  );

/* ----------------------------------------------------- */
/*
 * profile/skill
 */
/* ----------------------------------------------------- */
  // Bloc
  sl.registerFactory(() => SkillBloc(
      createSkillUseCase: sl(),
      deleteSkillUseCase: sl(),
      getSkillsUseCase: sl()));

// Use Cases
  sl.registerLazySingleton(
      () => CreateSkillUseCase(skillRepository: sl()));
  sl.registerLazySingleton(
      () => DeleteSkillUseCase(skillRepository: sl()));
  sl.registerLazySingleton(
      () => GetSkillsUseCase(skillRepository: sl()));


// Repositories
  sl.registerLazySingleton<SkillRepository>(
    () => SkillRepositoryImpl(networkInfo: sl(), skillRemoteDataSource: sl()),
  );

// Data Sources
  sl.registerLazySingleton<SkillRemoteDataSource>(
    () => SkillRemoteDataSourceImpl(
      client: sl(),
    ),
  );
}
