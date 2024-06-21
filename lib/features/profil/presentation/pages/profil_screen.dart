import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/core/services/app_routes.dart';
import 'package:cv_frontend/features/profil/data/models/work_experience_model.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/summary_bloc/summary_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/work_experience_bloc/work_experience_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/profil_expanded_cards/contact_inforamtion_card.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/profil_expanded_cards/summary_card.dart';
import 'package:cv_frontend/features/profil/presentation/pages/widgets/profil_expanded_cards/work_experience_card.dart';
import 'package:cv_frontend/features/profil/presentation/pages/work_experience_screen.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  String summaryDescription = '';
  List<WorkExperiencesModel> experiences = [];
  // Navigation
  void goToSummaryScreen(BuildContext context) async {
    await Navigator.pushNamed(context, summaryScreen).then(
      (_) {
        if (context.mounted) {
          BlocProvider.of<SummaryBloc>(context).add(GetSummaryEvent());
        }
      },
    );
  }

  void goToWorkExperienceScreen(
      BuildContext context, bool isUpdate, String id) async {
    await Navigator.pushNamed(context, workExperienceScreen,
            arguments: WorkExperienceScreenArguments(isUpdate: isUpdate, id))
        .then(
      (_) {
        if (context.mounted) {
          BlocProvider.of<WorkExperienceBloc>(context)
              .add(GetAllWorkExperienceEvent());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SummaryBloc, SummaryState>(listener: (context, state) {
          if (state is GetSummarySuccess) {
            setState(() {
              summaryDescription = state.summaryModel.description ?? '';
            });
          }
        }),
        BlocListener<WorkExperienceBloc, WorkExperienceState>(
            listener: (context, state) {
          if (state is GetAllWorkExperienceSuccess) {
            setState(() {
              experiences = state.workExperiencesModel;
            });
          }
        })
      ],
      child: Scaffold(
        appBar: const GeneralAppBar(
          titleText: "Profile",
          logo: AssetImage(
            'assets/images/logo.webp',
          ),
          rightIcon: Icons.settings_outlined,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                            'http://192.168.1.13:5000/userimg/1717428491056-446084121.jpg'),
                      ),
                      const SizedBox(width: 16),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mohamed Aouadi',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'UI/UX Designer at Paypal Inc.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Icon(Icons.edit, color: primaryColor),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    thickness: 0.5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Summary(
                        iconOnPressed: () {
                          goToSummaryScreen(context);
                        },
                        summaryDescription: summaryDescription,
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<SummaryBloc, SummaryState>(
                        builder: (context, state) {
                          if (state is SummaryLoading) {
                            return Center(
                              child: CircularProgressIndicator(
                                  color: primaryColor),
                            );
                          } else {
                            return Summary(
                              iconOnPressed: () {
                                goToSummaryScreen(context);
                              },
                              summaryDescription: summaryDescription,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<WorkExperienceBloc, WorkExperienceState>(
                        builder: (context, state) {
                          if (state is WorkExperienceLoading) {
                            return Center(
                              child: CircularProgressIndicator(
                                  color: primaryColor),
                            );
                          } else {
                            return WorkExperience(
                              iconOnPressed: () {
                                goToWorkExperienceScreen(context, false, "");
                              },
                              experiences: experiences,
                              editIconOnPressed: (String value) {
                                goToWorkExperienceScreen(context, true, value);
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
