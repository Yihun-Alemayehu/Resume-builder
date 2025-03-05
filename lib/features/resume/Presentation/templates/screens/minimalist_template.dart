// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_resume/features/profile/data/model/award_model.dart';
import 'package:my_resume/features/profile/data/model/certificate_model.dart';
import 'package:my_resume/features/resume/data/model/education_model.dart';
import 'package:my_resume/features/resume/data/model/language_model.dart';

import 'package:my_resume/features/resume/data/model/templates_model.dart';
import 'package:my_resume/features/resume/data/model/work_experience_model.dart';

class MinimalistTemplate extends StatefulWidget {
  TemplateModel templateData;
  MinimalistTemplate({
    Key? key,
    required this.templateData,
  }) : super(key: key);

  @override
  State<MinimalistTemplate> createState() => MinimalistTemplateState();
}

class MinimalistTemplateState extends State<MinimalistTemplate> {
  late TemplateModel templateData;
  List<File> icons = [
    File('assets/Icons/email1.png'),
    File('assets/Icons/pin.png'),
    File('assets/Icons/linkedin.png'),
    File('assets/Icons/telephone.png'),
    File('assets/Icons/github.png'),
    File('assets/Icons/internet.png'),
    File('assets/Icons/briefcase.png'),
    File('assets/Icons/education.png'),
    File('assets/Icons/skill.png'),
    File('assets/Icons/project.png'),
    File('assets/Icons/language.png'),
    File('assets/Icons/hobby.png'),
    File('assets/Icons/priority.png'),
    File('assets/Icons/priority1.png'),
  ];
  final List _iconsList1 = [
    'assets/Icons/mail.png',
    'assets/Icons/pin.png',
    'assets/Icons/telephone.png',
    'assets/Icons/linkedin.png',
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _linkedInController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  List<TextEditingController> fieldOfStudyControllers = [];
  List<TextEditingController> institutionNameControllers = [];
  List<TextEditingController> startDateControllers = [];
  List<TextEditingController> endDateControllers = [];
  List<TextEditingController> institutionAddressControllers = [];

  List<TextEditingController> jobTitleControllers = [];
  List<TextEditingController> companyNameControllers = [];
  List<TextEditingController> workStartDateControllers = [];
  List<TextEditingController> workEndDateControllers = [];
  List<TextEditingController> jobTypeControllers = [];
  List<List<TextEditingController>> achievementsControllers = [];

  List<TextEditingController> certificateNameController = [];
  List<TextEditingController> issuedDateController = [];

  List<TextEditingController> awardNameController = [];
  List<TextEditingController> awardIssuedDateController = [];

  final TextEditingController _addSkillController = TextEditingController();
  final TextEditingController _addCertificateController =
      TextEditingController();
  final TextEditingController _addLanguageControllerForLanguageName =
      TextEditingController();

  List<bool> _borderColorForEdu = [];
  List<bool> _borderColorForWorkExp = [];
  List<bool> _borderColorForCertificate = [];
  List<bool> _borderColorForAward = [];

  bool _borderColorForSkills = false;
  // bool _borderColorForCertificates = false;
  bool _borderColorForLanguage = false;
  bool _borderColorForInterests = false;

  List<bool> _showAddAchievementOnly = [];
  List _controllersList1 = [];

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    _image = File(image!.path);
    templateData = templateData.copyWith(
      userData: templateData.userData.copyWith(profilePic: _image),
    );
    setState(() {});
  }

