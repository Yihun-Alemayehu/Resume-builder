import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_resume/core/utils/custom_dialog.dart';
import 'package:my_resume/features/profile/presentation/cubit/user_profile_data_cubit.dart';

class InterestTab extends StatefulWidget {
  const InterestTab({super.key});

  @override
  State<InterestTab> createState() => _InterestTabState();
}

class _InterestTabState extends State<InterestTab> {
  final TextEditingController _controller = TextEditingController();
  bool _isTemporaryInterest = false; // Flag to track temporary interest
  late UserProfileDataCubit _userProfileDataCubit; // Store cubit reference

  @override
  void initState() {
    super.initState();
    // Save reference to the cubit
    _userProfileDataCubit = context.read<UserProfileDataCubit>();
    // Check if interests is empty and add a default section
    final userProfile = _userProfileDataCubit.state;
    if (userProfile is UserProfileDataLoaded &&
        userProfile.userProfile.interests.isEmpty) {
      _userProfileDataCubit.addInterest(interest: 'Interest Name');
      _isTemporaryInterest = true; // Mark as temporary
    }
  }

  @override
  void dispose() {
    // Use stored cubit reference instead of context
    if (_isTemporaryInterest) {
      _userProfileDataCubit.removeInterest(index: 0);
    }
    // Dispose controller to prevent memory leaks
    _controller.dispose();
    super.dispose();
  }

  void _addInterest() {
    _controller.clear(); // Clear the controller for a new entry
    showDialog(
      context: context,
      builder: (context) {
        return DialogUtils.buildDialog(
          context: context,
          title: 'Add Interest',
          content: [
            DialogUtils.styledTextField(
              controller: _controller,
              hintText: 'Interest',
              onChanged: (val) => setState(() => _controller.text = val),
              context: context,
            ),
          ],
          actions: DialogUtils.dialogActions(
            context: context,
            onSave: () {
              setState(() {
                _userProfileDataCubit.addInterest(interest: _controller.text);
                _isTemporaryInterest = false; // Clear temporary flag on save
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
                userProfile.interests.length,
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
                            userProfile.interests[index],
                            style: const TextStyle(),
                          ),
                          SizedBox(width: 6.w),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _userProfileDataCubit.removeInterest(
                                    index: index);
                                _isTemporaryInterest =
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
        onPressed: _addInterest,
        child: const Icon(Icons.add),
      ),
    );
  }
}
