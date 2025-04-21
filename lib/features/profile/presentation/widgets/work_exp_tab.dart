import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_resume/features/profile/presentation/cubit/user_profile_data_cubit.dart';
import 'package:my_resume/features/resume/data/model/work_experience_model.dart';
import 'package:my_resume/core/utils/date_utils.dart';
import 'package:my_resume/core/utils/custom_dialog.dart';

class WorkExpTab extends StatefulWidget {
  const WorkExpTab({super.key});

  @override
  State<WorkExpTab> createState() => _WorkExpTabState();
}

class _WorkExpTabState extends State<WorkExpTab> {
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController jobTypeController = TextEditingController();
  TextEditingController dateRangeController = TextEditingController();
  TextEditingController achievementsController = TextEditingController();

  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  void _editWorkExp({
    required int index,
    required WorkExperience workExperience,
  }) {
    jobTitleController.text = workExperience.jobTitle;
    companyNameController.text = workExperience.companyName;
    jobTypeController.text = workExperience.jobType;
    // achievementsController.text = workExperience.achievements.join(', ');

    // Set initial date range display
    selectedStartDate = CustomDateUtils.parseDate(workExperience.startDate);
    selectedEndDate = CustomDateUtils.parseDate(workExperience.endDate);
    dateRangeController.text = selectedStartDate != null &&
            selectedEndDate != null
        ? '${CustomDateUtils.formatMonthYear(workExperience.startDate)} - ${CustomDateUtils.formatMonthYear(workExperience.endDate)}'
        : '';

    showDialog(
      context: context,
      builder: (context) {
        return DialogUtils.buildDialog(
          context: context,
          title: 'Edit Work Experience',
          content: [
            DialogUtils.styledTextField(
              controller: dateRangeController,
              hintText: 'Select Start and End dates',
              onChanged: (_) {},
              isDateField: true,
              onDateTap: () => CustomDateUtils.selectDateRange(
                context: context,
                controller: dateRangeController,
                onDatesSelected: (start, end) {
                  setState(() {
                    selectedStartDate = start;
                    selectedEndDate = end;
                  });
                },
              ),
              context: context,
            ),
            DialogUtils.styledTextField(
              controller: jobTitleController,
              hintText: 'Job Title',
              onChanged: (val) => setState(() => jobTitleController.text = val),
              context: context,
            ),
            DialogUtils.styledTextField(
              controller: companyNameController,
              hintText: 'Company Name',
              onChanged: (val) =>
                  setState(() => companyNameController.text = val),
              context: context,
            ),
            DialogUtils.styledTextField(
              controller: jobTypeController,
              hintText: 'Job Type',
              onChanged: (val) => setState(() => jobTypeController.text = val),
              context: context,
            ),
            DialogUtils.styledTextField(
              controller: achievementsController,
              hintText: 'Achievements (comma-separated)',
              onChanged: (val) =>
                  setState(() => achievementsController.text = val),
              context: context,
            ),
          ],
          actions: DialogUtils.dialogActions(
            context: context,
            onSave: () {
              setState(() {
                context.read<UserProfileDataCubit>().updateWorkExperience(
                      index: index,
                      workExperience: WorkExperience(
                        jobTitle: jobTitleController.text,
                        companyName: companyNameController.text,
                        startDate:
                            CustomDateUtils.formatForStorage(selectedStartDate),
                        endDate:
                            CustomDateUtils.formatForStorage(selectedEndDate),
                        jobType: jobTypeController.text,
                        achievements: achievementsController.text.isNotEmpty
                            ? achievementsController.text
                                .split(',')
                                .map((e) => e.trim())
                                .toList()
                            : ['Achievement'],
                      ),
                    );
              });
              Navigator.pop(context);
            },
            onCancel: () => Navigator.pop(context),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocBuilder<UserProfileDataCubit, UserProfileDataState>(
        builder: (context, state) {
          if (state is UserProfileDataLoaded) {
            final userProfile = state.userProfile;
            return SingleChildScrollView(
              primary: true,
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Column(
                  children:
                      List.generate(userProfile.workExperience.length, (index) {
                    return SizedBox(
                      width: double.infinity,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20.r),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Theme.of(context).appBarTheme.backgroundColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(12.0.r),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userProfile.workExperience[index].jobTitle,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.color,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    userProfile
                                        .workExperience[index].companyName,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color,
                                      fontSize: 10.sp,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    '${CustomDateUtils.formatMonthYear(userProfile.workExperience[index].startDate)} - ${CustomDateUtils.formatMonthYear(userProfile.workExperience[index].endDate)}',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color,
                                      fontSize: 10.sp,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    userProfile.workExperience[index].jobType,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color,
                                      fontSize: 10.sp,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 12.w, bottom: 12.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () => _editWorkExp(
                                      index: index,
                                      workExperience:
                                          userProfile.workExperience[index],
                                    ),
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .dialogTheme
                                            .iconColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20.w),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        context
                                            .read<UserProfileDataCubit>()
                                            .removeWorkExperience(index: index);
                                      });
                                    },
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).dialogTheme.iconColor,
        foregroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
        onPressed: () {
          setState(() {
            context.read<UserProfileDataCubit>().addWorkExperience(
                  workExperience: WorkExperience(
                    jobTitle: 'Job Title',
                    companyName: 'Company Name',
                    jobType: 'Job Type',
                    startDate: '',
                    endDate: '',
                    achievements: ['Achievement'],
                  ),
                );
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