  Future<void> _showMyDialog({
    required String title,
    required String type,
  }) async {
    const List<String> proficiencyList = [
      'Full Professional Proficient',
      'Professional Proficient',
      'Intermediate Proficient',
      'Basic Proficient',
    ];
    String dropDownValue = proficiencyList[0];

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: type == 'language'
              ? ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 90.h),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40.h,
                        child: TextField(
                          controller: _addLanguageControllerForLanguageName,
                          decoration: InputDecoration(
                            hintText: 'Add Language',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      SizedBox(
                        height: 40.h,
                        child: DropdownButton(
                          items: proficiencyList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              dropDownValue = value.toString();
                            });
                          },
                          value: dropDownValue,
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  height: 40.h,
                  width: MediaQuery.of(context).size.width * .9,
                  child: TextField(
                    controller: title == 'Add Skill'
                        ? _addSkillController
                        : _addCertificateController,
                    decoration: InputDecoration(
                      hintText: title,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue.shade900,
              ),
              child: const Text('Done'),
              onPressed: () {
                setState(() {
                  if (title == 'Add Skill') {
                    templateData.skills.add(_addSkillController.text);
                    _addSkillController.clear();
                  } else if (title == 'Add Personal Project') {
                    templateData.certificates.add(
                      CertificateModel(
                        certificateName: _addCertificateController.text,
                        issuedDate: 'description',
                      ),
                    );
                    _addCertificateController.clear();
                  } else {
                    templateData.languages.add(
                      LanguageModel(
                        language: _addLanguageControllerForLanguageName.text,
                        proficiency: dropDownValue,
                      ),
                    );
                  }
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Function to add a new Education Entry
  void _addEducationEntry({required EducationBackground edu}) {
    setState(() {
      fieldOfStudyControllers
          .add(TextEditingController(text: edu.fieldOfStudy));
      institutionNameControllers
          .add(TextEditingController(text: edu.institutionName));
      startDateControllers.add(TextEditingController(text: edu.startDate));
      endDateControllers.add(TextEditingController(text: edu.endDate));
      institutionAddressControllers
          .add(TextEditingController(text: edu.institutionAddress));
      _borderColorForEdu.add(false);
    });
  }

  void _addCertificateEntry({required CertificateModel certificate}) {
    setState(() {
      certificateNameController
          .add(TextEditingController(text: certificate.certificateName));
      issuedDateController
          .add(TextEditingController(text: certificate.issuedDate));
      _borderColorForCertificate.add(false);
    });
  }

  void _addAwardEntry({required AwardModel award}) {
    setState(() {
      awardNameController.add(TextEditingController(text: award.awardName));
      awardIssuedDateController
          .add(TextEditingController(text: award.issuedDate));
      _borderColorForAward.add(false);
    });
  }

  void _addWorkExperienceEntry({required WorkExperience work}) {
    setState(() {
      jobTitleControllers.add(TextEditingController(text: work.jobTitle));
      companyNameControllers.add(TextEditingController(text: work.companyName));
      workStartDateControllers.add(TextEditingController(text: work.startDate));
      workEndDateControllers.add(TextEditingController(text: work.endDate));
      jobTypeControllers.add(TextEditingController(text: work.jobType));

      List<TextEditingController> achievementControllers = [];
      for (var achievement in work.achievements) {
        achievementControllers.add(TextEditingController(text: achievement));
      }
      achievementsControllers.add(achievementControllers);
      _borderColorForWorkExp.add(false);
    });
  }

  void _addAchievement({required int index}) {
    setState(() {
      List<WorkExperience> updatedWorkExperience =
          List.from(templateData.workExperience);
      updatedWorkExperience[index] = updatedWorkExperience[index].copyWith(
        achievements: List.from(updatedWorkExperience[index].achievements)
          ..add('achievement'),
      );

      templateData =
          templateData.copyWith(workExperience: updatedWorkExperience);

      achievementsControllers[index]
          .add(TextEditingController(text: 'achievement'));
    });
  }

  void _initializeControllers({required TemplateModel templateData}) {
    // User controllers
    _nameController.text = templateData.userData.fullName;
    _professionController.text = templateData.userData.profession;
    _bioController.text = templateData.userData.bio;
    _emailController.text = templateData.userData.email;
    _addressController.text = templateData.userData.address;
    _linkedInController.text = templateData.userData.linkedIn!;
    _phoneController.text = templateData.userData.phoneNumber;

    // Populate controllers dynamically
    for (var edu in templateData.educationBackground) {
      _borderColorForEdu.add(false);
      fieldOfStudyControllers
          .add(TextEditingController(text: edu.fieldOfStudy));
      institutionNameControllers
          .add(TextEditingController(text: edu.institutionName));
      startDateControllers.add(TextEditingController(text: edu.startDate));
      endDateControllers.add(TextEditingController(text: edu.endDate));
      institutionAddressControllers
          .add(TextEditingController(text: edu.institutionAddress));
    }

    for (var work in templateData.workExperience) {
      _borderColorForWorkExp.add(false);
      jobTitleControllers.add(TextEditingController(text: work.jobTitle));
      companyNameControllers.add(TextEditingController(text: work.companyName));
      workStartDateControllers.add(TextEditingController(text: work.startDate));
      workEndDateControllers.add(TextEditingController(text: work.endDate));
      jobTypeControllers.add(TextEditingController(text: work.jobType));

      List<TextEditingController> achievementControllers = [];
      for (var achievement in work.achievements) {
        achievementControllers.add(TextEditingController(text: achievement));
      }
      achievementsControllers.add(achievementControllers);
    }

    for (var certificate in templateData.certificates) {
      _borderColorForCertificate.add(false);
      certificateNameController
          .add(TextEditingController(text: certificate.certificateName));
      issuedDateController
          .add(TextEditingController(text: certificate.issuedDate));
    }

    for (var award in templateData.awards) {
      _borderColorForAward.add(false);
      awardNameController.add(TextEditingController(text: award.awardName));
      awardIssuedDateController
          .add(TextEditingController(text: award.issuedDate));
    }
  }

  @override
  void initState() {
    templateData = widget.templateData;
    _initializeControllers(templateData: templateData);
    _showAddAchievementOnly =
        List.generate(templateData.workExperience.length, (index) => false);
    // Personal info Controllers
    _controllersList1.addAll([
      _emailController,
      _addressController,
      _phoneController,
      _linkedInController
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .35,
            child: Column(
              children: [
                _image == null
                    ? Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: GestureDetector(
                          onTap: () {
                            pickImage();
                          },
                          child: CircleAvatar(
                            radius: 40.r,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                File(templateData.userData.profilePic.path)
                                        .existsSync()
                                    ? FileImage(File(widget
                                        .templateData.userData.profilePic.path))
                                    : const AssetImage('assets/copy.jpg')
                                        as ImageProvider,
                          ),
                        ),
                      )
                    : CircleAvatar(
                        radius: 40.r,
                        backgroundColor: Colors.white,
                        backgroundImage: FileImage(_image!),
                      ),

                // THE REST IS HISTORY
                SizedBox(
                  child: Container(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SKILLS SECTION
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _borderColorForSkills
                                  ? const Color.fromARGB(255, 73, 150, 159)
                                  : Colors.white,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 20.h,
                                        width: 20.w,
                                        child: Center(
                                            child: Image.asset(
                                                'assets/Icons/priority.png',
                                                height: 20.h,
                                                width: 20.w)),
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        'SKILLS',
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 244, 102, 102),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  _borderColorForSkills
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _borderColorForSkills =
                                                  !_borderColorForSkills;
                                            });
                                          },
                                          child: Wrap(
                                              spacing: 4.r,
                                              children: List.generate(
                                                templateData.skills.length,
                                                (index) {
                                                  return IntrinsicWidth(
                                                    child: Container(
                                                      height: 25.h,
                                                      padding:
                                                          EdgeInsets.all(2.r),
                                                      margin: EdgeInsets.only(
                                                          right: 4.w,
                                                          bottom: 4.h),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.grey,
                                                        ),
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.r),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            templateData
                                                                .skills[index],
                                                            style: TextStyle(
                                                              fontSize: 10.sp,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 4.w,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                templateData = templateData.copyWith(
                                                                    skills: List.from(
                                                                        templateData
                                                                            .skills)
                                                                      ..removeAt(
                                                                          index));
                                                              });
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .grey
                                                                    .shade400,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4.r),
                                                              ),
                                                              child: Icon(
                                                                Icons.close,
                                                                size: 10.r,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              )),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _borderColorForSkills =
                                                  !_borderColorForSkills;
                                            });
                                          },
                                          child: GridView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount:
                                                  1, // 2 items per row
                                              crossAxisSpacing: 1
                                                  .h, // Spacing between columns
                                              mainAxisSpacing:
                                                  1.w, // Spacing between rows
                                              childAspectRatio:
                                                  8, // Adjust this to control the height of the items
                                            ),
                                            itemCount:
                                                templateData.skills.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5.w,
                                                    vertical: 2.h),
                                                child: Text(
                                                  templateData.skills[index],
                                                  style: TextStyle(
                                                      fontSize: 10.sp),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                ],
                              ),
                              _borderColorForSkills
                                  ? Positioned(
                                      top: 2.h,
                                      right: 2.w,
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () => _showMyDialog(
                                                title: 'Add Skill',
                                                type: 'skills'),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                              ),
                                              height: 20.h,
                                              width: 20.w,
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 15.r,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        // CERTIFICATES SECTION
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 20.h,
                                  width: 20.w,
                                  child: Center(
                                      child: Image.asset(
                                          'assets/Icons/priority.png',
                                          height: 20.h,
                                          width: 20.w)),
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  'CERTIFICATES',
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 244, 102, 102),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ],
                            ),
                            templateData.certificates.isEmpty
                                ? Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: 100.h,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 73, 150, 159)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          'No Certificates provided',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 8.sp,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              templateData =
                                                  templateData.copyWith(
                                                certificates: [
                                                  const CertificateModel(
                                                      certificateName:
                                                          'Certificate Name',
                                                      issuedDate:
                                                          'Issued date'),
                                                ],
                                              );
                                              _addCertificateEntry(
                                                  certificate: templateData
                                                      .certificates[0]);
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                              border: Border.all(
                                                  color: const Color.fromARGB(
                                                      255, 73, 150, 159)),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(2.0.r),
                                              child: Text(
                                                'Add Certificate',
                                                style: TextStyle(
                                                    fontSize: 8.sp,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: templateData.certificates.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: _borderColorForCertificate[
                                                    index]
                                                ? const Color.fromARGB(
                                                    255, 73, 150, 159)
                                                : Colors.white,
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 5.h,
                                                ),

                                                // PROJECT NAME
                                                TextField(
                                                  maxLines: null,
                                                  onTap: () {
                                                    setState(() {
                                                      _borderColorForCertificate[
                                                              index] =
                                                          !_borderColorForCertificate[
                                                              index];
                                                    });
                                                  },
                                                  onTapOutside: (event) {
                                                    setState(() {});
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                  },
                                                  onChanged: (value) {
                                                    setState(() {
                                                      templateData =
                                                          templateData.copyWith(
                                                        certificates: templateData
                                                            .certificates
                                                            .map((e) => e.copyWith(
                                                                certificateName:
                                                                    value))
                                                            .toList(),
                                                      );
                                                    });
                                                  },
                                                  controller:
                                                      certificateNameController[
                                                          index],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  decoration:
                                                      const InputDecoration(
                                                    isDense: true,
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    border: InputBorder.none,
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.zero,
                                                      borderSide: BorderSide(
                                                          color: Colors.green),
                                                    ),
                                                  ),
                                                ),

                                                // ISSUED DATE
                                                SizedBox(
                                                  child: TextField(
                                                    maxLines: null,
                                                    onTap: () {
                                                      setState(() {
                                                        _borderColorForCertificate[
                                                                index] =
                                                            !_borderColorForCertificate[
                                                                index];
                                                      });
                                                    },
                                                    onTapOutside: (event) {
                                                      setState(() {});
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                    },
                                                    onChanged: (value) {
                                                      setState(() {
                                                        templateData =
                                                            templateData
                                                                .copyWith(
                                                          certificates: templateData
                                                              .certificates
                                                              .map((e) =>
                                                                  e.copyWith(
                                                                      issuedDate:
                                                                          value))
                                                              .toList(),
                                                        );
                                                      });
                                                    },
                                                    controller:
                                                        issuedDateController[
                                                            index],
                                                    style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Colors.grey,
                                                      fontSize: 8.sp,
                                                    ),
                                                    decoration:
                                                        const InputDecoration(
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.zero,
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            _borderColorForCertificate[index]
                                                ? Positioned(
                                                    top: 0,
                                                    right: 0,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2.r),
                                                              ),
                                                              height: 17.h,
                                                              width: 17.w,
                                                              child: Icon(
                                                                Icons
                                                                    .arrow_downward_rounded,
                                                                color: Colors
                                                                    .white,
                                                                size: 15.r,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 2.w,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  _addCertificateEntry(
                                                                      certificate:
                                                                          templateData
                                                                              .certificates[index]);

                                                                  templateData
                                                                      .certificates
                                                                      .insert(
                                                                          index,
                                                                          templateData
                                                                              .certificates
                                                                              .elementAt(index));
                                                                });
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .grey,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              2.r),
                                                                ),
                                                                height: 17.h,
                                                                width: 17.w,
                                                                child: Icon(
                                                                  Icons.copy,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 15.r,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 2.r,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  templateData = templateData.copyWith(
                                                                      certificates: List.from(
                                                                          templateData
                                                                              .certificates)
                                                                        ..removeAt(
                                                                            index));
                                                                });
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .red,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              2.r),
                                                                ),
                                                                height: 17.h,
                                                                width: 17.w,
                                                                child: Icon(
                                                                  Icons
                                                                      .delete_forever_rounded,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 15.sp,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 2.w,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 3.h),
                                                      ],
                                                    ),
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ],
                        ),
                        SizedBox(height: 10.h),

                        // AWARDS SECTION
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 20.h,
                                  width: 20.w,
                                  child: Center(
                                      child: Image.asset(
                                          'assets/Icons/priority.png',
                                          height: 20.h,
                                          width: 20.w)),
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  'AWARDS',
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 244, 102, 102),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ],
                            ),
                            templateData.awards.isEmpty
                                ? Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: 100.h,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 73, 150, 159)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          'No Awards provided',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 8.sp,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              templateData =
                                                  templateData.copyWith(
                                                awards: [
                                                  const AwardModel(
                                                      awardName: 'Award Name',
                                                      issuedDate:
                                                          'Issued date'),
                                                ],
                                              );
                                              _addAwardEntry(
                                                  award:
                                                      templateData.awards[0]);
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                              border: Border.all(
                                                  color: const Color.fromARGB(
                                                      255, 73, 150, 159)),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(2.0.r),
                                              child: Text(
                                                'Add Award',
                                                style: TextStyle(
                                                    fontSize: 8.sp,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: templateData.awards.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: _borderColorForAward[index]
                                                ? const Color.fromARGB(
                                                    255, 73, 150, 159)
                                                : Colors.white,
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 5.h,
                                                ),

                                                // AWARD NAME
                                                TextField(
                                                  maxLines: null,
                                                  onTap: () {
                                                    setState(() {
                                                      _borderColorForAward[
                                                              index] =
                                                          !_borderColorForAward[
                                                              index];
                                                    });
                                                  },
                                                  onTapOutside: (event) {
                                                    setState(() {});
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                  },
                                                  onChanged: (value) {
                                                    setState(() {
                                                      templateData =
                                                          templateData.copyWith(
                                                        awards: templateData
                                                            .awards
                                                            .map((e) =>
                                                                e.copyWith(
                                                                    awardName:
                                                                        value))
                                                            .toList(),
                                                      );
                                                    });
                                                  },
                                                  controller:
                                                      awardNameController[
                                                          index],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  decoration:
                                                      const InputDecoration(
                                                    isDense: true,
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    border: InputBorder.none,
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.zero,
                                                      borderSide: BorderSide(
                                                          color: Colors.green),
                                                    ),
                                                  ),
                                                ),

                                                // ISSUED DATE
                                                SizedBox(
                                                  child: TextField(
                                                    maxLines: null,
                                                    onTap: () {
                                                      setState(() {
                                                        _borderColorForAward[
                                                                index] =
                                                            !_borderColorForAward[
                                                                index];
                                                      });
                                                    },
                                                    onTapOutside: (event) {
                                                      setState(() {});
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                    },
                                                    onChanged: (value) {
                                                      setState(() {
                                                        templateData =
                                                            templateData
                                                                .copyWith(
                                                          awards: templateData
                                                              .awards
                                                              .map((e) =>
                                                                  e.copyWith(
                                                                      issuedDate:
                                                                          value))
                                                              .toList(),
                                                        );
                                                      });
                                                    },
                                                    controller:
                                                        awardIssuedDateController[
                                                            index],
                                                    style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Colors.grey,
                                                      fontSize: 8.sp,
                                                    ),
                                                    decoration:
                                                        const InputDecoration(
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.zero,
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            _borderColorForAward[index]
                                                ? Positioned(
                                                    top: 0,
                                                    right: 0,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2.r),
                                                              ),
                                                              height: 17.h,
                                                              width: 17.w,
                                                              child: Icon(
                                                                Icons
                                                                    .arrow_downward_rounded,
                                                                color: Colors
                                                                    .white,
                                                                size: 15.r,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 2.w,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  _addAwardEntry(
                                                                      award: templateData
                                                                              .awards[
                                                                          index]);

                                                                  templateData.awards.insert(
                                                                      index,
                                                                      templateData
                                                                          .awards
                                                                          .elementAt(
                                                                              index));
                                                                });
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .grey,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              2.r),
                                                                ),
                                                                height: 17.h,
                                                                width: 17.w,
                                                                child: Icon(
                                                                  Icons.copy,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 15.r,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 2.w,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  templateData = templateData.copyWith(
                                                                      awards: List.from(
                                                                          templateData
                                                                              .awards)
                                                                        ..removeAt(
                                                                            index));
                                                                });
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .red,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              2.r),
                                                                ),
                                                                height: 17.h,
                                                                width: 17.w,
                                                                child: Icon(
                                                                  Icons
                                                                      .delete_forever_rounded,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 15.r,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 2.w,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 3.h),
                                                      ],
                                                    ),
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ],
                        ),
                        SizedBox(height: 10.h),

                        // LANGUAGE SECTION
                        _borderColorForLanguage
                            ? Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: _borderColorForLanguage
                                        ? const Color.fromARGB(
                                            255, 73, 150, 159)
                                        : Colors.white,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 20.h,
                                              width: 20.h,
                                              child: Center(
                                                  child: Image.asset(
                                                      'assets/Icons/priority.png',
                                                      height: 20.h,
                                                      width: 20.w)),
                                            ),
                                            SizedBox(width: 5.w),
                                            Text(
                                              'LANGUAGES',
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 244, 102, 102),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _borderColorForLanguage =
                                                  !_borderColorForLanguage;
                                            });
                                          },
                                          child: Wrap(
                                              spacing: 4.r,
                                              children: List.generate(
                                                templateData.languages.length,
                                                (index) {
                                                  return IntrinsicWidth(
                                                    child: Container(
                                                      height: 20.h,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5.w,
                                                              vertical: 2.h),
                                                      margin: EdgeInsets.only(
                                                          right: 4.w,
                                                          bottom: 4.h),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey),
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.r)),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            templateData
                                                                .languages[
                                                                    index]
                                                                .language,
                                                            style: TextStyle(
                                                              fontSize: 10.sp,
                                                            ),
                                                          ),
                                                          SizedBox(width: 5.sp),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                templateData = templateData.copyWith(
                                                                    languages: List.from(
                                                                        templateData
                                                                            .languages)
                                                                      ..removeAt(
                                                                          index));
                                                              });
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .grey
                                                                    .shade400,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4.r),
                                                              ),
                                                              child: Icon(
                                                                Icons.close,
                                                                size: 10.r,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              )),
                                        ),
                                      ],
                                    ),
                                    _borderColorForLanguage
                                        ? Positioned(
                                            top: 2.h,
                                            right: 2.w,
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () => _showMyDialog(
                                                      title: 'Add Language',
                                                      type: 'language'),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2.r),
                                                    ),
                                                    height: 20.h,
                                                    width: 20.w,
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                      size: 15.sp,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _borderColorForLanguage =
                                        !_borderColorForLanguage;
                                  });
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 20.h,
                                          width: 20.w,
                                          child: Center(
                                              child: Image.asset(
                                                  'assets/Icons/priority.png',
                                                  height: 20.h,
                                                  width: 20.w)),
                                        ),
                                        SizedBox(width: 5.w),
                                        Text(
                                          'LANGUAGES',
                                          style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 244, 102, 102),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List.generate(
                                        templateData.languages.length,
                                        (index) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                templateData
                                                    .languages[index].language,
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                              Text(
                                                templateData.languages[index]
                                                    .proficiency,
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.grey),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                        SizedBox(
                          height: 10.h,
                        ),

                        // INTERESTS SECTION
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: _borderColorForInterests
                                      ? const Color.fromARGB(255, 73, 150, 159)
                                      : Colors.white,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 20.h,
                                            width: 20.w,
                                            child: Center(
                                                child: Image.asset(
                                                    'assets/Icons/priority.png',
                                                    height: 20.h,
                                                    width: 20.w)),
                                          ),
                                          SizedBox(width: 5.w),
                                          Text(
                                            'INTERESTS',
                                            style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 244, 102, 102),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      _borderColorForInterests
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _borderColorForInterests =
                                                      !_borderColorForInterests;
                                                });
                                              },
                                              child: Wrap(
                                                spacing: 4.r,
                                                children: List.generate(
                                                  templateData.interests.length,
                                                  (index) {
                                                    return IntrinsicWidth(
                                                      child: Container(
                                                        height: 25.h,
                                                        padding:
                                                            EdgeInsets.all(2.r),
                                                        margin: EdgeInsets.only(
                                                            right: 4.w,
                                                            bottom: 4.h),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: Colors.grey,
                                                          ),
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.r),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              templateData
                                                                      .interests[
                                                                  index],
                                                              style: TextStyle(
                                                                fontSize: 10.sp,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 4.w,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  templateData = templateData.copyWith(
                                                                      interests: List.from(
                                                                          templateData
                                                                              .interests)
                                                                        ..removeAt(
                                                                            index));
                                                                });
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade400,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4.w),
                                                                ),
                                                                child: Icon(
                                                                  Icons.close,
                                                                  size: 10.sp,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _borderColorForInterests =
                                                      !_borderColorForInterests;
                                                });
                                              },
                                              child: GridView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount:
                                                      2, // 2 items per row
                                                  crossAxisSpacing: 1
                                                      .h, // Spacing between columns
                                                  mainAxisSpacing: 1
                                                      .w, // Spacing between rows
                                                  childAspectRatio:
                                                      4, // Adjust this to control the height of the items
                                                ),
                                                itemCount: templateData
                                                    .interests.length,
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5.w,
                                                            vertical: 2.h),
                                                    child: Text(
                                                      templateData
                                                          .interests[index],
                                                      style: TextStyle(
                                                          fontSize: 10.sp),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                    ],
                                  ),
                                  _borderColorForInterests
                                      ? Positioned(
                                          top: 2.h,
                                          right: 2.w,
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () => _showMyDialog(
                                                    title: 'Add Interest',
                                                    type: 'interest'),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.r),
                                                  ),
                                                  height: 20.h,
                                                  width: 20.w,
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 15.r,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 2.w,
            height: MediaQuery.of(context).size.height,
            color: Colors.grey,
          ),

          // RIGHT SIDE OF THE SCREEN
          Padding(
            padding: EdgeInsets.only(left: 10.w, top: 10.h),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .6,
              child: Column(
                children: [
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // FULL NAME
                        TextField(
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          onChanged: (value) {
                            setState(() {
                              templateData = templateData.copyWith(
                                userData: templateData.userData.copyWith(
                                  fullName: value,
                                ),
                              );
                            });
                          },
                          controller: _nameController,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),

                        // PROFESSION
                        TextField(
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          onChanged: (value) {
                            setState(() {
                              templateData = templateData.copyWith(
                                userData: templateData.userData.copyWith(
                                  profession: value,
                                ),
                              );
                            });
                          },
                          controller: _professionController,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 244, 102, 102),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),

                        // BIO
                        TextField(
                          maxLines: null,
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          onChanged: (value) {
                            setState(() {
                              templateData = templateData.copyWith(
                                userData: templateData.userData.copyWith(
                                  bio: value,
                                ),
                              );
                            });
                          },
                          controller: _bioController,
                          style: TextStyle(
                            fontSize: 8.sp,
                          ),
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // EMAIL, ADDRESS, PHONE NUMBER AND LINKEDIN SECTION
                  SizedBox(height: 10.h),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: const Color.fromARGB(255, 244, 102, 102),
                    ),
                    child: Row(
                      children: [
                        // EMAIL, ADDRESS,
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 3.w, left: 2.w),
                            child: SizedBox(
                              height: 25.h,
                              child: ListView.builder(
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Image.asset(
                                        _iconsList1[index],
                                        height: 10.h,
                                        width: 10.w,
                                      ),
                                      SizedBox(width: 5.w),
                                      Expanded(
                                        child: TextField(
                                          onTapOutside: (event) {
                                            FocusScope.of(context).unfocus();
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              if (index == 0) {
                                                templateData =
                                                    templateData.copyWith(
                                                  userData: templateData
                                                      .userData
                                                      .copyWith(
                                                    email: value,
                                                  ),
                                                );
                                              } else if (index == 1) {
                                                templateData =
                                                    templateData.copyWith(
                                                  userData: templateData
                                                      .userData
                                                      .copyWith(
                                                    address: value,
                                                  ),
                                                );
                                              }
                                            });
                                          },
                                          controller: _controllersList1[index],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 9.sp,
                                          ),
                                          decoration: const InputDecoration(
                                            isDense: true,
                                            contentPadding: EdgeInsets.zero,
                                            border: InputBorder.none,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        // PHONE NUMBER AND LINKEDIN
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 3.w, left: 2.w),
                            child: SizedBox(
                              height: 25.h,
                              child: ListView.builder(
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Image.asset(
                                        _iconsList1[index + 2],
                                        height: 10.h,
                                        width: 10.w,
                                      ),
                                      SizedBox(width: 5.w),
                                      Expanded(
                                        child: TextField(
                                          onTapOutside: (event) {
                                            FocusScope.of(context).unfocus();
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              if (index == 0) {
                                                templateData =
                                                    templateData.copyWith(
                                                  userData: templateData
                                                      .userData
                                                      .copyWith(
                                                    phoneNumber: value,
                                                  ),
                                                );
                                              } else if (index == 1) {
                                                templateData =
                                                    templateData.copyWith(
                                                  userData: templateData
                                                      .userData
                                                      .copyWith(
                                                    linkedIn: value,
                                                  ),
                                                );
                                              }
                                            });
                                          },
                                          controller:
                                              _controllersList1[index + 2],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 9.sp,
                                          ),
                                          decoration: const InputDecoration(
                                            isDense: true,
                                            contentPadding: EdgeInsets.zero,
                                            border: InputBorder.none,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Container(
                      padding: EdgeInsets.only(right: 10.w, top: 10.h),
                      child: Column(
                        children: [
                          // WORK EXPERIENCE SECTION
                          Column(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  templateData.workExperience.isEmpty
                                      ? Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: 100.h,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 73, 150, 159)),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text(
                                                'No Work Experience provided',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 8.sp,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    templateData =
                                                        templateData.copyWith(
                                                      workExperience: [
                                                        WorkExperience(
                                                          jobTitle:
                                                              'Flutter Developer',
                                                          companyName:
                                                              'Hex-labs',
                                                          startDate:
                                                              '29/08/2023',
                                                          endDate: '04/09/2024',
                                                          jobType: 'Remote',
                                                          achievements: [
                                                            'Implemented Payment Gateway Transition: Successfully facilitated the transition from Telebirr to Chapa as the payment gateway, streamlining transaction processes and enhancing payment reliability.',
                                                          ],
                                                        )
                                                      ],
                                                    );
                                                    _addWorkExperienceEntry(
                                                        work: templateData
                                                            .workExperience[0]);
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.r),
                                                    border: Border.all(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 73, 150, 159)),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(2.0.r),
                                                    child: Text(
                                                      'Add Work Experience',
                                                      style: TextStyle(
                                                          fontSize: 8.sp,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: templateData
                                              .workExperience.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: _borderColorForWorkExp[
                                                          index]
                                                      ? const Color.fromARGB(
                                                          255, 73, 150, 159)
                                                      : Colors.white,
                                                ),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      index == 0
                                                          ? Row(
                                                              children: [
                                                                SizedBox(
                                                                  height: 20.h,
                                                                  width: 20.w,
                                                                  child: Center(
                                                                      child: Image.asset(
                                                                          'assets/Icons/priority.png',
                                                                          height: 20
                                                                              .h,
                                                                          width:
                                                                              20.w)),
                                                                ),
                                                                SizedBox(
                                                                    width: 5.w),
                                                                Text(
                                                                  'WORK EXPERIENCE',
                                                                  style:
                                                                      TextStyle(
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        244,
                                                                        102,
                                                                        102),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15.sp,
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : const SizedBox(),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),

                                                      // Work experience Job title
                                                      TextField(
                                                        onTap: () {
                                                          setState(() {
                                                            _borderColorForWorkExp[
                                                                    index] =
                                                                !_borderColorForWorkExp[
                                                                    index];
                                                          });
                                                        },
                                                        onTapOutside: (event) {
                                                          setState(() {});
                                                          FocusScope.of(context)
                                                              .unfocus();
                                                        },
                                                        onChanged: (value) {
                                                          setState(() {
                                                            templateData = templateData.copyWith(
                                                                workExperience: templateData
                                                                    .workExperience
                                                                    .map((e) => e.copyWith(
                                                                        jobTitle:
                                                                            value))
                                                                    .toList());
                                                          });
                                                        },
                                                        controller:
                                                            jobTitleControllers[
                                                                index],
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        decoration:
                                                            const InputDecoration(
                                                          isDense: true,
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          border:
                                                              InputBorder.none,
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .zero,
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .green),
                                                          ),
                                                        ),
                                                      ),

                                                      // work experience company name
                                                      TextField(
                                                        maxLines: null,
                                                        onTap: () {
                                                          setState(() {
                                                            _borderColorForWorkExp[
                                                                    index] =
                                                                !_borderColorForWorkExp[
                                                                    index];
                                                          });
                                                        },
                                                        onTapOutside: (event) {
                                                          setState(() {});
                                                          FocusScope.of(context)
                                                              .unfocus();
                                                        },
                                                        onChanged: (value) {
                                                          setState(() {
                                                            templateData = templateData.copyWith(
                                                                workExperience: templateData
                                                                    .workExperience
                                                                    .map((e) => e.copyWith(
                                                                        companyName:
                                                                            value))
                                                                    .toList());
                                                          });
                                                        },
                                                        controller:
                                                            companyNameControllers[
                                                                index],
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 8.sp,
                                                        ),
                                                        decoration:
                                                            const InputDecoration(
                                                          isDense: true,
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          border:
                                                              InputBorder.none,
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .zero,
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .green),
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.22,
                                                            child: TextField(
                                                              onTap: () {
                                                                setState(() {
                                                                  _borderColorForWorkExp[
                                                                          index] =
                                                                      !_borderColorForWorkExp[
                                                                          index];
                                                                });
                                                              },
                                                              onTapOutside:
                                                                  (event) {
                                                                setState(() {});
                                                                FocusScope.of(
                                                                        context)
                                                                    .unfocus();
                                                              },
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  templateData = templateData.copyWith(
                                                                      workExperience: templateData
                                                                          .workExperience
                                                                          .map((e) =>
                                                                              e.copyWith(startDate: value))
                                                                          .toList());
                                                                });
                                                              },
                                                              controller:
                                                                  workEndDateControllers[
                                                                      index],
                                                              style: TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    244,
                                                                    102,
                                                                    102),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 8.sp,
                                                              ),
                                                              decoration:
                                                                  const InputDecoration(
                                                                isDense: true,
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .zero,
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.green),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.15,
                                                            child: TextField(
                                                              onTap: () {
                                                                setState(() {
                                                                  _borderColorForWorkExp[
                                                                          index] =
                                                                      !_borderColorForWorkExp[
                                                                          index];
                                                                });
                                                              },
                                                              onTapOutside:
                                                                  (event) {
                                                                setState(() {});
                                                                FocusScope.of(
                                                                        context)
                                                                    .unfocus();
                                                              },
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  templateData = templateData.copyWith(
                                                                      workExperience: templateData
                                                                          .workExperience
                                                                          .map((e) =>
                                                                              e.copyWith(jobType: value))
                                                                          .toList());
                                                                });
                                                              },
                                                              controller:
                                                                  jobTypeControllers[
                                                                      index],
                                                              style: TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    244,
                                                                    102,
                                                                    102),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 8.sp,
                                                              ),
                                                              decoration:
                                                                  const InputDecoration(
                                                                isDense: true,
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .zero,
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Colors.green),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        'Achievements',
                                                        style: TextStyle(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              244, 102, 102),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 8.sp,
                                                        ),
                                                      ),
                                                      Column(
                                                        children: List.generate(
                                                          templateData
                                                              .workExperience[
                                                                  index]
                                                              .achievements
                                                              .length,
                                                          (innerIndex) {
                                                            return Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  '-',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        8.sp,
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        244,
                                                                        102,
                                                                        102),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.39,
                                                                  child:
                                                                      TextField(
                                                                    maxLines:
                                                                        null,
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        _borderColorForWorkExp[index] =
                                                                            !_borderColorForWorkExp[index];
                                                                      });
                                                                    },
                                                                    onTapOutside:
                                                                        (event) {
                                                                      setState(
                                                                          () {});
                                                                      FocusScope.of(
                                                                              context)
                                                                          .unfocus();
                                                                    },
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        templateData =
                                                                            templateData.copyWith(
                                                                          workExperience: templateData
                                                                              .workExperience
                                                                              .map((e) => e.copyWith(
                                                                                    achievements: e.achievements.asMap().map((i, c) => MapEntry(i, i == innerIndex ? value : c)).values.toList().toList(),
                                                                                  ))
                                                                              .toList(),
                                                                        );
                                                                      });
                                                                    },
                                                                    controller:
                                                                        achievementsControllers[index]
                                                                            [
                                                                            innerIndex],
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          8.sp,
                                                                    ),
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      isDense:
                                                                          true,
                                                                      contentPadding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      border: InputBorder
                                                                          .none,
                                                                      focusedBorder:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.zero,
                                                                        borderSide:
                                                                            BorderSide(color: Colors.green),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  _borderColorForWorkExp[index]
                                                      ? Positioned(
                                                          top: 0,
                                                          right: 0,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .green,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              2.r),
                                                                    ),
                                                                    height:
                                                                        17.h,
                                                                    width: 17.w,
                                                                    child: Icon(
                                                                      Icons
                                                                          .arrow_downward_rounded,
                                                                      color: Colors
                                                                          .white,
                                                                      size:
                                                                          15.r,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 3.w,
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        _addWorkExperienceEntry(
                                                                            work:
                                                                                templateData.workExperience[index]);

                                                                        templateData.workExperience.insert(
                                                                            index,
                                                                            templateData.workExperience.elementAt(index));
                                                                      });
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .grey,
                                                                        borderRadius:
                                                                            BorderRadius.circular(2.r),
                                                                      ),
                                                                      height:
                                                                          17.h,
                                                                      width:
                                                                          17.w,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .copy,
                                                                        color: Colors
                                                                            .white,
                                                                        size: 15
                                                                            .r,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 3.w,
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        templateData = templateData.copyWith(
                                                                            workExperience: List.from(templateData.workExperience)
                                                                              ..removeAt(index));
                                                                      });
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .red,
                                                                        borderRadius:
                                                                            BorderRadius.circular(2.r),
                                                                      ),
                                                                      height:
                                                                          17.h,
                                                                      width:
                                                                          17.w,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .delete_forever_rounded,
                                                                        color: Colors
                                                                            .white,
                                                                        size: 15
                                                                            .r,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 2.w,
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        _showAddAchievementOnly[index] =
                                                                            !_showAddAchievementOnly[index];
                                                                      });
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .grey,
                                                                        borderRadius:
                                                                            BorderRadius.circular(2.r),
                                                                      ),
                                                                      height:
                                                                          17.h,
                                                                      width:
                                                                          17.w,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .more_vert,
                                                                        color: Colors
                                                                            .white,
                                                                        size: 15
                                                                            .r,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                  height: 3.h),
                                                              _showAddAchievementOnly[
                                                                      index]
                                                                  ? GestureDetector(
                                                                      onTap: () =>
                                                                          _addAchievement(
                                                                              index: index),
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.grey,
                                                                          borderRadius:
                                                                              BorderRadius.circular(2.r),
                                                                        ),
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.2,
                                                                        height:
                                                                            17.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            'Add Achievement',
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontSize: 10.sp),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : const SizedBox(),
                                                            ],
                                                          ),
                                                        )
                                                      : const SizedBox(),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          // EDUCATION SECTION
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              templateData.educationBackground.isEmpty
                                  ? Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      height: 100.h,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 73, 150, 159)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            'No education background provided',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 8.sp,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.sp,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                templateData =
                                                    templateData.copyWith(
                                                  educationBackground: [
                                                    EducationBackground(
                                                      fieldOfStudy:
                                                          'Software Engineering',
                                                      institutionName: 'AASTU',
                                                      startDate: '02/08/2021',
                                                      endDate: '02/08/2026',
                                                      institutionAddress:
                                                          'Addis Ababa',
                                                      courses: [
                                                        'Data Structures',
                                                        'Algorithms',
                                                        'Software Engineering',
                                                        'Project Management',
                                                      ],
                                                    )
                                                  ],
                                                );
                                                _addEducationEntry(
                                                    edu: templateData
                                                        .educationBackground[0]);
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.r),
                                                border: Border.all(
                                                    color: const Color.fromARGB(
                                                        255, 73, 150, 159)),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(2.0.r),
                                                child: Text(
                                                  'Add Education',
                                                  style: TextStyle(
                                                      fontSize: 8.sp,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: templateData
                                          .educationBackground.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: _borderColorForEdu[index]
                                                  ? const Color.fromARGB(
                                                      255, 73, 150, 159)
                                                  : Colors.white,
                                            ),
                                          ),
                                          child: Stack(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  index == 0
                                                      ? Row(
                                                          children: [
                                                            SizedBox(
                                                              height: 20.h,
                                                              width: 20.w,
                                                              child: Center(
                                                                  child: Image.asset(
                                                                      'assets/Icons/priority.png',
                                                                      height:
                                                                          20.h,
                                                                      width: 20
                                                                          .w)),
                                                            ),
                                                            SizedBox(
                                                                width: 5.w),
                                                            Text(
                                                              'EDUCATION',
                                                              style: TextStyle(
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    244,
                                                                    102,
                                                                    102),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15.sp,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : const SizedBox(),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),

                                                  // FIELD OF STUDY
                                                  TextField(
                                                    maxLines: null,
                                                    onTap: () {
                                                      setState(() {
                                                        _borderColorForEdu[
                                                                index] =
                                                            !_borderColorForEdu[
                                                                index];
                                                      });
                                                    },
                                                    onTapOutside: (event) {
                                                      setState(() {});
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                    },
                                                    onChanged: (value) {
                                                      setState(() {
                                                        templateData =
                                                            templateData
                                                                .copyWith(
                                                          educationBackground: templateData
                                                              .educationBackground
                                                              .map((e) =>
                                                                  e.copyWith(
                                                                      fieldOfStudy:
                                                                          value))
                                                              .toList(),
                                                        );
                                                      });
                                                    },
                                                    controller:
                                                        fieldOfStudyControllers[
                                                            index],
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    decoration:
                                                        const InputDecoration(
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.zero,
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ),
                                                  ),

                                                  // INSTITUTION NAME
                                                  TextField(
                                                    maxLines: null,
                                                    onTap: () {
                                                      setState(() {
                                                        _borderColorForEdu[
                                                                index] =
                                                            !_borderColorForEdu[
                                                                index];
                                                      });
                                                    },
                                                    onTapOutside: (event) {
                                                      setState(() {});
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                    },
                                                    onChanged: (value) {
                                                      setState(() {
                                                        templateData =
                                                            templateData
                                                                .copyWith(
                                                          educationBackground: templateData
                                                              .educationBackground
                                                              .map((e) => e.copyWith(
                                                                  institutionName:
                                                                      value))
                                                              .toList(),
                                                        );
                                                      });
                                                    },
                                                    controller:
                                                        institutionAddressControllers[
                                                            index],
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 8.sp,
                                                    ),
                                                    decoration:
                                                        const InputDecoration(
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.zero,
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.22,
                                                        child: TextField(
                                                          onTap: () {
                                                            setState(() {
                                                              _borderColorForEdu[
                                                                      index] =
                                                                  !_borderColorForEdu[
                                                                      index];
                                                            });
                                                          },
                                                          onTapOutside:
                                                              (event) {
                                                            setState(() {});
                                                            FocusScope.of(
                                                                    context)
                                                                .unfocus();
                                                          },
                                                          onChanged: (value) {
                                                            setState(() {
                                                              templateData =
                                                                  templateData
                                                                      .copyWith(
                                                                educationBackground: templateData
                                                                    .educationBackground
                                                                    .map((e) => e.copyWith(
                                                                        startDate:
                                                                            value))
                                                                    .toList(),
                                                              );
                                                            });
                                                          },
                                                          controller:
                                                              startDateControllers[
                                                                  index],
                                                          style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            color: const Color
                                                                .fromARGB(255,
                                                                244, 102, 102),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 8.sp,
                                                          ),
                                                          decoration:
                                                              const InputDecoration(
                                                            isDense: true,
                                                            contentPadding:
                                                                EdgeInsets.zero,
                                                            border: InputBorder
                                                                .none,
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .zero,
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .green),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.15,
                                                        child: TextField(
                                                          onTap: () {
                                                            setState(() {
                                                              _borderColorForEdu[
                                                                      index] =
                                                                  !_borderColorForEdu[
                                                                      index];
                                                            });
                                                          },
                                                          onTapOutside:
                                                              (event) {
                                                            setState(() {});
                                                            FocusScope.of(
                                                                    context)
                                                                .unfocus();
                                                          },
                                                          onChanged: (value) {
                                                            setState(() {
                                                              templateData =
                                                                  templateData
                                                                      .copyWith(
                                                                educationBackground: templateData
                                                                    .educationBackground
                                                                    .map((e) => e.copyWith(
                                                                        institutionAddress:
                                                                            value))
                                                                    .toList(),
                                                              );
                                                            });
                                                          },
                                                          controller:
                                                              institutionAddressControllers[
                                                                  index],
                                                          style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            color: const Color
                                                                .fromARGB(255,
                                                                244, 102, 102),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 8.sp,
                                                          ),
                                                          decoration:
                                                              const InputDecoration(
                                                            isDense: true,
                                                            contentPadding:
                                                                EdgeInsets.zero,
                                                            border: InputBorder
                                                                .none,
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .zero,
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .green),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              _borderColorForEdu[index]
                                                  ? Positioned(
                                                      top: 0,
                                                      right: 0,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .green,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              2.r),
                                                                ),
                                                                height: 17.h,
                                                                width: 17.w,
                                                                child: Icon(
                                                                  Icons
                                                                      .arrow_downward_rounded,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 15.r,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 2.w,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    _addEducationEntry(
                                                                        edu: templateData
                                                                            .educationBackground[index]);

                                                                    templateData
                                                                        .educationBackground
                                                                        .insert(
                                                                            index,
                                                                            templateData.educationBackground.elementAt(index));
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .grey,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            2.r),
                                                                  ),
                                                                  height: 17.h,
                                                                  width: 17.w,
                                                                  child: Icon(
                                                                    Icons.copy,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 15.r,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 2.w,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    templateData = templateData.copyWith(
                                                                        educationBackground: List.from(templateData
                                                                            .educationBackground)
                                                                          ..removeAt(
                                                                              index));
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .red,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            2.r),
                                                                  ),
                                                                  height: 17.h,
                                                                  width: 17.w,
                                                                  child: Icon(
                                                                    Icons
                                                                        .delete_forever_rounded,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 15.r,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 2.w,
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 3.h),
                                                        ],
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
