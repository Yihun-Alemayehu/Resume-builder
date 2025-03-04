import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_resume/features/profile/data/model/user_profile_model.dart';
import 'package:my_resume/features/profile/presentation/cubit/user_profile_data_cubit.dart';
import 'package:my_resume/features/profile/presentation/widgets/my_textfield.dart';

class UserDataTab extends StatefulWidget {
  const UserDataTab({super.key});

  @override
  State<UserDataTab> createState() => _UserDataTabState();
}

class _UserDataTabState extends State<UserDataTab> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage({required UserProfile userProfile}) async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
        context.read<UserProfileDataCubit>().updateUserProfile(
              user: userProfile.userdata.copyWith(profilePic: _image),
            );
      });
    }
    setState(() {});
  }

  final TextEditingController professionController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController githubController = TextEditingController();
  final TextEditingController linkedInController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileDataCubit, UserProfileDataState>(
      builder: (context, state) {
        if (state is UserProfileDataLoaded) {
          final userProfile = state.userProfile;
          professionController.text = userProfile.userdata.profession;
          fullNameController.text = userProfile.userdata.fullName;
          emailController.text = userProfile.userdata.email;
          phoneNumberController.text = userProfile.userdata.phoneNumber;
          addressController.text = userProfile.userdata.address;
          bioController.text = userProfile.userdata.bio;
          websiteController.text = userProfile.userdata.website!;
          githubController.text = userProfile.userdata.github!;
          linkedInController.text = userProfile.userdata.linkedIn!;
          _image = userProfile.userdata.profilePic;

          return SingleChildScrollView(
            primary: true,
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.all(15.0.r),
              child: Column(
                children: [
                  _image == null
                      ? GestureDetector(
                          onTap: () {
                            pickImage(userProfile: userProfile);
                          },
                          child: CircleAvatar(
                            radius: 50.r,
                            backgroundImage: const AssetImage('assets/copy.jpg'),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            pickImage(userProfile: userProfile);
                          },
                          child: CircleAvatar(
                            radius: 50.r,
                            backgroundImage: FileImage(_image!),
                          ),
                        ),
                  SizedBox(height: 30.h),
                  MyTextField(
                    controller: professionController,
                    hintText: 'Profession title',
                    function: (val) {
                      setState(() {
                        context.read<UserProfileDataCubit>().updateUserProfile(
                              user: userProfile.userdata
                                  .copyWith(profession: val),
                            );
                      });
                    },
                  ),
                  SizedBox(height: 15.h),
                  MyTextField(
                    controller: fullNameController,
                    hintText: 'Full name',
                    function: (val) {
                      setState(() {
                        context.read<UserProfileDataCubit>().updateUserProfile(
                              user:
                                  userProfile.userdata.copyWith(fullName: val),
                            );
                      });
                    },
                  ),
                  SizedBox(height: 15.h),
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email address',
                    function: (val) {
                      setState(() {
                        context.read<UserProfileDataCubit>().updateUserProfile(
                              user: userProfile.userdata.copyWith(email: val),
                            );
                      });
                    },
                  ),
                  SizedBox(height: 15.h),
                  MyTextField(
                    controller: websiteController,
                    hintText: 'Website URL',
                    function: (val) {
                      setState(() {
                        context.read<UserProfileDataCubit>().updateUserProfile(
                              user: userProfile.userdata.copyWith(website: val),
                            );
                      });
                    },
                  ),
                  SizedBox(height: 15.h),
                  MyTextField(
                    controller: githubController,
                    hintText: 'Github',
                    function: (val) {
                      setState(() {
                        context.read<UserProfileDataCubit>().updateUserProfile(
                              user: userProfile.userdata.copyWith(github: val),
                            );
                      });
                    },
                  ),
                  SizedBox(height: 15.h),
                  MyTextField(
                    controller: linkedInController,
                    hintText: 'LinkedIn',
                    function: (val) {
                      setState(() {
                        context.read<UserProfileDataCubit>().updateUserProfile(
                              user:
                                  userProfile.userdata.copyWith(linkedIn: val),
                            );
                      });
                    },
                  ),
                  SizedBox(height: 15.h),
                  MyTextField(
                    controller: phoneNumberController,
                    hintText: 'Phone number',
                    function: (val) {
                      setState(() {
                        context.read<UserProfileDataCubit>().updateUserProfile(
                              user: userProfile.userdata
                                  .copyWith(phoneNumber: val),
                            );
                      });
                    },
                  ),
                  SizedBox(height: 15.h),
                  MyTextField(
                    controller: addressController,
                    hintText: 'Address',
                    function: (val) {
                      setState(() {
                        context.read<UserProfileDataCubit>().updateUserProfile(
                              user: userProfile.userdata.copyWith(address: val),
                            );
                      });
                    },
                  ),
                  SizedBox(height: 15.h),
                  MyTextField(
                    controller: bioController,
                    hintText: 'Brief Description about yourself',
                    function: (val) {
                      setState(() {
                        context.read<UserProfileDataCubit>().updateUserProfile(
                              user: userProfile.userdata.copyWith(bio: val),
                            );
                      });
                    },
                  ),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
