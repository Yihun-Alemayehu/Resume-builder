import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_resume/core/Theme/widget/app_drawer.dart';
import 'package:my_resume/features/profile/data/model/user_profile_model.dart';
import 'package:my_resume/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:my_resume/features/resume/Presentation/templates/utils/templates_mapping.dart';
import 'package:my_resume/features/resume/data/model/templates_model.dart';
import 'package:my_resume/features/resume/Presentation/screens/resume_template.dart';
import 'package:my_resume/features/resume/Presentation/widgets/templates_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  void _showConfirmDialog(
      {required int index, required TemplateModel? userData}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 10.0.h),
          insetPadding:
              EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 24.0.h),
          backgroundColor: Colors.white.withValues(alpha: 0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0.r),
          ),
          title: Text(
            'Select the content to start creating your resume',
            style: TextStyle(
              fontSize: 14.sp,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  if (userData == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('No profile data available.'),
                      ),
                    );
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResumeTemplate(
                        templateData: userData,
                        isNewTemplate: true,
                        index: index + 1,
                      ),
                    ),
                  );
                },
                child: Card(
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_3,
                          size: 100.r,
                        ),
                        const Text('Use Profile Data')
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResumeTemplate(
                        templateData: getTemplateData(templateIndex: index),
                        isNewTemplate: true,
                        index: index + 1,
                      ),
                    ),
                  );
                },
                child: Card(
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.draw, size: 100.r),
                        const Text('Create from scratch'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<UserProfileBloc>().add(FetchUserProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Resume Builder'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: const Icon(Icons.menu_open_sharp)),
        
      ),
      drawer: const AppDrawer(),
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserProfileLoaded) {
            return GridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0.h,
                mainAxisSpacing: 8.0.w,
                childAspectRatio: 0.7,
              ),
              itemCount: templates.length,
              itemBuilder: (context, index) {
                final List<UserProfile> userProfileList = state.user.toList();
                TemplateModel? userData;
                if (userProfileList.isNotEmpty) {
                  userData = TemplateModel.fromUserProfile(
                      userProfile: state.user[0],
                      templateName: templatesName[index],
                      index: index);
                }
                return GestureDetector(
                  onTap: () => _showConfirmDialog(
                      index: index,
                      userData: userProfileList.isEmpty ? null : userData),
                  child: Card(
                    elevation: 5.r,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(1.0.r),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0.r),
                        child: Image.asset(
                          templates[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
