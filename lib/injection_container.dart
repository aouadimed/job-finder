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
import 'package:cv_frontend/features/job_details_and_apply/data/data_source/job_apply_remote_data_source.dart';
import 'package:cv_frontend/features/job_details_and_apply/data/data_source/job_details_remote_data_source.dart';
import 'package:cv_frontend/features/job_details_and_apply/data/repository/job_apply_repository.dart';
import 'package:cv_frontend/features/job_details_and_apply/data/repository/job_offer_detail_repository_impl.dart';
import 'package:cv_frontend/features/job_details_and_apply/domain/repository/job_apply_repository.dart';
import 'package:cv_frontend/features/job_details_and_apply/domain/repository/job_details_repository.dart';
import 'package:cv_frontend/features/job_details_and_apply/domain/usecases/get_job_offer_detail_use_case.dart';
import 'package:cv_frontend/features/job_details_and_apply/domain/usecases/job_apply_use_case.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/bloc/job_apply_bloc/job_apply_bloc.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/bloc/job_detail_bloc/job_detail_bloc.dart';
import 'package:cv_frontend/features/job_seeker_home/data/data_source/category_remote_data_source.dart';
import 'package:cv_frontend/features/job_seeker_home/data/data_source/home_remote_data_source.dart';
import 'package:cv_frontend/features/job_seeker_home/data/data_source/save_job_remote_data_source.dart';
import 'package:cv_frontend/features/job_seeker_home/data/repository/category_repository_impl.dart';
import 'package:cv_frontend/features/job_seeker_home/data/repository/home_repository_impl.dart';
import 'package:cv_frontend/features/job_seeker_home/data/repository/save_job_repository.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/repository/category_repository.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/repository/home_repository.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/repository/save_job_repository.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/usecases/check_saved_job_use_case.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/usecases/get_categorys_use_case.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/usecases/get_recent_jobs_use_case.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/usecases/remove_saved_job_case.dart';
import 'package:cv_frontend/features/job_seeker_home/domain/usecases/save_job_offer_use_case.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/bloc/save_job_bloc/save_job_bloc.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/contact_info_remote_data_source.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/edcation_remote_data_source.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/language_remote_data_source.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/organization_activity_datasource.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/profil_header_remote_date_source.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/project_remote_data_source.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/skill_remote_data_source.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/summary_remote_data_source.dart';
import 'package:cv_frontend/features/profil/data/data_source/remote_data_source/work_experience_data_source.dart';
import 'package:cv_frontend/features/profil/data/repository/contact_info_repository_impl.dart';
import 'package:cv_frontend/features/profil/data/repository/education_repository_impl.dart';
import 'package:cv_frontend/features/profil/data/repository/language_repository_impl.dart';
import 'package:cv_frontend/features/profil/data/repository/organization_activity_repository_impl.dart';
import 'package:cv_frontend/features/profil/data/repository/profil_header_repository_impl.dart';
import 'package:cv_frontend/features/profil/data/repository/project_repository_impl.dart';
import 'package:cv_frontend/features/profil/data/repository/skill_repository_impl.dart';
import 'package:cv_frontend/features/profil/data/repository/summary_repository_impl.dart';
import 'package:cv_frontend/features/profil/data/repository/work_experience_repository_impl.dart';
import 'package:cv_frontend/features/profil/domain/repository/contact_info_repository.dart';
import 'package:cv_frontend/features/profil/domain/repository/education_repository.dart';
import 'package:cv_frontend/features/profil/domain/repository/languages_repository.dart';
import 'package:cv_frontend/features/profil/domain/repository/organization_activity_repository.dart';
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
import 'package:cv_frontend/features/profil/domain/usecases/organization_use_cases/organization_use_cases.dart';
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
import 'package:cv_frontend/features/profil/presentation/bloc/organization_bloc/organization_activity_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/profil_header_bloc/profil_header_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/project_bloc/project_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/skill_bloc/skill_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/summary_bloc/summary_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/work_experience_bloc/work_experience_bloc.dart';
import 'package:cv_frontend/features/recruiter_applicants/data/data_source/applicatnts_remote_data_source.dart';
import 'package:cv_frontend/features/recruiter_applicants/data/repository/applicant_repository.dart';
import 'package:cv_frontend/features/recruiter_applicants/domain/repository/applicant_repository.dart';
import 'package:cv_frontend/features/recruiter_applicants/domain/usecases/get_applicant_list_use_case.dart';
import 'package:cv_frontend/features/recruiter_applicants/presentation/bloc/applicant_bloc/applicant_bloc.dart';
import 'package:cv_frontend/features/recruiter_profil/data/data_source/company_remote_data_source.dart';
import 'package:cv_frontend/features/recruiter_applications/data/data_source/job_category_remote_data_source.dart';
import 'package:cv_frontend/features/recruiter_applications/data/data_source/job_offer_remote_data_source.dart';
import 'package:cv_frontend/features/recruiter_profil/data/repository/company_repository_impl.dart';
import 'package:cv_frontend/features/recruiter_applications/data/repository/job_category_repository_impl.dart';
import 'package:cv_frontend/features/recruiter_applications/data/repository/job_offer_repository_impl.dart';
import 'package:cv_frontend/features/recruiter_profil/domain/repository/company_repository.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/repository/job_category_repository.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/repository/job_offer_repository.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/usecases/job_category_use_cases/get_job_category_use_case.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/usecases/job_offer_use_cases/add_job_offer_use_cases.dart';
import 'package:cv_frontend/features/recruiter_applications/domain/usecases/job_offer_use_cases/get_list_job_offer_use_cases.dart';
import 'package:cv_frontend/features/recruiter_applications/presentation/bloc/job_category_bloc/job_category_bloc.dart';
import 'package:cv_frontend/features/recruiter_applications/presentation/bloc/job_offer_bloc/job_offer_bloc.dart';
import 'package:cv_frontend/features/recruiter_profil/domain/usecases/add_update_company_use_case.dart';
import 'package:cv_frontend/features/recruiter_profil/domain/usecases/get_company_use_case.dart';
import 'package:cv_frontend/features/recruiter_profil/presentation/bloc/company_bloc/company_bloc.dart';
import 'package:cv_frontend/features/saved_jobs/data/data_source/saved_jobs_remote_data_source.dart';
import 'package:cv_frontend/features/saved_jobs/data/reposiory/saved_jobs_repository.dart';
import 'package:cv_frontend/features/saved_jobs/domain/repository/saved_job_repository.dart';
import 'package:cv_frontend/features/saved_jobs/domain/usecases/get_saved_jobs_use_case.dart';
import 'package:cv_frontend/features/saved_jobs/presentation/bloc/saved_jobs_bloc.dart';
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
 * profile/profil header
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
 * job offer
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
 * jobCategorys
 */
