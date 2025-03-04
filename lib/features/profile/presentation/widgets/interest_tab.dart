import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_resume/features/profile/presentation/cubit/user_profile_data_cubit.dart';
import 'package:my_resume/features/profile/presentation/widgets/my_textfield.dart';

class InterestTab extends StatefulWidget {
  const InterestTab({super.key});

  @override
  State<InterestTab> createState() => _InterestTabState();
}

class _InterestTabState extends State<InterestTab> {
  final TextEditingController _controller = TextEditingController();

  void _addInterest() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          title: const Text('Add Interest'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTextField(
                  hintText: 'interest',
                  function: (val) {
                    setState(() {
                      _controller.text = val;
                    });
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  context
                      .read<UserProfileDataCubit>()
                      .addInterest(interest: _controller.text);
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
            return Wrap(
              spacing: 4.r,
              children: List.generate(
                userProfile.interests.length,
                (index) {
                  return IntrinsicWidth(
                    child: Container(
                      height: 30.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.h,
                      ),
                      margin: EdgeInsets.only(right: 4.w, bottom: 4.h),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 73, 150, 159),
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            userProfile.interests[index],
                            style: const TextStyle(
                                // fontSize: 16,
                                ),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                context
                                    .read<UserProfileDataCubit>()
                                    .removeInterest(index: index);
                              });
                            },
                            child: Icon(
                              Icons.close,
                              size: 14.r,
                            ),
                          )
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
        onPressed: _addInterest,
        child: const Icon(Icons.add),
      ),
    );
  }
}
