import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/core/services/home_screen_route.dart';
import 'package:cv_frontend/core/services/profil_screen_route.dart';
import 'package:cv_frontend/features/saved_jobs/presentation/bloc/saved_jobs_bloc.dart';
import 'package:cv_frontend/features/saved_jobs/presentation/pages/saved_jobs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cv_frontend/injection_container.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    homeScreenProvider(),
    BlocProvider(
      create: (context) => sl<SavedJobsBloc>(),
      child: const SavedJobScreen(),
    ),
    homeScreenProvider(),
    homeScreenProvider(),
    profilScreenProvider(null),
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
            icon: _getIcon(1, Icons.bookmark, Icons.bookmark_outline),
            label: 'Saved Jobs',
          ),
          BottomNavigationBarItem(
            icon: _getIcon(
                2, Icons.business_center, Icons.business_center_outlined),
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
        selectedLabelStyle:
            const TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
        unselectedLabelStyle: const TextStyle(fontSize: 8),
      ),
    );
  }
}
