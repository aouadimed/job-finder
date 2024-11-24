import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/core/services/home_screen_route.dart';
import 'package:cv_frontend/core/services/profil_screen_route.dart';
import 'package:cv_frontend/features/recruiter_applicants/presentation/bloc/applicant_bloc/applicant_bloc.dart';
import 'package:cv_frontend/features/recruiter_applications/presentation/bloc/job_offer_bloc/job_offer_bloc.dart';
import 'package:cv_frontend/features/recruiter_applications/presentation/pages/applications_screen.dart';
import 'package:cv_frontend/features/messaging/presentation/bloc/messaging_bloc.dart';
import 'package:cv_frontend/features/messaging/presentation/pages/chats_screen.dart';
import 'package:cv_frontend/features/recruiter_home/presentation/bloc/recruiter_home_bloc.dart';
import 'package:cv_frontend/features/recruiter_home/presentation/pages/recruiter_home_screen.dart';
import 'package:cv_frontend/features/recruiter_profil/presentation/bloc/company_bloc/company_bloc.dart';
import 'package:cv_frontend/features/recruiter_profil/presentation/pages/company_profil_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cv_frontend/injection_container.dart';

class RecruiterBottomNavBar extends StatefulWidget {
  const RecruiterBottomNavBar({super.key});

  @override
  State<RecruiterBottomNavBar> createState() => _RecruiterBottomNavBarState();
}

class _RecruiterBottomNavBarState extends State<RecruiterBottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<RecruiterHomeBloc>()
            ..add(const FetchRecentApplicantsEvent(searchQuery: '')),
        ),
        BlocProvider(
          create: (context) => sl<ApplicantBloc>(),
        ),
      ],
      child: const RecruiterHomeScreen(),
    ),
    BlocProvider(
      create: (context) => sl<JobOfferBloc>(),
      child: const ApplicationScreen(),
    ),
    BlocProvider(
      create: (context) => sl<MessagingBloc>(),
      child: const ChatsScreen(),
    ),
    BlocProvider(
      create: (context) => sl<CompanyBloc>()..add(GetCompaniesEvent()),
      child: const CompanyProfilScreen(),
    ),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Icon _getIcon(int index, IconData filledIcon, IconData outlinedIcon) {
    return Icon(_currentIndex == index ? filledIcon : outlinedIcon);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: whiteColor,
        type: BottomNavigationBarType.fixed,
        elevation: 5,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: _getIcon(0, Icons.home, Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _getIcon(
                1, Icons.business_center, Icons.business_center_outlined),
            label: 'Applications',
          ),
          BottomNavigationBarItem(
            icon: _getIcon(2, Icons.message, Icons.message_outlined),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: _getIcon(3, Icons.person, Icons.person_outline),
            label: 'Profile',
          ),
        ],
        selectedLabelStyle:
            const TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
        unselectedLabelStyle: const TextStyle(fontSize: 8),
      ),
    );
  }
}
