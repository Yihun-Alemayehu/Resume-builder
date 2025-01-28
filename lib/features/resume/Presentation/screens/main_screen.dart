import 'package:flutter/material.dart';
import 'package:my_resume/features/resume/Presentation/screens/home_screen.dart';
import 'package:my_resume/features/resume/Presentation/screens/my_resume_screen.dart';
import 'package:my_resume/features/profile/presentation/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTab = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const MyResumeScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        onTap: (index) {
          setState(() {
            currentTab = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: currentTab == 0
                ? Image.asset(
                    'assets/Icons/home-1.png',
                    width: 25,
                    height: 25,
                  )
                : Image.asset('assets/Icons/home-0.png', width: 25, height: 25),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: currentTab == 1
                ? Image.asset(
                    'assets/Icons/resume-1.png',
                    width: 25,
                    height: 25,
                  )
                : Image.asset('assets/Icons/resume-0.png',
                    width: 25, height: 25),
            label: 'My Resume',
          ),
          BottomNavigationBarItem(
            icon: currentTab == 2
                ? Image.asset(
                    'assets/Icons/user-1.png',
                    width: 25,
                    height: 25,
                  )
                : Image.asset('assets/Icons/user-0.png', width: 25, height: 25),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
