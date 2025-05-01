import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_resume/core/utils/custom_dialog.dart';
import 'package:my_resume/features/profile/presentation/cubit/user_profile_data_cubit.dart';
import 'package:my_resume/features/resume/data/model/language_model.dart';

class LanguagesTab extends StatefulWidget {
  const LanguagesTab({super.key});

  @override
  State<LanguagesTab> createState() => _LanguagesTabState();
}

class _LanguagesTabState extends State<LanguagesTab> {
  final TextEditingController languageController = TextEditingController();
  String? selectedProficiency;
  bool _isTemporaryLanguage = false; // Flag to track temporary language
  late UserProfileDataCubit _userProfileDataCubit; // Store cubit reference

  @override
  void initState() {
    super.initState();
    // Save reference to the cubit
    _userProfileDataCubit = context.read<UserProfileDataCubit>();
    // Check if languages is empty and add a default section
    final userProfile = _userProfileDataCubit.state;
    if (userProfile is UserProfileDataLoaded &&
        userProfile.userProfile.languages.isEmpty) {
      _userProfileDataCubit.addLanguage(
        language: LanguageModel(
          language: 'Language',
          proficiency: 'Advanced',
        ),
      );
      _isTemporaryLanguage = true; // Mark as temporary
    }
  }

  @override
  void dispose() {
    // Use stored cubit reference instead of context
    if (_isTemporaryLanguage) {
      _userProfileDataCubit.removeLanguage(index: 0);
    }
    // Dispose controller to prevent memory leaks
    languageController.dispose();
    super.dispose();
  }

  void _editLanguage({required int index, required LanguageModel language}) {
    languageController.text = language.language;
    selectedProficiency = language.proficiency;

    showDialog(
      context: context,
      builder: (context) {
        return DialogUtils.buildDialog(
          context: context,
          title: 'Edit Language',
          content: [
            DialogUtils.styledTextField(
              controller: languageController,
              hintText: 'Language',
              onChanged: (val) => setState(() => languageController.text = val),
              context: context,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Proficiency',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                SizedBox(height: 5.h),
                Container(
                  height: 41.h,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: const Color.fromARGB(255, 199, 198, 198),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor:
                          Theme.of(context).appBarTheme.backgroundColor,
                      value: selectedProficiency,
                      isExpanded: true,
                      items: <String>[
                        'Beginner',
                        'Intermediate',
                        'Advanced',
                        'Fluent'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14.sp,
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedProficiency = newValue!;
                        });
                      },
                      hint: Text(
                        'Select Proficiency',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.sp,
                          fontStyle: FontStyle.italic,
                          color: const Color.fromARGB(255, 199, 198, 198),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ],
          actions: DialogUtils.dialogActions(
            context: context,
            onSave: () {
              setState(() {
                _userProfileDataCubit.updateLanguage(
                  index: index,
                  languageModel: LanguageModel(
                    language: languageController.text,
                    proficiency: selectedProficiency ?? 'Advanced',
                  ),
                );
                _isTemporaryLanguage = false; // Clear temporary flag on save
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
                      List.generate(userProfile.languages.length, (index) {
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
                                    userProfile.languages[index].language,
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
                                    userProfile.languages[index].proficiency,
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
                                    onTap: () => _editLanguage(
                                      index: index,
                                      language: userProfile.languages[index],
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
                                        _userProfileDataCubit.removeLanguage(
                                            index: index);
                                        _isTemporaryLanguage =
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
            _userProfileDataCubit.addLanguage(
              language: LanguageModel(
                language: 'Language',
                proficiency: 'Advanced',
              ),
            );
            _isTemporaryLanguage = true; // Mark new language as temporary
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
