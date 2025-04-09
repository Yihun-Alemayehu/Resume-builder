import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_resume/features/profile/presentation/cubit/user_profile_data_cubit.dart';
import 'package:my_resume/features/profile/presentation/widgets/award_tab.dart';
import 'package:my_resume/features/profile/presentation/widgets/certificate_tab.dart';
import 'package:my_resume/features/profile/presentation/widgets/custom_tab.dart';
import 'package:my_resume/features/profile/presentation/widgets/education_background_tab.dart';
import 'package:my_resume/features/profile/presentation/widgets/interest_tab.dart';
import 'package:my_resume/features/profile/presentation/widgets/languages_tab.dart';
import 'package:my_resume/features/profile/presentation/widgets/project_tab.dart';
import 'package:my_resume/features/profile/presentation/widgets/reference_tab.dart';
import 'package:my_resume/features/profile/presentation/widgets/skill_tab.dart';
import 'package:my_resume/features/profile/presentation/widgets/user_data_tab.dart';
import 'package:my_resume/features/profile/presentation/widgets/work_exp_tab.dart';
import 'package:my_resume/features/resume/Presentation/screens/main_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 10, vsync: this);
    context.read<UserProfileDataCubit>().loadUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileDataCubit, UserProfileDataState>(
      listener: (context, state) {
        if (state is UserProfileDataSaved) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile Saved'),
            ),
          );
          // Navigate back to Profile Screen after saving the profile
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MainScreen(2),
              ));
        } else if (state is UserProfileDataError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is UserProfileDataLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserProfileDataLoaded) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    height: 70.h,
                    width: 375.w,
                    decoration: BoxDecoration(
                      color: Theme.of(context).appBarTheme.backgroundColor,
                      // borderRadius: BorderRadius.only(
                      //   bottomLeft: Radius.circular(30.r),
                      //   bottomRight: Radius.circular(30.r),
                      // ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(2),
                            ),
                          ),
                          child: Image.asset(
                            'assets/Icons/profile/arrow_back.png',
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            height: 16.h,
                            width: 16.w,
                          ),
                        ),
                        Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // save user profile data
                            final state = context
                                .read<UserProfileDataCubit>()
                                .state as UserProfileDataLoaded;
                            print(
                                '-------------USER PROFILE FROM EDIT SCREEN --------------------------------');
                            log(state.userProfile.personalProjects.toString());
                            print(
                                '-------------USER PROFILE FROM EDIT SCREEN --------------------------------');
                            context
                                .read<UserProfileDataCubit>()
                                .saveUserProfileData(
                                    userProfile: state.userProfile);
                          },
                          child: Image.asset(
                            'assets/Icons/profile/save.png',
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            height: 24.h,
                            width: 24.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Flexible(
                    child: DefaultTabController(
                      length: 10,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        child: Column(
                          children: [
                            TabBar(
                              isScrollable: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              indicatorWeight: 2.r,
                              indicatorColor:
                                  Theme.of(context).dialogTheme.iconColor,
                              dividerColor: Theme.of(context).dividerColor,
                              indicatorSize: TabBarIndicatorSize.label,
                              tabAlignment: TabAlignment.start,
                              indicatorPadding: EdgeInsets.zero,
                              labelPadding: EdgeInsets.only(right: 10.w),
                              dividerHeight: 2.r,
                              controller: _tabController,
                              tabs: [
                                CustomTab(
                                  text: 'Personal',
                                  iconPath:
                                      'assets/Icons/profile/profile-personal.png',
                                  isSelected: _tabController.index == 0,
                                ),
                                CustomTab(
                                  text: 'Education',
                                  iconPath:
                                      'assets/Icons/profile/profile-education.png',
                                  isSelected: _tabController.index == 1,
                                ),
                                CustomTab(
                                  text: 'Work',
                                  iconPath:
                                      'assets/Icons/profile/profile-work.png',
                                  isSelected: _tabController.index == 2,
                                ),
                                CustomTab(
                                  text: 'Language',
                                  iconPath:
                                      'assets/Icons/profile/profile-language.png',
                                  isSelected: _tabController.index == 3,
                                ),
                                CustomTab(
                                  text: 'Certificate',
                                  iconPath:
                                      'assets/Icons/profile/profile-certificate.png',
                                  isSelected: _tabController.index == 4,
                                ),
                                CustomTab(
                                  text: 'Award',
                                  iconPath:
                                      'assets/Icons/profile/profile-award.png',
                                  isSelected: _tabController.index == 5,
                                ),
                                CustomTab(
                                  text: 'Skill',
                                  iconPath:
                                      'assets/Icons/profile/profile-skill.png',
                                  isSelected: _tabController.index == 6,
                                ),
                                CustomTab(
                                  text: 'Project',
                                  iconPath:
                                      'assets/Icons/profile/profile-project.png',
                                  isSelected: _tabController.index == 7,
                                ),
                                CustomTab(
                                  text: 'Interest',
                                  iconPath:
                                      'assets/Icons/profile/profile-interest.png',
                                  isSelected: _tabController.index == 8,
                                ),
                                CustomTab(
                                  text: 'Reference',
                                  iconPath:
                                      'assets/Icons/profile/profile-reference.png',
                                  isSelected: _tabController.index == 9,
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Expanded(
                              child: TabBarView(
                                controller: _tabController,
                                children: const [
                                  UserDataTab(),
                                  EducationBackgroundTab(),
                                  WorkExpTab(),
                                  LanguagesTab(),
                                  CertificateTab(),
                                  AwardTab(),
                                  SkillTab(),
                                  ProjectTab(),
                                  InterestTab(),
                                  ReferenceTab(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.red,
          ));
        }
      },
    );
  }
}
