import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_resume/core/widget/custom_snackbar.dart';
import 'package:my_resume/features/drawer/presentation/screens/app_drawer.dart';
import 'package:my_resume/core/utils/custom_dialog.dart';
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
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchActive = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<UserProfileBloc>().add(FetchUserProfile());
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearchActive = !_isSearchActive;
      if (!_isSearchActive) {
        _searchController.clear();
        _searchQuery = '';
      }
    });
  }

  void _showConfirmDialog(
      {required int index, required TemplateModel? userData}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogUtils.buildDialog(
          context: context,
          title: 'Select the content to start creating your resume',
          content: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                if (userData == null) {
                  showCustomErrorSnackbar(
                    context,
                    'Please fill in your profile data first',
                    Colors.red,
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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Theme.of(context).textTheme.bodyLarge?.color ??
                        Colors.transparent,
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_3,
                        size: 45.r,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      Text(
                        'Use Profile Data',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Theme.of(context).textTheme.bodyLarge?.color ??
                        Colors.transparent,
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.draw,
                        size: 45.r,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      Text(
                        'Create from scratch',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).dialogTheme.iconColor,
                ),
              ),
            ),
          ],
        );
      },
    );
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
                  GestureDetector(
                    onTap: _toggleSearch,
                    child: Image.asset(
                      _isSearchActive
                          ? 'assets/Icons/close.png'
                          : 'assets/Icons/search.png',
                      height: 24.h,
                      width: 24.w,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            if (_isSearchActive)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Container(
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.transparent,
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10.w),
                      Icon(
                        Icons.search,
                        size: 20.r,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.sp,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Search templates...',
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14.sp,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.color
                                  ?.withOpacity(0.6),
                            ),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.h),
                          ),
                        ),
                      ),
                      if (_searchQuery.isNotEmpty)
                        GestureDetector(
                          onTap: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                            });
                          },
                          child: Icon(
                            Icons.clear,
                            size: 20.r,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                      SizedBox(width: 10.w),
                    ],
                  ),
                ),
              ),
            if (_isSearchActive) SizedBox(height: 10.h),
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
                        // Filter templates based on search query
                        final filteredTemplates = _searchQuery.isEmpty
                            ? templates
                            : templates
                                .asMap()
                                .entries
                                .where((entry) {
                                  final index = entry.key;
                                  final templateName = templatesName[index];
                                  return templateName
                                      .toLowerCase()
                                      .contains(_searchQuery.toLowerCase());
                                })
                                .map((entry) => entry.value)
                                .toList();
                        final filteredTemplatesName = _searchQuery.isEmpty
                            ? templatesName
                            : templatesName
                                .asMap()
                                .entries
                                .where((entry) {
                                  final templateName = entry.value;
                                  return templateName
                                      .toLowerCase()
                                      .contains(_searchQuery.toLowerCase());
                                })
                                .map((entry) => entry.value)
                                .toList();
                        final filteredIndices = _searchQuery.isEmpty
                            ? List.generate(templates.length, (index) => index)
                            : templates
                                .asMap()
                                .entries
                                .where((entry) {
                                  final index = entry.key;
                                  final templateName = templatesName[index];
                                  return templateName
                                      .toLowerCase()
                                      .contains(_searchQuery.toLowerCase());
                                })
                                .map((entry) => entry.key)
                                .toList();

                        if (filteredTemplates.isEmpty) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/Icons/no_profile.png',
                                  width: 140.w, height: 140.h),
                              SizedBox(height: 10.h),
                              Text(
                                'No Template Found',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                'No templates found for your search query.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                            ],
                          );
                        }

                        return Align(
                          alignment: Alignment.topLeft,
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            direction: Axis.horizontal,
                            spacing: 10.w,
                            children: List.generate(
                              filteredTemplates.length,
                              (index) {
                                final originalIndex = filteredIndices[index];
                                final List<UserProfile> userProfileList =
                                    state.user.toList();
                                TemplateModel? userData;
                                if (userProfileList.isNotEmpty) {
                                  userData = TemplateModel.fromUserProfile(
                                      userProfile: state.user[0],
                                      templateName:
                                          filteredTemplatesName[index],
                                      index: originalIndex);
                                }
                                return GestureDetector(
                                  onTap: () => _showConfirmDialog(
                                      index: originalIndex,
                                      userData: userProfileList.isEmpty
                                          ? null
                                          : userData),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .288,
                                    width: MediaQuery.of(context).size.width *
                                        .416,
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          child: Image.asset(
                                            filteredTemplates[index],
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .2697,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .416,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                        Text(
                                          filteredTemplatesName[index],
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
                          ),
                        );
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