/* ----------------------------------------------------- */
//bloc
  sl.registerFactory(() => JobCategoryBloc(getJobCategoryUseCase: sl()));
//use cases
  sl.registerLazySingleton(
      () => GetJobCategoryUseCase(jobCategoryRepository: sl()));
//repositories
  sl.registerLazySingleton<JobCategoryRepository>(
    () => JobCategoryRepositoryImpl(
      networkInfo: sl(),
      jobCategoryRemoteDataSource: sl(),
    ),
  );
// Data Sources
  sl.registerLazySingleton<JobCategoryRemoteDataSource>(
    () => JobCategoryRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  /* ----------------------------------------------------- */
/*
 * Category selction
 */
/* ----------------------------------------------------- */
//bloc
  sl.registerFactory(() => CategoryBloc(getJobCategorysUse: sl()));
//use cases
  sl.registerLazySingleton(
      () => GetCategoryssUsecase(categoryRepository: sl()));
//repositories
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      networkInfo: sl(),
      categoryRemoteDataSource: sl(),
    ),
  );
// Data Sources
  sl.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  /* ----------------------------------------------------- */
/*
 * recent job offer
 */
/* ----------------------------------------------------- */
//bloc
  sl.registerFactory(() => HomeBloc(getRecentJobsUseCases: sl()));
//use cases
  sl.registerLazySingleton(() => GetRecentJobsUseCases(homeRepository: sl()));
//repositories
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      networkInfo: sl(),
      homeRemoteDataSource: sl(),
    ),
  );
// Data Sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  /* ----------------------------------------------------- */
/*
 * job details
 */
/* ----------------------------------------------------- */
//bloc
  sl.registerFactory(() => JobDetailBloc(getJobOfferDetailUseCase: sl()));
//use cases
  sl.registerLazySingleton(
      () => GetJobOfferDetailUseCase(jobDetailsRepository: sl()));
//repositories
  sl.registerLazySingleton<JobDetailsRepository>(
    () => JobDetailsRepositoryImpl(
      networkInfo: sl(),
      jobDetailsRemoteDataSource: sl(),
    ),
  );
// Data Sources
  sl.registerLazySingleton<JobDetailsRemoteDataSource>(
    () => JobDetailsRemoteDataSourceImpl(
      client: sl(),
    ),
  );
