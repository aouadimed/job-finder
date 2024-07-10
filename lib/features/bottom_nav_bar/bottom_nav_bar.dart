import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/features/home/presentation/pages/home_screen.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/education_bloc/education_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/languages_bloc/language_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/project_bloc/project_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/summary_bloc/summary_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/bloc/work_experience_bloc/work_experience_bloc.dart';
import 'package:cv_frontend/features/profil/presentation/pages/main_profil_screen.dart';
import 'package:cv_frontend/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<SummaryBloc>()..add(GetSummaryEvent()),
        ),
        BlocProvider(
          create: (context) =>
              sl<WorkExperienceBloc>()..add(GetAllWorkExperienceEvent()),
        ),
        BlocProvider(
          create: (context) => sl<EducationBloc>()..add(GetAllEducationEvent()),
        ),
        BlocProvider(
          create: (context) => sl<ProjectBloc>()..add(GetAllProjectsEvent()),
        ),
        BlocProvider(
          create: (context) => sl<LanguageBloc>()..add(GetAllLanguagesEvent()),
        )
      ],
      child: const ProfilScreen(),
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
        items:  [
          BottomNavigationBarItem(
            icon: _getIcon(0, Icons.home , Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _getIcon(1, Icons.bookmark, Icons.bookmark_outline),
            label: 'Saved Jobs',
          ),
          BottomNavigationBarItem(
            icon: _getIcon(2, Icons.business_center, Icons.business_center_outlined),
            label: 'Applications',
          ),
          BottomNavigationBarItem(
            icon: _getIcon(3, Icons.message, Icons.message_outlined),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: _getIcon(4, Icons.person, Icons.person_outline),
            label: 'Profile',
          ),
        ],
        selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
        unselectedLabelStyle: const TextStyle(fontSize: 8),
      ),
    );
  }
}
