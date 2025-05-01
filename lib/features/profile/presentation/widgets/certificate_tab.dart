import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_resume/core/utils/custom_dialog.dart';
import 'package:my_resume/core/utils/date_utils.dart';
import 'package:my_resume/features/profile/data/model/certificate_model.dart';
import 'package:my_resume/features/profile/presentation/cubit/user_profile_data_cubit.dart';

class CertificateTab extends StatefulWidget {
  const CertificateTab({super.key});

  @override
  State<CertificateTab> createState() => _CertificateTabState();
}

class _CertificateTabState extends State<CertificateTab> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController issuedCompanyController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  DateTime? selectedDate;
  bool _isTemporaryCertificate = false; // Flag to track temporary certificate
  late UserProfileDataCubit _userProfileDataCubit; // Store cubit reference

  @override
  void initState() {
    super.initState();
    // Save reference to the cubit
    _userProfileDataCubit = context.read<UserProfileDataCubit>();
    // Check if certificates is empty and add a default section
    final userProfile = _userProfileDataCubit.state;
    if (userProfile is UserProfileDataLoaded &&
        userProfile.userProfile.certificates.isEmpty) {
      _userProfileDataCubit.addCertificate(
        certificate: CertificateModel(
          certificateName: 'Certificate Name',
          issuedDate: CustomDateUtils.formatForStorage(DateTime.now()),
          issuedCompanyName: 'Issuing Company',
        ),
      );
      _isTemporaryCertificate = true; // Mark as temporary
    }
  }

  @override
  void dispose() {
    // Use stored cubit reference instead of context
    if (_isTemporaryCertificate) {
      _userProfileDataCubit.removeCertificate(index: 0);
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
            scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
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

  void _editCertificate({
    required int index,
    required CertificateModel certificate,
  }) {
    nameController.text = certificate.certificateName;
    issuedCompanyController.text = certificate.issuedCompanyName;
    selectedDate = CustomDateUtils.parseDate(certificate.issuedDate);
    dateController.text =
        CustomDateUtils.formatMonthYear(certificate.issuedDate);

    showDialog(
      context: context,
      builder: (context) {
        return DialogUtils.buildDialog(
          context: context,
          title: 'Edit Certificate',
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
              hintText: 'Certificate Name',
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
                _userProfileDataCubit.updateCertificate(
                  index: index,
                  certificateModel: CertificateModel(
                    certificateName: nameController.text,
                    issuedDate: CustomDateUtils.formatForStorage(selectedDate),
                    issuedCompanyName: issuedCompanyController.text,
                  ),
                );
                _isTemporaryCertificate = false; // Clear temporary flag on save
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      List.generate(userProfile.certificates.length, (index) {
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
                                    userProfile
                                        .certificates[index].certificateName,
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
                                        .certificates[index].issuedCompanyName,
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
                                      userProfile
                                          .certificates[index].issuedDate,
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
                                    onTap: () => _editCertificate(
                                      index: index,
                                      certificate:
                                          userProfile.certificates[index],
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
                                        _userProfileDataCubit.removeCertificate(
                                            index: index);
                                        _isTemporaryCertificate =
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
            _userProfileDataCubit.addCertificate(
              certificate: CertificateModel(
                certificateName: 'Certificate Name',
                issuedDate: CustomDateUtils.formatForStorage(DateTime.now()),
                issuedCompanyName: 'Issuing Company',
              ),
            );
            _isTemporaryCertificate = true; // Mark new certificate as temporary
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