/* ----------------------------------------------------- */
/*
 * saved jobs
 */
/* ----------------------------------------------------- */
//bloc
  sl.registerFactory(() => SavedJobBloc(
      checkSavedJobUseCase: sl(),
      saveJobOfferUseCase: sl(),
      removeSavedJobUseCase: sl()));
//use cases
  sl.registerLazySingleton(
      () => CheckSavedJobUseCase(savedJobRepository: sl()));
  sl.registerLazySingleton(() => SaveJobOfferUseCase(savedJobRepository: sl()));
  sl.registerLazySingleton(
      () => RemoveSavedJobUseCase(savedJobRepository: sl()));
//repositories
  sl.registerLazySingleton<SavedJobRepository>(
    () => SavedJobRepositoryImpl(
      networkInfo: sl(),
      savedJobRemoteDataSource: sl(),
    ),
  );
// Data Sources
  sl.registerLazySingleton<SavedJobRemoteDataSource>(
    () => SavedJobRemoteDataSourceImpl(
      client: sl(),
    ),
  );
/* ----------------------------------------------------- */
/*
 * saved jobs screen
 */
/* ----------------------------------------------------- */
//bloc
  sl.registerFactory(() =>
      SavedJobsBloc(getSavedJobsUsecase: sl(), removeSavedJobUseCase: sl()));
//use cases
  sl.registerLazySingleton(
      () => GetSavedJobsUsecase(savedJobsRepository: sl()));
//repositories
  sl.registerLazySingleton<SavedJobsRepository>(
    () => SavedJobsRepositoryImpl(
      networkInfo: sl(),
      savedJobsRemoteDataSource: sl(),
    ),
  );
// Data Sources
  sl.registerLazySingleton<SavedJobsRemoteDataSource>(
    () => SavedJobsRemoteDataSourceImpl(
      client: sl(),
    ),
  );
/* ----------------------------------------------------- */
/*
 * OrganizationActivityBloc
 */
/* ----------------------------------------------------- */
  // Bloc
  sl.registerFactory(() => OrganizationActivityBloc(
        createOrganizationActivityUseCase: sl(),
        getSingleOrganizationActivityUseCase: sl(),
        updateOrganizationActivityUseCase: sl(),
        deleteOrganizationActivityUseCase: sl(),
        getAllOrganizationActivitiesUseCase: sl(),
      ));

// Use Cases
  sl.registerLazySingleton(
      () => CreateOrganizationActivityUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => GetSingleOrganizationActivityUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => UpdateOrganizationActivityUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => DeleteOrganizationActivityUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => GetAllOrganizationActivitiesUseCase(repository: sl()));

// Repositories
  sl.registerLazySingleton<OrganizationActivityRepository>(
    () =>
        OrganizationActivityRepositoryImpl(dataSource: sl(), networkInfo: sl()),
  );

// Data Sources
  sl.registerLazySingleton<OrganizationActivityDataSource>(
    () => OrganizationActivityDataSourceImpl(
      client: sl(),
    ),
  );
  /* ----------------------------------------------------- */
/*
 * Job Apply
 */
/* ----------------------------------------------------- */
  // Bloc
  sl.registerFactory(() => JobApplyBloc(jobApplyUseCase: sl()));

// Use Cases
  sl.registerLazySingleton(() => JobApplyUseCase(jobApplyRepository: sl()));

// Repositories
  sl.registerLazySingleton<JobApplyRepository>(
    () => JobApplyRepositoryImpl(
        networkInfo: sl(), jobApplyRemoteDataSource: sl()),
  );

// Data Sources
  sl.registerLazySingleton<JobApplyRemoteDataSource>(
    () => JobApplyRemoteDataSourceImpl(
      client: sl(),
    ),
  );
/* ----------------------------------------------------- */
/*
 * Applicants
 */
/* ----------------------------------------------------- */
  // Bloc
  sl.registerFactory(() => ApplicantBloc(getApplicantsListUseCase: sl()));

// Use Cases
  sl.registerLazySingleton(
      () => GetApplicantsListUseCase(applicantRepository: sl()));

// Repositories
  sl.registerLazySingleton<ApplicantRepository>(
    () => ApplicantRepositoryImpl(
        networkInfo: sl(), applicantRemoteDataSource: sl()),
  );

// Data Sources
  sl.registerLazySingleton<ApplicantRemoteDataSource>(
    () => ApplicantRemoteDataSourceImpl(
      client: sl(),
    ),
  );
}
