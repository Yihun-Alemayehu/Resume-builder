import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_resume/core/utils/custom_dialog.dart';
import 'package:my_resume/features/profile/presentation/cubit/user_profile_data_cubit.dart';

class SkillTab extends StatefulWidget {
  const SkillTab({super.key});

  @override
  State<SkillTab> createState() => _SkillTabState();
}

class _SkillTabState extends State<SkillTab> {
  final TextEditingController _controller = TextEditingController();
  bool _isTemporarySkill = false; // Flag to track temporary skill
  late UserProfileDataCubit _userProfileDataCubit; // Store cubit reference

  @override
  void initState() {
    super.initState();
    // Save reference to the cubit
    _userProfileDataCubit = context.read<UserProfileDataCubit>();
    // Check if skills is empty and add a default section
    final userProfile = _userProfileDataCubit.state;
    if (userProfile is UserProfileDataLoaded &&
        userProfile.userProfile.skills.isEmpty) {
      _userProfileDataCubit.addSkill(skill: 'Skill Name');
      _isTemporarySkill = true; // Mark as temporary
    }
  }

  @override
  void dispose() {
    // Use stored cubit reference instead of context
    if (_isTemporarySkill) {
      _userProfileDataCubit.removeSkill(index: 0);
    }
    // Dispose controller to prevent memory leaks
    _controller.dispose();
    super.dispose();
  }

  void _addSkill() {
    _controller.clear(); // Clear the controller for a new entry
    showDialog(
      context: context,
      builder: (context) {
        return DialogUtils.buildDialog(
          context: context,
          title: 'Add Skill',
          content: [
            DialogUtils.styledTextField(
              controller: _controller,
              hintText: 'Skill Name',
              onChanged: (val) => setState(() => _controller.text = val),
              context: context,
            ),
          ],
          actions: DialogUtils.dialogActions(
            context: context,
            onSave: () {
              setState(() {
                _userProfileDataCubit.addSkill(skill: _controller.text);
                _isTemporarySkill = false; // Clear temporary flag on save
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
      body: BlocBuilder<UserProfileDataCubit, UserProfileDataState>(
        builder: (context, state) {
          if (state is UserProfileDataLoaded) {
            final userProfile = state.userProfile;
            return Wrap(
              spacing: 4.r,
              children: List.generate(
                userProfile.skills.length,
                (index) {
                  return IntrinsicWidth(
                    child: Container(
                      height: 30.h,
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      margin: EdgeInsets.only(right: 4.w, bottom: 4.h),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 220, 220, 220),
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            userProfile.skills[index],
                            style: const TextStyle(),
                          ),
                          SizedBox(width: 4.w),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _userProfileDataCubit.removeSkill(index: index);
                                _isTemporarySkill =
                                    false; // Clear flag on delete
                              });
                            },
                            child: Icon(
                              Icons.close,
                              size: 14.r,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
        onPressed: _addSkill,
        child: const Icon(Icons.add),
      ),
    );
  }
}
