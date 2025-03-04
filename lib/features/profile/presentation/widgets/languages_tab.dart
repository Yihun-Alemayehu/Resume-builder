import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_resume/features/profile/presentation/cubit/user_profile_data_cubit.dart';
import 'package:my_resume/features/profile/presentation/widgets/my_textfield.dart';
import 'package:my_resume/features/resume/data/model/language_model.dart';

class LanguagesTab extends StatefulWidget {
  const LanguagesTab({super.key});

  @override
  State<LanguagesTab> createState() => _LanguagesTabState();
}

class _LanguagesTabState extends State<LanguagesTab> {
  final TextEditingController languageController = TextEditingController();

  void _editLanguage({required int index, required LanguageModel language}) {
    languageController.text = language.language;
    String selectedProficiency = language.proficiency;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          title: const Text('Edit Language'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTextField(
                  controller: languageController,
                  hintText: 'Language',
                  function: (val) {
                    setState(() {
                      languageController.text = val;
                    });
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                DropdownButton<String>(
                  value: selectedProficiency,
                  items: <String>[
                    'Beginner',
                    'Intermediate',
                    'Advanced',
                    'Fluent'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedProficiency = newValue!;
                    });
                  },
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  context.read<UserProfileDataCubit>().updateLanguage(
                        index: index,
                        languageModel: LanguageModel(
                          language: languageController.text,
                          proficiency: selectedProficiency,
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
                      List.generate(userProfile.languages.length, (index) {
                    return SizedBox(
                      width: double.infinity,
                      child: Card(
                        color: Colors.white,
                        elevation: 5.r,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0.r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userProfile.languages[index].language,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    userProfile.languages[index].proficiency,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp),
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
                                    onPressed: () => _editLanguage(
                                        index: index,
                                        language: userProfile.languages[index]),
                                    child: const Text(
                                      'Edit',
                                      style: TextStyle(
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Delete Language at index
                                      setState(() {
                                        context
                                            .read<UserProfileDataCubit>()
                                            .removeLanguage(index: index);
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
          // Add Language
          setState(() {
            context.read<UserProfileDataCubit>().addLanguage(
                  language: LanguageModel(
                      language: 'language', proficiency: 'Advanced'),
                );
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
