import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_resume/core/utils/app_theme.dart';
import 'package:my_resume/core/widget/custom_snackbar.dart';
import 'package:my_resume/features/drawer/presentation/screens/settings_screen.dart';
import 'package:my_resume/features/profile/data/model/user_profile_model.dart';
import 'package:my_resume/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:my_resume/features/profile/presentation/screens/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserProfileBloc>().add(FetchUserProfile());
  }

  bool isExpanded1 = false;
  bool isExpanded2 = false;
  bool isExpanded3 = false;
  bool isExpanded4 = false;
  bool isExpanded5 = false;
  bool isExpanded6 = false;
  bool isExpanded7 = false;
  bool isExpanded8 = false;
  bool isExpanded9 = false;
  bool isExpanded10 = false;

  bool canEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsScreen(),
                          ),
                        );
                      },
                      icon: Icon(Icons.settings,
                          size: 24.sp,
                          color: Theme.of(context).textTheme.bodyLarge?.color)),
                  SizedBox(width: 10.w),
                  canEdit
                      ? GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditProfileScreen(),
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/Icons/profile/profile-edit.png',
                            height: 24.h,
                            width: 24.w,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Flexible(
              child: BlocConsumer<UserProfileBloc, UserProfileState>(
                listener: (context, state) {
                  if (state is UserProfileError) {
                    showCustomErrorSnackbar(
                      context,
                      state.errorMessage,
                      Colors.red,
                    );
                  } else if (state is UserProfileDeleted) {
                    showCustomErrorSnackbar(
                      context,
                      'Profile Deleted Successfully',
                      AppColors.accent,
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfileScreen(),
                      ),
                    );
                  } else if (state is UserProfileUpdated) {
                    showCustomErrorSnackbar(
                      context,
                      'Profile Updated Successfully',
                      AppColors.accent,
                    );
                  } else if (state is UserProfileLoaded) {
                    if (state.user.isNotEmpty) {
                      setState(() {
                        canEdit = true;
                      });
                    } else {
                      setState(() {
                        canEdit = false;
                      });
                    }
                  }
                },
                builder: (context, state) {
                  if (state is UserProfileLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is UserProfileLoaded ||
                      state is UserProfileUpdated ||
                      state is UserProfileSaved) {
                    UserProfile userProfile;
                    if ((state as UserProfileLoaded).user.isNotEmpty) {
                      userProfile = state.user[0];
                      print(
                          '-------------USER PROFILE FROM PROFILE SCREEN --------------------------------');
                      log(userProfile.toString());
                      print(
                          '-------------USER PROFILE FROM PROFILE SCREEN --------------------------------');
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50.r,
                              backgroundImage:
                                  FileImage(userProfile.userdata.profilePic),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              userProfile.userdata.fullName,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.color,
                              ),
                            ),
                            Text(
                              userProfile.userdata.profession,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.w, vertical: 25.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                spacing: 0,
                                children: [
                                  ProfileExpansionTile(
                                    title: 'Personal Information',
                                    icon:
                                        'assets/Icons/profile/profile-personal.png',
                                    childrens: List.generate(
                                      7,
                                      (index) {
                                        final Map<String, dynamic>
                                            personalInfoMap = {
                                          'About': userProfile.userdata.bio,
                                          'Email': userProfile.userdata.email,
                                          'Phone':
                                              userProfile.userdata.phoneNumber,
                                          'Address':
                                              userProfile.userdata.address,
                                          'LinkedIn':
                                              userProfile.userdata.linkedIn,
                                          'GitHub': userProfile.userdata.github,
                                          'Website':
                                              userProfile.userdata.website,
                                        };
                                        return CustomTile(
                                          title: personalInfoMap.keys
                                              .elementAt(index),
                                          subtitle: personalInfoMap.values
                                              .elementAt(index),
                                        );
                                      },
                                    ),
                                    isExpanded: isExpanded1,
                                    onExpansionChanged: (value) {
                                      setState(() {
                                        isExpanded1 = value;
                                      });
                                    },
                                  ),
                                  ProfileExpansionTile(
                                    title: 'Educational Background',
                                    icon:
                                        'assets/Icons/profile/profile-education.png',
                                    childrens: List.generate(
                                      userProfile.education.length,
                                      (index) {
                                        return CustomTile(
                                          title: userProfile
                                              .education[index].fieldOfStudy,
                                          subtitle: userProfile
                                              .education[index].institutionName,
                                          date:
                                              '${userProfile.education[index].startDate} - ${userProfile.education[index].endDate}',
                                        );
                                      },
                                    ),
                                    isExpanded: isExpanded2,
                                    onExpansionChanged: (value) {
                                      setState(() {
                                        isExpanded2 = value;
                                      });
                                    },
                                  ),
                                  ProfileExpansionTile(
                                    title: 'Work Experience',
                                    icon:
                                        'assets/Icons/profile/profile-work.png',
                                    childrens: List.generate(
                                      userProfile.workExperience.length,
                                      (index) {
                                        return CustomTile(
                                          title: userProfile
                                              .workExperience[index].jobTitle,
                                          subtitle: userProfile
                                              .workExperience[index]
                                              .companyName,
                                          date:
                                              '${userProfile.workExperience[index].startDate} - ${userProfile.workExperience[index].endDate}',
                                        );
                                      },
                                    ),
                                    isExpanded: isExpanded3,
                                    onExpansionChanged: (value) {
                                      setState(() {
                                        isExpanded3 = value;
                                      });
                                    },
                                  ),
                                  ProfileExpansionTile(
                                    title: 'Languages',
                                    icon:
                                        'assets/Icons/profile/profile-language.png',
                                    childrens: List.generate(
                                      userProfile.languages.length,
                                      (index) {
                                        return CustomTile(
                                          title: userProfile
                                              .languages[index].language,
                                          subtitle: userProfile
                                              .languages[index].proficiency,
                                        );
                                      },
                                    ),
                                    isExpanded: isExpanded4,
                                    onExpansionChanged: (value) {
                                      setState(() {
                                        isExpanded4 = value;
                                      });
                                    },
                                  ),
                                  ProfileExpansionTile(
                                    title: 'Certificates',
                                    icon:
                                        'assets/Icons/profile/profile-certificate.png',
                                    childrens: List.generate(
                                      userProfile.certificates.length,
                                      (index) {
                                        return CustomTile(
                                          title: userProfile.certificates[index]
                                              .certificateName,
                                          subtitle: 'GDG AASTU',
                                          date: userProfile
                                              .certificates[index].issuedDate,
                                          useRowLayout: true,
                                        );
                                      },
                                    ),
                                    isExpanded: isExpanded5,
                                    onExpansionChanged: (value) {
                                      setState(() {
                                        isExpanded5 = value;
                                      });
                                    },
                                  ),
                                  ProfileExpansionTile(
                                    title: 'Awards',
                                    icon:
                                        'assets/Icons/profile/profile-award.png',
                                    childrens: List.generate(
                                      userProfile.awards.length,
                                      (index) {
                                        return CustomTile(
                                          title: userProfile
                                              .awards[index].awardName,
                                          subtitle: 'GDG AASTU',
                                          date: userProfile
                                              .awards[index].issuedDate,
                                          useRowLayout: true,
                                        );
                                      },
                                    ),
                                    isExpanded: isExpanded6,
                                    onExpansionChanged: (value) {
                                      setState(() {
                                        isExpanded6 = value;
                                      });
                                    },
                                  ),
                                  ProfileExpansionTile(
                                    title: 'Projects',
                                    icon:
                                        'assets/Icons/profile/profile-project.png',
                                    childrens: List.generate(
                                      userProfile.personalProjects.length,
                                      (index) {
                                        return CustomTile(
                                          title: userProfile
                                              .personalProjects[index].name,
                                          subtitle: userProfile
                                              .personalProjects[index]
                                              .description,
                                        );
                                      },
                                    ),
                                    isExpanded: isExpanded8,
                                    onExpansionChanged: (value) {
                                      setState(() {
                                        isExpanded8 = value;
                                      });
                                    },
                                  ),
                                  ProfileExpansionTile(
                                    title: 'References',
                                    icon:
                                        'assets/Icons/profile/profile-reference.png',
                                    childrens: List.generate(
                                      userProfile.references.length,
                                      (index) {
                                        return CustomTile(
                                          title: userProfile
                                              .references[index].name,
                                          subtitle: userProfile
                                              .references[index].referenceText,
                                        );
                                      },
                                    ),
                                    isExpanded: isExpanded10,
                                    onExpansionChanged: (value) {
                                      setState(() {
                                        isExpanded10 = value;
                                      });
                                    },
                                  ),
                                  ProfileExpansionTile(
                                    title: 'Skills',
                                    icon:
                                        'assets/Icons/profile/profile-skill.png',
                                    childrens: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 40.w),
                                        child: Wrap(
                                          spacing: 11.r,
                                          children: List.generate(
                                            userProfile.skills.length,
                                            (index) {
                                              return Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                    vertical: 5.h),
                                                margin: EdgeInsets.only(
                                                    right: 4.w, bottom: 4.h),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: const Color.fromARGB(
                                                        255, 220, 220, 220),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                                child: Text(
                                                  userProfile.skills[index],
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.color,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                    isExpanded: isExpanded7,
                                    onExpansionChanged: (value) {
                                      setState(() {
                                        isExpanded7 = value;
                                      });
                                    },
                                  ),
                                  ProfileExpansionTile(
                                    title: 'Interests',
                                    icon:
                                        'assets/Icons/profile/profile-interest.png',
                                    childrens: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 40.w),
                                        child: Wrap(
                                          spacing: 11.r,
                                          children: List.generate(
                                            userProfile.interests.length,
                                            (index) {
                                              return Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                    vertical: 5.h),
                                                margin: EdgeInsets.only(
                                                    right: 4.w, bottom: 4.h),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: const Color.fromARGB(
                                                        255, 220, 220, 220),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                                child: Text(
                                                  userProfile.interests[index],
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.color,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                    isExpanded: isExpanded9,
                                    onExpansionChanged: (value) {
                                      setState(() {
                                        isExpanded9 = value;
                                      });
                                    },
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/Icons/profile/profile-delete.png',
                                        height: 20.h,
                                        width: 20.w,
                                      ),
                                      SizedBox(width: 20.w),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                insetPadding: EdgeInsets.zero,
                                                title: Center(
                                                  child: Text('Delete Profile',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 17.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge
                                                            ?.color,
                                                      )),
                                                ),
                                                content: const Text(
                                                  textAlign: TextAlign.center,
                                                  'Are you sure you want to delete your profile?',
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Theme.of(context)
                                                            .dialogTheme
                                                            .iconColor,
                                                      ),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                              UserProfileBloc>()
                                                          .add(
                                                              const DeleteUserProfile());
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .3,
                          ),
                          Image.asset('assets/Icons/no_profile.png',
                              width: 140.w, height: 140.h),
                          SizedBox(height: 10.h),
                          Text(
                            'No Profile Data Found',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.color),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'You don\'t have a profile. When you create one,\n it will appear here.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const EditProfileScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(327.w, 42.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              backgroundColor: AppColors.accent,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 10.h),
                            ),
                            child: Text(
                              'Create Profile',
                              style: TextStyle(
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  } else if (state is UserProfileError) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('No data found'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileExpansionTile extends StatelessWidget {
  // final UserProfile userProfile;
  final bool isExpanded;
  final ValueChanged<bool> onExpansionChanged;
  final String title;
  final String icon;
  final List<Widget> childrens;

  const ProfileExpansionTile({
    super.key,
    // required this.userProfile,
    required this.isExpanded,
    required this.onExpansionChanged,
    required this.title,
    required this.icon,
    required this.childrens,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      expandedAlignment: Alignment.topLeft,
      minTileHeight: 26.h,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(10.r),
      ),
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      dense: true,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      onExpansionChanged: onExpansionChanged,
      trailing: isExpanded
          ? Icon(Icons.expand_less, size: 20.r)
          : Icon(Icons.expand_more, size: 20.r),
      leading: Image.asset(
        icon,
        height: 20.h,
        width: 20.w,
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
      children: childrens,
    );
  }
}

class CustomTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? date; // Optional date parameter
  final bool useRowLayout; // Flag to switch between Column and Row layout

  const CustomTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.date, // Nullable, so it’s optional
    this.useRowLayout = false, // Default to Column layout (false)
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327.w,
      padding: EdgeInsets.only(left: 40.w, right: 25.w, bottom: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (useRowLayout && date != null) // For CustomTileForCertificate
            Row(
              children: [
                Text(
                  date!,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              ],
            )
          else ...[
            // For CustomTile and CustomTileForEducation
            Text(
              subtitle,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
            if (date != null) // Only show date if provided
              Text(
                date!,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
          ],
        ],
      ),
    );
  }
}
