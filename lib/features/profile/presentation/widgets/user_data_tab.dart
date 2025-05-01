import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_resume/features/profile/data/model/user_profile_model.dart';
import 'package:my_resume/features/profile/presentation/cubit/user_profile_data_cubit.dart';

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

  Future<void> pickAndCropImage({required UserProfile userProfile}) async {
    final ImagePicker _picker = ImagePicker();

    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Theme.of(context).dialogTheme.iconColor,
          toolbarWidgetColor: Colors.white,
          hideBottomControls: true,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
        ),
        IOSUiSettings(
          title: 'Crop Image',
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );

    if (croppedFile == null) return;
    _image = File(croppedFile.path);
    setState(() {
      _image = File(_image!.path);
      context.read<UserProfileDataCubit>().updateUserProfile(
            user: userProfile.userdata.copyWith(profilePic: _image),
          );
    });
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
          websiteController.text = userProfile.userdata.website ?? '';
          githubController.text = userProfile.userdata.github ?? '';
          linkedInController.text = userProfile.userdata.linkedIn ?? '';
          _image = userProfile.userdata.profilePic;

          log('_image: ${userProfile.userdata.profilePic}');

          return SingleChildScrollView(
            primary: true,
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.only(top: 30.h),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: CircleAvatar(
                          radius: 50.r,
                          backgroundImage: _image == null || _image!.path == ''
                              ? const AssetImage('assets/copy.jpg')
                              : FileImage(_image!) as ImageProvider<Object>?,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 78.w,
                        child: GestureDetector(
                          onTap: () {
                            pickAndCropImage(userProfile: userProfile);
                          },
                          child: Image.asset(
                            'assets/Icons/profile/profile-edit-pic.png',
                            height: 20.h,
                            width: 20.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  PersonalFieldRow(
                    name: 'Name: ',
                    hintText: 'Yihun Alemayehu',
                    controller: fullNameController,
                    userProfile: userProfile,
                    onFieldChange: (val) {
                      setState(() {
                        context.read<UserProfileDataCubit>().updateUserProfile(
                              user:
                                  userProfile.userdata.copyWith(fullName: val),
                            );
                      });
                    },
                  ),
                  PersonalFieldRow(
                    name: 'Profession: ',
                    hintText: 'Software Engineer',
                    controller: professionController,
                    userProfile: userProfile,
                    onFieldChange: (val) {
                      setState(() {
                        context.read<UserProfileDataCubit>().updateUserProfile(
                              user: userProfile.userdata
                                  .copyWith(profession: val),
                            );
                      });
                    },
                  ),
                  PersonalFieldRow(
                    name: 'Email: ',
                    hintText: 'yankure01@gmail.com',
                    controller: emailController,
                    userProfile: userProfile,
                    onFieldChange: (val) {
                      setState(() {
                        context.read<UserProfileDataCubit>().updateUserProfile(
                              user: userProfile.userdata.copyWith(email: val),
                            );
                      });
                    },
                  ),
                  PersonalFieldRow(
                    name: 'Phone: ',
                    hintText: '+251 982 394 038',
                    controller: phoneNumberController,
                    userProfile: userProfile,
                    onFieldChange: (val) {
                      setState(() {
                        context.read<UserProfileDataCubit>().updateUserProfile(
                              user: userProfile.userdata
                                  .copyWith(phoneNumber: val),
                            );
                      });
                    },
                  ),
                  PersonalFieldRow(
                    name: 'Address: ',
                    hintText: 'Addis Ababa',
                    controller: addressController,
                    userProfile: userProfile,
                    onFieldChange: (val) {
                      setState(() {
                        context.read<UserProfileDataCubit>().updateUserProfile(
                              user: userProfile.userdata.copyWith(address: val),
                            );
                      });
                    },
                  ),
                  PersonalFieldRow(
                    name: 'Linkedin: ',
                    hintText: 'https://linkedin.com/in/Yihun-Alemayehu',
                    controller: linkedInController,
                    userProfile: userProfile,
                    onFieldChange: (val) {
                      setState(() {
                        context.read<UserProfileDataCubit>().updateUserProfile(
                              user:
                                  userProfile.userdata.copyWith(linkedIn: val),
                            );
                      });
                    },
                  ),
                  PersonalFieldRow(
                    name: 'Github: ',
                    hintText: 'https://github.com/Yihun-Alemayehu',
                    controller: githubController,
                    userProfile: userProfile,
                    onFieldChange: (val) {
                      setState(() {
                        context.read<UserProfileDataCubit>().updateUserProfile(
                              user: userProfile.userdata.copyWith(github: val),
                            );
                      });
                    },
                  ),
                  PersonalFieldRow(
                    name: 'Website: ',
                    hintText: 'https://example.com',
                    controller: websiteController,
                    userProfile: userProfile,
                    onFieldChange: (val) {
                      setState(() {
                        context.read<UserProfileDataCubit>().updateUserProfile(
                              user: userProfile.userdata.copyWith(website: val),
                            );
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 13.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 21.h,
                          width: 77.w,
                          child: Text(
                            'About: ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 227.w,
                          child: TextField(
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color,
                            ),
                            cursorColor:
                                Theme.of(context).textTheme.bodyLarge?.color,
                            controller: bioController,
                            onChanged: (val) {
                              setState(() {
                                context
                                    .read<UserProfileDataCubit>()
                                    .updateUserProfile(
                                      user: userProfile.userdata
                                          .copyWith(bio: val),
                                    );
                              });
                            },
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText:
                                  'I am a passionate software engineer with 5 years of experience in mobile and web development.',
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color,
                              ),
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 199, 198, 198),
                                ),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 199, 198, 198),
                                ),
                              ),
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
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class PersonalFieldRow extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onFieldChange;
  final UserProfile userProfile;
  final String name;
  final String hintText;

  const PersonalFieldRow({
    Key? key,
    required this.controller,
    required this.onFieldChange,
    required this.userProfile,
    required this.name,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 13.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 21.h,
            width: 77.w,
            child: Text(
              name,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ),
          SizedBox(
            width: 227.w,
            child: TextField(
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
              cursorColor: Theme.of(context).textTheme.bodyLarge?.color,
              controller: controller,
              onChanged: onFieldChange,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
                contentPadding: EdgeInsets.zero,
                isDense: true,
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 199, 198, 198),
                  ),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 199, 198, 198),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
