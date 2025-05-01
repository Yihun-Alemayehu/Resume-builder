import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_resume/core/utils/custom_dialog.dart';
import 'package:my_resume/features/profile/data/model/reference_model.dart';
import 'package:my_resume/features/profile/presentation/cubit/user_profile_data_cubit.dart';

class ReferenceTab extends StatefulWidget {
  const ReferenceTab({super.key});

  @override
  State<ReferenceTab> createState() => _ReferenceTabState();
}

class _ReferenceTabState extends State<ReferenceTab> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController referenceTextController = TextEditingController();
  final ReferenceModel referenceSample = ReferenceModel(
    name: 'John Doe',
    referenceText: 'A highly skilled and dedicated professional.',
  );
  bool _isTemporaryReference = false; // Flag to track temporary reference
  late UserProfileDataCubit _userProfileDataCubit; // Store cubit reference

  @override
  void initState() {
    super.initState();
    // Save reference to the cubit
    _userProfileDataCubit = context.read<UserProfileDataCubit>();
    // Check if references is empty and add a default section
    final userProfile = _userProfileDataCubit.state;
    if (userProfile is UserProfileDataLoaded &&
        userProfile.userProfile.references.isEmpty) {
      _userProfileDataCubit.addReference(reference: referenceSample);
      _isTemporaryReference = true; // Mark as temporary
    }
  }

  @override
  void dispose() {
    // Use stored cubit reference instead of context
    if (_isTemporaryReference) {
      _userProfileDataCubit.removeReference(index: 0);
    }
    // Dispose controllers to prevent memory leaks
    nameController.dispose();
    referenceTextController.dispose();
    super.dispose();
  }

  void _editReference(int index, ReferenceModel reference) {
    nameController.text = reference.name;
    referenceTextController.text = reference.referenceText;

    showDialog(
      context: context,
      builder: (context) {
        return DialogUtils.buildDialog(
          context: context,
          title: 'Edit Reference',
          content: [
            DialogUtils.styledTextField(
              controller: nameController,
              hintText: 'Referrer Name',
              onChanged: (val) => setState(() => nameController.text = val),
              context: context,
            ),
            DialogUtils.styledTextField(
              maxLines: 3,
              controller: referenceTextController,
              hintText: 'Reference Text',
              onChanged: (val) =>
                  setState(() => referenceTextController.text = val),
              context: context,
            ),
          ],
          actions: DialogUtils.dialogActions(
            context: context,
            onSave: () {
              setState(() {
                _userProfileDataCubit.updateReference(
                  index: index,
                  reference: ReferenceModel(
                    name: nameController.text,
                    referenceText: referenceTextController.text,
                  ),
                );
                _isTemporaryReference = false; // Clear temporary flag on save
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
                      List.generate(userProfile.references.length, (index) {
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
                                    userProfile.references[index].name,
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
                                    userProfile.references[index].referenceText,
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
                                    onTap: () => _editReference(
                                        index, userProfile.references[index]),
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
                                        _userProfileDataCubit.removeReference(
                                            index: index);
                                        _isTemporaryReference =
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
            _userProfileDataCubit.addReference(reference: referenceSample);
            _isTemporaryReference = true; // Mark new reference as temporary
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
