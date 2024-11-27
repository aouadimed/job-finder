import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/core/services/app_routes.dart';
import 'package:cv_frontend/core/services/profil_screen_route.dart';
import 'package:cv_frontend/features/job_details_and_apply/data/models/job_offer_details.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/bloc/job_detail_bloc/job_detail_bloc.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/pages/widget/app_bar_icon_skeleton.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/pages/widget/apply_job_sheet.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/pages/widget/chip_widget.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/pages/widget/job_detail_header.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/pages/widget/job_details_skeleton.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/bloc/profil_percentage_bloc/profil_percentage_bloc.dart';
import 'package:cv_frontend/features/job_seeker_home/presentation/bloc/save_job_bloc/save_job_bloc.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/pages/job_offer_edit_screen.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:cv_frontend/global/utils/emploments_type_data.dart';
import 'package:cv_frontend/global/utils/functions.dart';
import 'package:cv_frontend/global/utils/location_type_data.dart';
import 'package:cv_frontend/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class JobDetailsScreen extends StatefulWidget {
  final bool? isRecruiter;
  const JobDetailsScreen({super.key, this.isRecruiter = false});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  JobOfferDetailsModel? jobOfferDetailsModel;
  List<String> jobDetails = [];
  late int completionPercentage;

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
              context.read<SavedJobBloc>().add(
                    CheckSavedJobEvent(id: jobOfferDetailsModel!.id),
                  );
            });
          } else if (state is DeleteJobSuccess) {
            Navigator.pop(context);
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
                    bool isLoading = true;
                    if (savedState is SavedJobCheckSuccess) {
                      isLoading = false;
                      isSaved = savedState.isSaved;
                    } else if (savedState is SavedJobSaveSuccess) {
                      isLoading = false;
                      isSaved = savedState.isSaved;
                    } else if (savedState is SavedJobFailure) {
                      isLoading = false;
                      showSnackBar(
                          context: context, message: savedState.message);
                    }
                    return GeneralAppBar(
                      rightIconColor: primaryColor,
                      actions: widget.isRecruiter == true
                          ? state is! JobDetailLoading
                              ? state is! JobEditLoading
                                  ? [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        BlocProvider(
                                                      create: (context) => sl<
                                                          JobDetailBloc>()
                                                        ..add(GetJobDetailEvent(
                                                            id: jobOfferDetailsModel!
                                                                .id)),
                                                      child: JobOfferEditScreen(
                                                        jobId:
                                                            jobOfferDetailsModel!
                                                                .id,
                                                      ),
                                                    ),
                                                  ),
                                                ).then((value) => {
                                                      BlocProvider.of<
                                                                  JobDetailBloc>(
                                                              context)
                                                          .add(GetJobDetailEvent(
                                                              id: jobOfferDetailsModel!
                                                                  .id))
                                                    });
                                              },
                                              child: Icon(
                                                Icons.edit,
                                                color: primaryColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                QuickAlert.show(
                                                  context: context,
                                                  type: QuickAlertType.confirm,
                                                  confirmBtnColor: primaryColor,
                                                  title: 'Confirm Delete',
                                                  text:
                                                      'Are you sure you want to delete this job offer?',
                                                  confirmBtnText: 'Yes',
                                                  cancelBtnText: 'No',
                                                  onConfirmBtnTap: () {
                                                    BlocProvider.of<
                                                                JobDetailBloc>(
                                                            context)
                                                        .add(
                                                      DeleteJobOfferEvent(
                                                        id: jobOfferDetailsModel!
                                                            .id,
                                                      ),
                                                    );
                                                    Navigator.pop(context);
                                                  },
                                                  onCancelBtnTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                );
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: redColor,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ]
                                  : null
                              : null
                          : null,
                      rightIconWidget: widget.isRecruiter == false
                          ? isLoading
                              ? const GeneralAppBarIconSkeleton()
                              : Icon(
                                  isSaved
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: primaryColor,
                                )
                          : null,
                      rightIconOnPressed: () {
                        if (isSaved) {
                          context.read<SavedJobBloc>().add(RemoveSavedJobEvent(
                              id: jobOfferDetailsModel!.id));
                        } else {
                          context.read<SavedJobBloc>().add(
                              SaveJobOfferEvent(id: jobOfferDetailsModel!.id));
                        }
                      },
                    );
                  },
                ),
              ),
              body: state is JobDetailLoading || state is JobEditLoading
                  ? const Center(child: JobDetailsScreenSkeleton())
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
              bottomNavigationBar: widget.isRecruiter == false
                  ? state is JobDetailLoading
                      ? null
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BlocConsumer<ProfilPercentageBloc,
                              ProfilPercentageState>(
                            listener: (context, state) {
                              if (state is ProfilPercentageFailure) {
                                showSnackBar(
                                    context: context, message: state.message);
                              }
                            },
                            builder: (context, state) {
                              if (state is ProfilPercentageLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (state is ProfilPercentageSuccess) {
                                completionPercentage = state
                                    .completionPercentage.completionPercentage;

                                return BigButton(
                                  color:
                                      jobOfferDetailsModel?.applicationStatus !=
                                              "Not Applied"
                                          ? greyColor
                                          : primaryColor,
                                  onPressed: jobOfferDetailsModel
                                              ?.applicationStatus !=
                                          "Not Applied"
                                      ? null
                                      : () async {
                                          await showModalBottomSheet<
                                              Map<String, int>>(
                                            elevation: 0,
                                            context: context,
                                            builder: (context) => JobApplySheet(
                                              onSelectWithCv: () {
                                                goToApplyWithCvScreen(context);
                                              },
                                              onSelectWithProfil: () {
                                                goToProfilScreen(context);
                                              },
                                              completionPercentage: state
                                                  .completionPercentage
                                                  .completionPercentage,
                                            ),
                                          );
                                        },
                                  text: jobOfferDetailsModel
                                              ?.applicationStatus !=
                                          "Not Applied"
                                      ? jobOfferDetailsModel?.applicationStatus
                                      : 'Apply',
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        )
                  : null,
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
