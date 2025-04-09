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
      drawer: const AppDrawer(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              height: 70.h,
              width: 375.w,
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.r),
                  bottomRight: Radius.circular(30.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    child: Image.asset(
                      'assets/Icons/menu.png',
                      height: 26.h,
                      width: 26.w,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  Text(
                    'Resume Builder',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  Image.asset(
                    'assets/Icons/search.png',
                    height: 24.h,
                    width: 24.w,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Flexible(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 5.h),
                  child: BlocBuilder<UserProfileBloc, UserProfileState>(
                    builder: (context, state) {
                      if (state is UserProfileLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is UserProfileLoaded) {
                        return Wrap(
                          alignment: WrapAlignment.start,
                          direction: Axis.horizontal,
                          spacing: 10.w,
                          children: List.generate(
                            templates.length,
                            (index) {
                              final List<UserProfile> userProfileList =
                                  state.user.toList();
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
                                    userData: userProfileList.isEmpty
                                        ? null
                                        : userData),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .288,
                                  width:
                                      MediaQuery.of(context).size.width * .416,
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        child: Image.asset(
                                          templates[index],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(height: 2.h),
                                      Text(
                                        templatesName[index],
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.color,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                        /*return GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          // padding: const EdgeInsets.all(8.0),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 13.0.w,
                            mainAxisSpacing: 13.0.h,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: templates.length,
                          itemBuilder: (context, index) {
                            final List<UserProfile> userProfileList =
                                state.user.toList();
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
                                  userData:
                                      userProfileList.isEmpty ? null : userData),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12.r),
                                    child: Image.asset(
                                      templates[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                    templatesName[index],
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );*/
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
