import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_resume/features/profile/presentation/cubit/user_profile_data_cubit.dart';
import 'package:my_resume/features/profile/presentation/widgets/award_tab.dart';
import 'package:my_resume/features/profile/presentation/widgets/certificate_tab.dart';
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

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    super.initState();
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
        }
        if (state is UserProfileDataLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Edit Profile'),
              leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(2),
                      ));
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    // save user profile data
                    final state = context.read<UserProfileDataCubit>().state
                        as UserProfileDataLoaded;
                    print(
                        '-------------USER PROFILE FROM EDIT SCREEN --------------------------------');
                    log(state.userProfile.personalProjects.toString());
                    print(
                        '-------------USER PROFILE FROM EDIT SCREEN --------------------------------');
                    context
                        .read<UserProfileDataCubit>()
                        .saveUserProfileData(userProfile: state.userProfile);
                  },
                  icon: const Icon(Icons.save),
                ),
              ],
            ),
            body: const DefaultTabController(
              length: 10,
              child: SafeArea(
                child: Column(
                  children: [
                    TabBar(
                      isScrollable: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      indicatorWeight: 6,
                      indicatorColor: Colors.blue,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(text: 'Personal'),
                        Tab(text: 'Education'),
                        Tab(text: 'Work'),
                        Tab(text: 'Language'),
                        Tab(text: 'Certificate'),
                        Tab(text: 'Award'),
                        Tab(text: 'Skill'),
                        Tab(text: 'Projects'),
                        Tab(text: 'Interest'),
                        Tab(text: 'Reference'),
                      ],
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      child: TabBarView(
                        children: [
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
