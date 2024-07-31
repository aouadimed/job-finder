import 'package:connectivity/connectivity.dart';
import 'package:cv_frontend/features/authentication/data/data_sources/remote_data_source/authentification_remote_data_source.dart';
import 'package:cv_frontend/features/authentication/data/repository/user_repository_impl.dart';
import 'package:cv_frontend/features/authentication/domain/repository/user_repository.dart';
import 'package:cv_frontend/features/authentication/domain/usecases/sign_up_user_use_case.dart';
import 'package:cv_frontend/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:cv_frontend/features/forgot_password/data/repository/forgot_password_repository_impl.dart';
import 'package:cv_frontend/features/forgot_password/domain/repository/forgot_password_repository.dart';
import 'package:cv_frontend/features/forgot_password/domain/usecases/change_password_use_case.dart';
import 'package:cv_frontend/features/forgot_password/domain/usecases/check_email_use_case.dart';
import 'package:cv_frontend/features/forgot_password/domain/usecases/code_verification_use_case.dart';
import 'package:cv_frontend/features/forgot_password/presentation/bloc/forgot_password_bloc.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/contact_info_remote_data_source.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/edcation_remote_data_source.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/language_remote_data_source.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/profil_header_remote_date_source.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/project_remote_data_source.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/skill_remote_data_source.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/summary_remote_data_source.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/work_experience_data_source.dart';
import 'package:cv_frontend/features/profil/data/repository/contact_info_repository_impl.dart';
import 'package:cv_frontend/features/profil/data/repository/education_repository_impl.dart';
import 'package:cv_frontend/features/profil/data/repository/language_repository_impl.dart';
import 'package:cv_frontend/features/profil/data/repository/profil_header_repository_impl.dart';
import 'package:cv_frontend/features/profil/data/repository/project_repository_impl.dart';
import 'package:cv_frontend/features/profil/data/repository/skill_repository_impl.dart';
import 'package:cv_frontend/features/profil/data/repository/summary_repository_impl.dart';
import 'package:cv_frontend/features/profil/data/repository/work_experience_repository_impl.dart';
import 'package:cv_frontend/features/profil/domain/repository/contact_info_repository.dart';
import 'package:cv_frontend/features/profil/domain/repository/education_repository.dart';
import 'package:cv_frontend/features/profil/domain/repository/languages_repository.dart';
import 'package:cv_frontend/features/profil/domain/repository/profil_header_repository.dart';
import 'package:cv_frontend/features/profil/domain/repository/project_repository.dart';
import 'package:cv_frontend/features/profil/domain/repository/skill_repository.dart';
import 'package:cv_frontend/features/profil/domain/repository/summarry_repository.dart';
import 'package:cv_frontend/features/profil/domain/repository/work_experience_repository.dart';
import 'package:cv_frontend/features/profil/domain/usecases/contact_info_use_cases/get_contact_info_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/contact_info_use_cases/update_contact_info_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/education_use_cases/create_education_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/education_use_cases/delete_education_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/education_use_cases/get_all_education_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/education_use_cases/get_single_education_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/education_use_cases/update_education_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/language_use_cases/delete_language_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/language_use_cases/get_all_languages_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/language_use_cases/get_single_language_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/language_use_cases/update_language_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/language_use_cases/create_language_use_case.dart';
import 'package:cv_frontend/features/profil/domain/usecases/profil_header_use_cases/get_profil_header_use_case.dart';
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
import 'package:cv_frontend/features/profil/presentation/bloc/contact_info_bloc/contact_info_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/education_bloc/education_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/languages_bloc/language_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/profil_header_bloc/profil_header_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/project_bloc/project_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/skill_bloc/skill_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/summary_bloc/summary_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/work_experience_bloc/work_experience_bloc.dart';
import 'package:cv_frontend/features/recruiter_applications/data/data_source/company_remote_data_source.dart';
import 'package:cv_frontend/features/recruiter_applications/data/data_source/job_category_remote_data_source.dart';
import 'package:cv_frontend/features/recruiter_applications/data/data_source/job_offer_remote_data_source.dart';
import 'package:cv_frontend/features/recruiter_applications/data/repository/company_repository_impl.dart';
import 'package:cv_frontend/features/recruiter_applications/data/repository/job_category_repository_impl.dart';
import 'package:cv_frontend/features/recruiter_applications/data/repository/job_offer_repository_impl.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/repository/company_repository.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/repository/job_category_repository.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/repository/job_offer_repository.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/usecases/company_use_cases/add_update_company_use_case.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/usecases/company_use_cases/get_company_use_case.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/usecases/job_category_use_cases/get_job_category_use_case.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/usecases/job_offer_use_cases/add_job_offer_use_cases.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/usecases/job_offer_use_cases/get_list_job_offer_use_cases.dart';
import 'package:cv_frontend/features/recruiter_applications/presentation/bloc/company_bloc/company_bloc.dart';
import 'package:cv_frontend/features/recruiter_applications/presentation/bloc/job_category_bloc/job_category_bloc.dart';
import 'package:cv_frontend/features/recruiter_applications/presentation/bloc/job_offer_bloc/job_offer_bloc.dart';
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
  sl.registerFactory(() => ForgotPasswordBloc(
        checkEmailUseCase: sl(),
        codeVerificationUseCase: sl(),
        changePasswordUseCase: sl(),
      ));

