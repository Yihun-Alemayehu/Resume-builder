import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_resume/features/profile/presentation/cubit/user_profile_data_cubit.dart';
import 'package:my_resume/features/profile/presentation/widgets/my_textfield.dart';
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

  Future<void> _selectDateRange() async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2120),
    );

    if (picked != null) {
      dateRangeController.text =
          "${picked.start.toString().split(' ')[0]} - ${picked.end.toString().split(' ')[0]}";
    }
  }

  void _editEducation({
    required int index,
    required EducationBackground education,
  }) {
    fieldOfStudyController.text = education.fieldOfStudy;
    institutionNameController.text = education.institutionName;
    institutionAddressController.text = education.institutionAddress;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          title: const Text('Edit Education'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTextField(
                  controller: fieldOfStudyController,
                  hintText: 'Field of Study',
                  function: (val) {
                    setState(() {
                      fieldOfStudyController.text = val;
                    });
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                MyTextField(
                  controller: institutionNameController,
                  hintText: 'Institution Name',
                  function: (val) {
                    setState(() {
                      institutionNameController.text = val;
                    });
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                MyTextField(
                  controller: institutionAddressController,
                  hintText: 'Institution Address',
                  function: (val) {
                    setState(() {
                      institutionAddressController.text = val;
                    });
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: dateRangeController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: _selectDateRange,
                      icon: const Icon(Icons.date_range),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    hintText: 'Select start and end date',
                    hintStyle: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                    border: const OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10.h),
                  ),
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Update education background at index
                setState(() {
                  context.read<UserProfileDataCubit>().updateEducation(
                        index: index,
                        educationBackground: EducationBackground(
                          fieldOfStudy: fieldOfStudyController.text,
                          institutionName: institutionNameController.text,
                          startDate: dateRangeController.text
                              .toString()
                              .split(' -')[0],
                          endDate: dateRangeController.text
                              .toString()
                              .split(' -')[1],
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
              child: const Text('Save', style: TextStyle(color: Colors.green)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserProfileDataCubit, UserProfileDataState>(
        builder: (context, state) {
          if (state is UserProfileDataLoaded) {
            final userProfile = state.userProfile;
            return SingleChildScrollView(
              primary: true,
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.all(5.0.r),
                child: Column(
                  children:
                      List.generate(userProfile.education.length, (index) {
                    return SizedBox(
                      width: double.infinity,
                      child: Card(
                        color: Colors.white,
                        elevation: 5.r,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0.r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userProfile.education[index].fieldOfStudy,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    userProfile
                                        .education[index].institutionName,
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 5.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${userProfile.education[index].startDate} - ${userProfile.education[index].endDate}',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12.sp,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        Text(
                                          userProfile.education[index]
                                              .institutionAddress,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12.sp,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.r),
                                  bottomRight: Radius.circular(12.r),
                                ),
                                color: Colors.grey.shade300,
                              ),
                              child: Row(
                                children: [
                                  TextButton(
                                    onPressed: () => _editEducation(
                                        index: index,
                                        education:
                                            userProfile.education[index]),
                                    child: const Text(
                                      'Edit',
                                      style: TextStyle(
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Delete education background at index
                                      setState(() {
                                        context
                                            .read<UserProfileDataCubit>()
                                            .removeEducation(index: index);
                                      });
                                    },
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                        color: Colors.red.shade300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add education background
          setState(() {
            context.read<UserProfileDataCubit>().addEducation(
                  education: EducationBackground(
                    fieldOfStudy: 'Field of Study',
                    institutionName: 'Institution Name',
                    institutionAddress: 'institution Address',
                    startDate: 'start date',
                    endDate: 'end date',
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
