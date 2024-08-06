import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/core/services/app_routes.dart';
import 'package:cv_frontend/core/services/profil_screen_route.dart';
import 'package:cv_frontend/features/job_details_and_apply/data/models/job_offer_details.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/bloc/job_detail_bloc/job_detail_bloc.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/pages/widget/apply_job_sheet.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/pages/widget/chip_widget.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/pages/widget/job_detail_header.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/bloc/save_job_bloc/save_job_bloc.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:cv_frontend/global/common_widget/loading_widget.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:cv_frontend/global/utils/emploments_type_data.dart';
import 'package:cv_frontend/global/utils/functions.dart';
import 'package:cv_frontend/global/utils/location_type_data.dart';
import 'package:cv_frontend/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({super.key});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  JobOfferDetailsModel? jobOfferDetailsModel;
  List<String> jobDetails = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SavedJobBloc>(),
      child: BlocListener<JobDetailBloc, JobDetailState>(
        listener: (context, state) {
          if (state is JobDetailFailure) {
            showSnackBar(context: context, message: state.message);
          } else if (state is JobDetailSuccess) {
            setState(() {
              jobOfferDetailsModel = state.jobOfferDetailsModel;
              jobDetails = [
                jobOfferDetailsModel?.employmentTypeIndex != null
                    ? employmentTypes[jobOfferDetailsModel!.employmentTypeIndex]
                    : 'Unknown Employment Type',
                jobOfferDetailsModel?.locationTypeIndex != null
                    ? locationTypes[jobOfferDetailsModel!.locationTypeIndex]
                    : 'Unknown Location Type',
              ];

              // Check if the job is already saved
              context.read<SavedJobBloc>().add(
                    CheckSavedJobEvent(id: jobOfferDetailsModel!.id),
                  );
            });
          }
        },
        child: BlocBuilder<JobDetailBloc, JobDetailState>(
          builder: (context, state) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: BlocBuilder<SavedJobBloc, SavedJobState>(
                  builder: (context, savedState) {
                    bool isSaved = false;
                    if (savedState is SavedJobCheckSuccess) {
                      isSaved = savedState.isSaved;
                    } else if (savedState is SavedJobSaveSuccess) {
                      isSaved = savedState.isSaved;
                    }

                    return GeneralAppBar(
                      rightIconColor: primaryColor,
                      rightIcon:
                          isSaved ? Icons.bookmark : Icons.bookmark_border,
                      rightIconOnPressed: () {
                        if (isSaved) {
                          context.read<SavedJobBloc>().add(
                                RemoveSavedJobEvent(
                                    id: jobOfferDetailsModel!.id),
                              );
                        } else {
                          context.read<SavedJobBloc>().add(
                                SaveJobOfferEvent(id: jobOfferDetailsModel!.id),
                              );
                        }
                      },
                    );
                  },
                ),
              ),
              body: state is JobDetailLoading
                  ? const Center(child: LoadingWidget())
                  : jobOfferDetailsModel == null
                      ? const Center(child: Text('No job details available.'))
                      : SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                JobCard(
                                  companyName:
                                      jobOfferDetailsModel!.companyName,
                                  jobTitle:
                                      jobOfferDetailsModel!.subcategoryName,
                                  location:
                                      jobOfferDetailsModel!.companyCountry,
                                  jobDetails: jobDetails,
                                  postDate:
                                      'Posted ${timeAgo(DateTime.parse(jobOfferDetailsModel!.createdAt))}',
                                  companyLogoUrl:
                                      jobOfferDetailsModel!.logoName,
                                ),
                                const Divider(height: 32),
                                const Text(
                                  'Job Description:',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                ...formatBulletPoints(
                                        jobOfferDetailsModel!.jobDescription)
                                    .map((line) => Text(line)),
                                const Divider(height: 32),
                                const Text(
                                  'Minimum Qualifications:',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                ...formatBulletPoints(jobOfferDetailsModel!
                                        .minimumQualifications)
                                    .map((line) => Text(line)),
                                const Divider(height: 32),
                                const Text(
                                  'Required Skills:',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                ChipWidget(
                                  items: jobOfferDetailsModel!.requiredSkills,
                                ),
                                const Divider(height: 32),
                                const Text(
                                  'About:',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text(jobOfferDetailsModel!.companyAbout),
                              ],
                            ),
                          ),
                        ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BigButton(
                  onPressed: () async {
                    await showModalBottomSheet<Map<String, int>>(
                      elevation: 0,
                      context: context,
                      builder: (context) => JobApplySheet(
                        onSelectWithCv: () {
                          goToApplyWithCvScreen(context);
                        },
                        onSelectWithProfil: () {
                          goToProfilScreen(context);
                        },
                      ),
                    );
                  },
                  text: 'Apply',
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void goToApplyWithCvScreen(BuildContext context) {
    Navigator.pushNamed(
      context,
      applyWithCvScreen,
      arguments: {
        'jobOfferId': jobOfferDetailsModel!.id,
      },
    );
  }

  void goToProfilScreen(BuildContext context) async {
    await Navigator.pushNamed(
      context,
      profilScreen,
      arguments: ProfilScreenArguments(
        isApplyForJob: true,
        id: jobOfferDetailsModel!.id,
      ),
    );
  }
}
