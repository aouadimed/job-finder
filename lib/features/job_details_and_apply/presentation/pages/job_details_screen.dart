import 'package:cv_frontend/core/services/app_routes.dart';
import 'package:cv_frontend/core/services/profil_screen_route.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/pages/widget/apply_job_sheet.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/pages/widget/chip_widget.dart';
import 'package:cv_frontend/features/job_details_and_apply/presentation/pages/widget/job_detail_header.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/big_button.dart';
import 'package:flutter/material.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({super.key});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  List<String> jobDetails = ['Full Time', 'Onsite'];
  List<String> skills = [
    'Creative Thinking',
    'UI/UX Design',
    'Figma',
    'Graphic Design',
    'Web Design',
    'Layout'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(
        rightIcon: Icons.bookmark_border,
        rightIconOnPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              JobCard(
                companyName: 'Google LLC',
                jobTitle: 'UI/UX Designer',
                location: 'California, United States',
                jobDetails: jobDetails,
                postDate: 'Posted 10 days ago, ends in 31 Dec.',
                companyLogoUrl: 'https://logo.clearbit.com/google.com',
              ),
              const SizedBox(height: 16),
              const Divider(height: 32),
              const Text(
                'Job Description:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                '• Able to run design sprint to deliver the best user experience based on research.\n'
                '• Able to lead a team, delegate, & initiative.\n'
                '• Able to mold the junior designer to strategize how certain feature needs to be collected.\n'
                '• Able to aggregate and be data minded on the decision that\'s taking place.',
              ),
              const Divider(height: 32),
              const Text(
                'Minimum Qualifications:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                '• Experience as UI/UX Designer for 2+ years.\n'
                '• Use platform Figma, Sketch, and Miro.\n'
                '• Ability to analyze and convert numerical design sprints into UI/UX.\n'
                '• Have experience in relevant B2C user centric products previously.',
              ),
              const Divider(height: 32),
              const Text(
                'Perks and Benefits:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                '• Medical / Health Insurance\n'
                '• Medical, Prescription, or Vision Plans\n'
                '• Performance Bonus\n'
                '• Paid Sick Leave\n'
                '• Paid Vacation Leave\n'
                '• Transportation Allowances',
              ),
              const Divider(height: 32),
              const Text(
                'Required Skills:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ChipWidget(
                items: skills,
              ),
              const Divider(height: 32),
              const Text(
                'About:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Google LLC is an American multinational technology company that focuses on search engine technology, online advertising, cloud computing, computer software, quantum computing, e-commerce, artificial intelligence, and consumer electronics.\n\n'
                'Google was founded on September 4, 1998, by Larry Page and Sergey Brin while they were Ph.D. students at Stanford University in California.',
              ),
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
  }

  void goToApplyWithCvScreen(BuildContext context) {
    Navigator.pushNamed(
      context,
      applyWithCvScreen,
      arguments: {
        'jobOfferId': 'some-id-cv',
      },
    );
  }
  void goToProfilScreen(BuildContext context) async {
    await Navigator.pushNamed(
      context,
      profilScreen,
      arguments: ProfilScreenArguments(
        isApplyForJob: true,
        id: 'some-id',
      ),
    );
  }
}
