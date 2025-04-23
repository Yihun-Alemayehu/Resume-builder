import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_resume/core/utils/custom_dialog.dart';
import 'package:my_resume/core/utils/date_utils.dart';
import 'package:my_resume/features/profile/presentation/cubit/user_profile_data_cubit.dart';
import 'package:my_resume/features/resume/data/model/education_model.dart';

class EducationBackgroundTab extends StatefulWidget {
  const EducationBackgroundTab({super.key});

  @override
  State<EducationBackgroundTab> createState() => _EducationBackgroundTabState();
}

class _EducationBackgroundTabState extends State<EducationBackgroundTab> {
  TextEditingController fieldOfStudyController = TextEditingController();
  TextEditingController institutionNameController = TextEditingController();
  TextEditingController institutionAddressController = TextEditingController();
  TextEditingController dateRangeController = TextEditingController();

  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  void _editEducation({
    required int index,
    required EducationBackground education,
  }) {
    fieldOfStudyController.text = education.fieldOfStudy;
    institutionNameController.text = education.institutionName;
    institutionAddressController.text = education.institutionAddress;

    // Set initial date range display
    selectedStartDate = CustomDateUtils.parseDate(education.startDate);
    selectedEndDate = CustomDateUtils.parseDate(education.endDate);
    dateRangeController.text = selectedStartDate != null &&
            selectedEndDate != null
        ? '${CustomDateUtils.formatMonthYear(education.startDate)} - ${CustomDateUtils.formatMonthYear(education.endDate)}'
        : '';

    showDialog(
      context: context,
      builder: (context) {
        return DialogUtils.buildDialog(
          context: context,
          title: 'Edit Education',
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
              controller: fieldOfStudyController,
              hintText: 'Field of Study',
              onChanged: (val) =>
                  setState(() => fieldOfStudyController.text = val),
              context: context,
            ),
            DialogUtils.styledTextField(
              controller: institutionNameController,
              hintText: 'Institution Name',
              onChanged: (val) =>
                  setState(() => institutionNameController.text = val),
              context: context,
            ),
            DialogUtils.styledTextField(
              controller: institutionAddressController,
              hintText: 'Institution Address',
              onChanged: (val) =>
                  setState(() => institutionAddressController.text = val),
              context: context,
            ),
          ],
          actions: DialogUtils.dialogActions(
            context: context,
            onSave: () {
              setState(() {
                context.read<UserProfileDataCubit>().updateEducation(
                      index: index,
                      educationBackground: EducationBackground(
                        fieldOfStudy: fieldOfStudyController.text,
                        institutionName: institutionNameController.text,
                        startDate:
                            CustomDateUtils.formatForStorage(selectedStartDate),
                        endDate:
                            CustomDateUtils.formatForStorage(selectedEndDate),
                        institutionAddress: institutionAddressController.text,
                        courses: [
                          'Course 1',
                          'Course 2',
                          'Course 3',
                          'Course 4',
                        ],
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
                      List.generate(userProfile.education.length, (index) {
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
                                    userProfile.education[index].fieldOfStudy,
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
                                        .education[index].institutionName,
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
                                    '${CustomDateUtils.formatMonthYear(userProfile.education[index].startDate)} - ${CustomDateUtils.formatMonthYear(userProfile.education[index].endDate)}',
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
                                    onTap: () => _editEducation(
                                      index: index,
                                      education: userProfile.education[index],
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
                                            .removeEducation(index: index);
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
            context.read<UserProfileDataCubit>().addEducation(
                  education: EducationBackground(
                    fieldOfStudy: 'Field of Study',
                    institutionName: 'Institution Name',
                    institutionAddress: 'Institution Address',
                    startDate: '',
                    endDate: '',
                    courses: ['Course 1', 'Course 2'],
                  ),
                );
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
