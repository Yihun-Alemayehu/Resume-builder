import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_resume/features/resume/Presentation/screens/home_screen.dart';
import 'package:my_resume/features/resume/Presentation/screens/my_resume_screen.dart';
import 'package:my_resume/features/profile/presentation/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  final int currentIndex;
  const MainScreen(this.currentIndex, {super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTab = 0;

  @override
  void initState() {
    super.initState();
    currentTab = widget.currentIndex;
  }

  List<Widget> screens = [
    const HomeScreen(),
    const MyResumeScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentTab],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
        child: BottomNavigationBar(
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          selectedItemColor:
              Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
          unselectedItemColor:
              Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
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
                      width: 25.w,
                      height: 25.h,
                    )
                  : Image.asset('assets/Icons/home-0.png',
                      width: 25.w, height: 25.h),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: currentTab == 1
                  ? Image.asset(
                      'assets/Icons/resume-1.png',
                      width: 25.w,
                      height: 25.h,
                    )
                  : Image.asset('assets/Icons/resume-0.png',
                      width: 25.w, height: 25.h),
              label: 'My Resume',
            ),
            BottomNavigationBarItem(
              icon: currentTab == 2
                  ? Image.asset(
                      'assets/Icons/user-1.png',
                      width: 25.w,
                      height: 25.h,
                    )
                  : Image.asset('assets/Icons/user-0.png',
                      width: 25.w, height: 25.h),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
