import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_resume/core/utils/custom_dialog.dart';
import 'package:my_resume/core/utils/date_utils.dart';
import 'package:my_resume/features/profile/data/model/award_model.dart';
import 'package:my_resume/features/profile/presentation/cubit/user_profile_data_cubit.dart';

class AwardTab extends StatefulWidget {
  const AwardTab({super.key});

  @override
  State<AwardTab> createState() => _AwardTabState();
}

class _AwardTabState extends State<AwardTab> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController issuedCompanyController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  DateTime? selectedDate;
  bool _isTemporaryAward = false; // Flag to track temporary award
  late UserProfileDataCubit _userProfileDataCubit; // Store cubit reference

  @override
  void initState() {
    super.initState();
    // Save reference to the cubit
    _userProfileDataCubit = context.read<UserProfileDataCubit>();
    // Check if awards is empty and add a default section
    final userProfile = _userProfileDataCubit.state;
    if (userProfile is UserProfileDataLoaded &&
        userProfile.userProfile.awards.isEmpty) {
      _userProfileDataCubit.addAward(
        award: AwardModel(
          awardName: 'Award Name',
          issuedDate: CustomDateUtils.formatForStorage(DateTime.now()),
          issuedCompanyName: 'Issuing Organization',
        ),
      );
      _isTemporaryAward = true; // Mark as temporary
    }
  }

  @override
  void dispose() {
    // Use stored cubit reference instead of context
    if (_isTemporaryAward) {
      _userProfileDataCubit.removeAward(index: 0);
    }
    // Dispose controllers to prevent memory leaks
    nameController.dispose();
    issuedCompanyController.dispose();
    dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2120),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            primaryColor: Theme.of(context).dialogTheme.iconColor,
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Theme.of(context).dialogTheme.iconColor,
                ),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dateController.text = CustomDateUtils.formatMonthYear(
          CustomDateUtils.formatForStorage(picked),
        );
      });
    }
  }

  void _editAward({
    required int index,
    required AwardModel award,
  }) {
    nameController.text = award.awardName;
    issuedCompanyController.text = award.issuedCompanyName;
    selectedDate = CustomDateUtils.parseDate(award.issuedDate);
    dateController.text = CustomDateUtils.formatMonthYear(award.issuedDate);

    showDialog(
      context: context,
      builder: (context) {
        return DialogUtils.buildDialog(
          context: context,
          title: 'Edit Award',
          content: [
            DialogUtils.styledTextField(
              controller: dateController,
              hintText: 'Issued Date',
              onChanged: (_) {},
              isDateField: true,
              onDateTap: _selectDate,
              context: context,
            ),
            DialogUtils.styledTextField(
              controller: nameController,
              hintText: 'Award Name',
              onChanged: (val) => setState(() => nameController.text = val),
              context: context,
            ),
            DialogUtils.styledTextField(
              controller: issuedCompanyController,
              hintText: 'Issued Company Name',
              onChanged: (val) =>
                  setState(() => issuedCompanyController.text = val),
              context: context,
            ),
          ],
          actions: DialogUtils.dialogActions(
            context: context,
            onSave: () {
              setState(() {
                _userProfileDataCubit.updateAward(
                  index: index,
                  awardModel: AwardModel(
                    awardName: nameController.text,
                    issuedDate: CustomDateUtils.formatForStorage(selectedDate),
                    issuedCompanyName: issuedCompanyController.text,
                  ),
                );
                _isTemporaryAward = false; // Clear temporary flag on save
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
                  children: List.generate(userProfile.awards.length, (index) {
                    return SizedBox(
                      width: double.infinity,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20.r),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Theme.of(context).appBarTheme.backgroundColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(12.0.r),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userProfile.awards[index].awardName,
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
                                    userProfile.awards[index].issuedCompanyName,
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
                                    CustomDateUtils.formatMonthYear(
                                      userProfile.awards[index].issuedDate,
                                    ),
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
                                    onTap: () => _editAward(
                                      index: index,
                                      award: userProfile.awards[index],
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
                                        _userProfileDataCubit.removeAward(
                                            index: index);
                                        _isTemporaryAward =
                                            false; // Clear flag on delete
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
            _userProfileDataCubit.addAward(
              award: AwardModel(
                awardName: 'Award Name',
                issuedDate: CustomDateUtils.formatForStorage(DateTime.now()),
                issuedCompanyName: 'Issuing Organization',
              ),
            );
            _isTemporaryAward = true; // Mark new award as temporary
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