// Use Cases
  sl.registerLazySingleton(
      () => CheckEmailUseCase(forgotPasswordRepository: sl()));
  sl.registerLazySingleton(
      () => CodeVerificationUseCase(forgotPasswordRepository: sl()));
  sl.registerLazySingleton(
      () => ChangePasswordUseCase(forgotPasswordRepository: sl()));

// Repositories
  sl.registerLazySingleton<ForgotPasswordRepository>(
    () => ForgotPasswordRepositoryImpl(
      networkInfo: sl(),
      forgotPasswordRemoteDataSource: sl(),
    ),
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
  sl.registerLazySingleton(() => CreateSkillUseCase(skillRepository: sl()));
  sl.registerLazySingleton(() => DeleteSkillUseCase(skillRepository: sl()));
  sl.registerLazySingleton(() => GetSkillsUseCase(skillRepository: sl()));

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

/* ----------------------------------------------------- */
/*
 * profile/ContactInfo
 */
/* ----------------------------------------------------- */
//bloc
  sl.registerFactory(() => ContactInfoBloc(
      getContactInfoUseCase: sl(), updateContactInfoUseCase: sl()));
//use cases
  sl.registerLazySingleton(
      () => GetContactInfoUseCase(contactInfoRepository: sl()));
  sl.registerLazySingleton(
      () => UpdateContactInfoUseCase(contactInfoRepository: sl()));
//repositories
  sl.registerLazySingleton<ContactInfoRepository>(
    () => ContactInfoRepositoryImpl(
      networkInfo: sl(),
      contactInfoRemoteDataSource: sl(),
    ),
  );
// Data Sources
  sl.registerLazySingleton<ContactInfoRemoteDataSource>(
    () => ContactInfoRemoteDataSourceImpl(
      client: sl(),
    ),
  );
/* ----------------------------------------------------- */
/*
 * profile/ContactInfo
 */
/* ----------------------------------------------------- */
//bloc
  sl.registerFactory(() => ProfilHeaderBloc(getProfilHeaderUseCase: sl()));
//use cases

  sl.registerLazySingleton(
      () => GetProfilHeaderUseCase(profilHeaderRepository: sl()));
//repositories
  sl.registerLazySingleton<ProfilHeaderRepository>(
    () => ProfilHeaderRepositoryImpl(
      networkInfo: sl(),
      profilHeaderRemoteDataSource: sl(),
    ),
  );
// Data Sources
  sl.registerLazySingleton<ProfilHeaderRemoteDataSource>(
    () => ProfilHeaderRemoteDataSourceImpl(
      client: sl(),
    ),
  );

/* ----------------------------------------------------- */
/*
 * CompanyData
 */
/* ----------------------------------------------------- */
//bloc
  sl.registerFactory(() => CompanyBloc(
      createOrUpdateCompanyUseCase: sl(), getCompaniesUseCase: sl()));
//use cases
  sl.registerLazySingleton(
      () => CreateOrUpdateCompanyUseCase(companyRepository: sl()));
  sl.registerLazySingleton(() => GetCompaniesUseCase(companyRepository: sl()));
//repositories
  sl.registerLazySingleton<CompanyRepository>(
    () => CompanyRepositoryImpl(
      networkInfo: sl(),
      companyRemoteDataSource: sl(),
    ),
  );
// Data Sources
  sl.registerLazySingleton<CompanyRemoteDataSource>(
    () => CompanyRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  /* ----------------------------------------------------- */
/*
 * CompanyData
 */
/* ----------------------------------------------------- */
//bloc
  sl.registerFactory(
      () => JobOfferBloc(addJobOfferUseCase: sl(), getJobOffersUseCase: sl()));
//use cases
  sl.registerLazySingleton(() => AddJobOfferUseCase(jobOfferRepository: sl()));
  sl.registerLazySingleton(
      () => GetListJobOfferUseCase(jobOfferRepository: sl()));

//repositories
  sl.registerLazySingleton<JobOfferRepository>(
    () => JobOfferRepositoryImpl(
      networkInfo: sl(),
      jobOfferRemoteDataSource: sl(),
    ),
  );
// Data Sources
  sl.registerLazySingleton<JobOfferRemoteDataSource>(
    () => JobOfferRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  /* ----------------------------------------------------- */
/*
 * CompanyData
 */
/* ----------------------------------------------------- */
//bloc
  sl.registerFactory(
      () => JobCategoryBloc(getJobCategoryUseCase: sl()));
//use cases
  sl.registerLazySingleton(() => GetJobCategoryUseCase(jobCategoryRepository: sl()));
//repositories
  sl.registerLazySingleton<JobCategoryRepository>(
    () => JobCategoryRepositoryImpl(
      networkInfo: sl(), jobCategoryRemoteDataSource: sl(),
    ),
  );
// Data Sources
  sl.registerLazySingleton<JobCategoryRemoteDataSource>(
    () => JobCategoryRemoteDataSourceImpl(
      client: sl(),
    ),
  );
}
