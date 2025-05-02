import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_resume/core/utils/custom_dialog.dart';
import 'package:my_resume/features/profile/data/model/project_model.dart';
import 'package:my_resume/features/resume/data/model/education_model.dart';
import 'package:my_resume/features/resume/data/model/language_model.dart';
import 'package:my_resume/features/resume/data/model/templates_model.dart';
import 'package:my_resume/features/resume/data/model/work_experience_model.dart';

class NeatTemplate extends StatefulWidget {
  TemplateModel templateData;
  NeatTemplate({super.key, required this.templateData});

  @override
  State<NeatTemplate> createState() => NeatTemplateState();
}

class NeatTemplateState extends State<NeatTemplate> {
  late TemplateModel templateData;

  List<File> icons = [
    File('assets/Icons/mail.png'),
    File('assets/Icons/pin.png'),
    File('assets/Icons/linkedin.png'),
    File('assets/Icons/telephone.png'),
    File('assets/Icons/github.png'),
    File('assets/Icons/internet.png'),
  ];

  final List _iconsList1 = [
    'assets/Icons/mail.png',
    'assets/Icons/pin.png',
    'assets/Icons/linkedin.png',
  ];

  final List _iconsList2 = [
    'assets/Icons/telephone.png',
    'assets/Icons/github.png',
    'assets/Icons/internet.png',
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _linkedInController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();

  List<TextEditingController> fieldOfStudyControllers = [];
  List<TextEditingController> institutionNameControllers = [];
  List<TextEditingController> startDateControllers = [];
  List<TextEditingController> endDateControllers = [];
  List<TextEditingController> institutionAddressControllers = [];
  List<List<TextEditingController>> coursesControllers = [];

  List<TextEditingController> jobTitleControllers = [];
  List<TextEditingController> companyNameControllers = [];
  List<TextEditingController> workStartDateControllers = [];
  List<TextEditingController> workEndDateControllers = [];
  List<TextEditingController> jobTypeControllers = [];
  List<List<TextEditingController>> achievementsControllers = [];

  final TextEditingController _addSkillController = TextEditingController();
  final TextEditingController _addPersonalProjectController =
      TextEditingController();
  final TextEditingController _addLanguageControllerForLanguageName =
      TextEditingController();
  final TextEditingController _addInterestsController = TextEditingController();

  List<bool> _borderColorForEdu = [];
  List<bool> _borderColorForWorkExp = [];

  bool _borderColorForSkills = false;
  bool _borderColorForPersonalProjects = false;
  bool _borderColorForLanguage = false;
  bool _borderColorForInterests = false;

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

  // Personal info controllers list
  List _controllersList1 = [];
  List _controllersList2 = [];

  // Item count for personal info
  int _itemCount() {
    if (templateData.userData.github != null &&
        templateData.userData.website != null) {
      return 3;
    } else if (templateData.userData.github != null ||
        templateData.userData.website != null) {
      return 2;
    } else {
      return 1;
    }
  }

  List<bool> _showAddCourseOnly = [];
  List<bool> _showAddAchievementOnly = [];
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

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String dropDownValue = proficiencyList[0]; // Initial dropdown value

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return DialogUtils.buildDialog(
              context: context,
              title: title,
              content: [
                if (type == 'language') ...[
                  DialogUtils.styledTextField(
                    context: context,
                    controller: _addLanguageControllerForLanguageName,
                    hintText: 'Language',
                    onChanged: (val) {
                      _addLanguageControllerForLanguageName.text = val;
                    },
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
                            value: dropDownValue,
                            isExpanded: true,
                            items: proficiencyList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.sp,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setDialogState(() {
                                dropDownValue = newValue!;
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
                ] else
                  DialogUtils.styledTextField(
                    context: context,
                    controller: title == 'Add Skill'
                        ? _addSkillController
                        : title == 'Add Personal Project'
                            ? _addPersonalProjectController
                            : _addInterestsController,
                    hintText: title,
                    onChanged: (val) {
                      final controller = title == 'Add Skill'
                          ? _addSkillController
                          : title == 'Add Personal Project'
                              ? _addPersonalProjectController
                              : _addInterestsController;
                      controller.text = val;
                    },
                  ),
              ],
              actions: DialogUtils.dialogActions(
                context: context,
                onSave: () {
                  setState(() {
                    if (title == 'Add Skill') {
                      templateData.skills.add(_addSkillController.text);
                      _addSkillController.clear();
                    } else if (title == 'Add Personal Project') {
                      templateData.personalProjects.add(
                        ProjectModel(
                          name: _addPersonalProjectController.text,
                          description: 'description',
                        ),
                      );
                      _addPersonalProjectController.clear();
                    } else if (title == 'Add Interest') {
                      templateData.interests.add(_addInterestsController.text);
                      _addInterestsController.clear();
                    } else {
                      templateData.languages.add(
                        LanguageModel(
                          language: _addLanguageControllerForLanguageName.text,
                          proficiency: dropDownValue,
                        ),
                      );
                      _addLanguageControllerForLanguageName.clear();
                    }
                  });
                  Navigator.of(context).pop();
                },
                onCancel: () {
                  Navigator.of(context).pop();
                },
              ),
            );
          },
        );
      },
    );
  }

  void _addCourse({required int index}) {
    setState(() {
      List<EducationBackground> updatedEducation =
          List.from(templateData.educationBackground);
      updatedEducation[index] = updatedEducation[index].copyWith(
        courses: List.from(updatedEducation[index].courses)..add('course'),
      );

      templateData =
          templateData.copyWith(educationBackground: updatedEducation);

      coursesControllers[index].add(TextEditingController(text: 'course'));
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

      List<TextEditingController> courseControllers = [];
      for (var courses in edu.courses) {
        courseControllers.add(TextEditingController(text: courses));
      }
      coursesControllers.add(courseControllers);
      _borderColorForEdu.add(false);
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

  void _initializeControllers({required TemplateModel templateData}) {
    // User controllers
    _nameController.text = templateData.userData.fullName;
    _professionController.text = templateData.userData.profession;
    _bioController.text = templateData.userData.bio;
    _emailController.text = templateData.userData.email;
    _addressController.text = templateData.userData.address;
    _linkedInController.text = templateData.userData.linkedIn!;
    _phoneController.text = templateData.userData.phoneNumber;
    _githubController.text = templateData.userData.github!;
    _websiteController.text = templateData.userData.website!;

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

      // Populate education courses controllers dynamically
      List<TextEditingController> courseControllers = [];
      for (var course in edu.courses) {
        courseControllers.add(TextEditingController(text: course));
      }
      coursesControllers.add(courseControllers);
    }

    for (var work in templateData.workExperience) {
      _borderColorForWorkExp.add(false);
      jobTitleControllers.add(TextEditingController(text: work.jobTitle));
      companyNameControllers.add(TextEditingController(text: work.companyName));
      workStartDateControllers.add(TextEditingController(text: work.startDate));
      workEndDateControllers.add(TextEditingController(text: work.endDate));
      jobTypeControllers.add(TextEditingController(text: work.jobType));

      // Populate work achievements controllers dynamically
      List<TextEditingController> achievementControllers = [];
      for (var achievement in work.achievements) {
        achievementControllers.add(TextEditingController(text: achievement));
      }
      achievementsControllers.add(achievementControllers);
    }
  }

  final Map<String, dynamic> neatColours = {
    'white': Colors.white,
    'black': Colors.black,
    'darkBlue': const Color.fromARGB(255, 49, 60, 75),
    'lightBlue': const Color.fromARGB(255, 73, 150, 159),
    'deepBlue': const Color.fromARGB(255, 34, 42, 51),
    'grey': Colors.grey,
    'greyShade': Colors.grey[400],
  };

  @override
  void initState() {
    templateData = widget.templateData;
    _initializeControllers(templateData: templateData);
    _showAddCourseOnly = List.generate(
        templateData.educationBackground.length, (index) => false);
    _showAddAchievementOnly =
        List.generate(templateData.workExperience.length, (index) => false);

    // Personal info Controllers
    _controllersList1
        .addAll([_emailController, _addressController, _linkedInController, 1]);

    _controllersList2.addAll([
      _phoneController,
      _githubController,
      _websiteController,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: neatColours['white'],
      child: Column(
        children: [
          Container(
            color: neatColours['darkBlue'],
            child: Padding(
              padding: EdgeInsets.only(right: 30.w, left: 20.w, top: 20.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
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
                            color: neatColours['white'],
                            fontSize: 20.sp.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide:
                                  BorderSide(color: neatColours['white']),
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
                            print(templateData.userData.profession);
                          },
                          controller: _professionController,
                          style: TextStyle(
                            color: neatColours['lightBlue'],
                            fontSize: 11.sp,
                            fontWeight: FontWeight.normal,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide:
                                  BorderSide(color: neatColours['white']),
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
                            print(templateData.userData.bio);
                          },
                          controller: _bioController,
                          style: TextStyle(
                            color: neatColours['white'],
                            fontSize: 8.sp,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide:
                                  BorderSide(color: neatColours['white']),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _image == null
                      ? GestureDetector(
                          onTap: () {
                            pickImage();
                          },
                          child: CircleAvatar(
                            radius: 50.r,
                            backgroundColor: neatColours['white'],
                            backgroundImage:
                                File(templateData.userData.profilePic.path)
                                        .existsSync()
                                    ? FileImage(File(widget
                                        .templateData.userData.profilePic.path))
                                    : const AssetImage('assets/copy.jpg')
                                        as ImageProvider,
                          ),
                        )
                      : CircleAvatar(
                          radius: 50.r,
                          backgroundColor: neatColours['white'],
                          backgroundImage: FileImage(_image!),
                        ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              // EMAIL, ADDRESS AND LINKEDIN
              Expanded(
                child: Container(
                  color: neatColours['deepBlue'],
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: 30.w, left: 20.w, top: 10.h, bottom: 10.h),
                    child: SizedBox(
                      height: 30.h,
                      child: ListView.builder(
                        itemCount:
                            templateData.userData.linkedIn != null ? 3 : 2,
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
                                        templateData = templateData.copyWith(
                                          userData:
                                              templateData.userData.copyWith(
                                            email: value,
                                          ),
                                        );
                                      } else if (index == 1) {
                                        templateData = templateData.copyWith(
                                          userData:
                                              templateData.userData.copyWith(
                                            address: value,
                                          ),
                                        );
                                      } else if (index == 2) {
                                        templateData = templateData.copyWith(
                                          userData:
                                              templateData.userData.copyWith(
                                            linkedIn: value,
                                          ),
                                        );
                                      }
                                    });
                                  },
                                  controller: _controllersList1[index],
                                  style: TextStyle(
                                    color: neatColours['white'],
                                    fontSize: 8.sp,
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(
                                          color: neatColours['white']),
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
              ),

              // Phone number, github and website section
              Expanded(
                child: Container(
                  color: neatColours['deepBlue'],
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: 30.w, left: 20.w, top: 10.h, bottom: 10.h),
                    child: SizedBox(
                      height: 30.h,
                      child: ListView.builder(
                        itemCount: _itemCount(),
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Image.asset(
                                _iconsList2[index],
                                height: 10.h,
                                width: 10.w,
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: TextField(
                                  onTapOutside: (event) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      if (index == 0) {
                                        templateData = templateData.copyWith(
                                          userData:
                                              templateData.userData.copyWith(
                                            phoneNumber: value,
                                          ),
                                        );
                                      } else if (index == 1) {
                                        templateData = templateData.copyWith(
                                          userData:
                                              templateData.userData.copyWith(
                                            github: value,
                                          ),
                                        );
                                      } else if (index == 2) {
                                        templateData = templateData.copyWith(
                                          userData:
                                              templateData.userData.copyWith(
                                            website: value,
                                          ),
                                        );
                                      }
                                    });
                                  },
                                  controller: _controllersList2[index],
                                  style: TextStyle(
                                    color: neatColours['white'],
                                    fontSize: 8.sp,
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(
                                          color: neatColours['white']),
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
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 10.w, left: 20.w, top: 10.h),
                  child: Column(
                    children: [
                      // EDUCATIONAL BACKGROUND
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'EDUCATION',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: neatColours['lightBlue'],
                              decorationThickness: 3.r,
                              fontWeight: FontWeight.bold,
                              color: neatColours['lightBlue'],
                              fontSize: 15.sp,
                            ),
                          ),
                          templateData.educationBackground.isEmpty
                              ? Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: 100.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 73, 150, 159)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        'No education background provided',
                                        style: TextStyle(
                                          color: neatColours['grey'],
                                          fontSize: 8,
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
                                                BorderRadius.circular(5),
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
                                                  color: neatColours['black']),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      templateData.educationBackground.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: _borderColorForEdu[index]
                                              ? const Color.fromARGB(
                                                  255, 73, 150, 159)
                                              : neatColours['white'],
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // FIELD OF STUDY
                                              TextField(
                                                onTap: () {
                                                  setState(() {
                                                    _borderColorForEdu[index] =
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
                                                        templateData.copyWith(
                                                      educationBackground:
                                                          templateData
                                                              .educationBackground
                                                              .map((e) =>
                                                                  e.copyWith(
                                                                      fieldOfStudy:
                                                                          value))
                                                              .toList(),
                                                    );
                                                  });
                                                  log(templateData
                                                      .educationBackground
                                                      .toString());
                                                },
                                                controller:
                                                    fieldOfStudyControllers[
                                                        index],
                                                style: TextStyle(
                                                  color: neatColours['black'],
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

                                              // INSTITUTION NAME
                                              TextField(
                                                maxLines: null,
                                                onTap: () {
                                                  setState(() {
                                                    _borderColorForEdu[index] =
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
                                                        templateData.copyWith(
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
                                                  color: neatColours['black'],
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
                                                        color: Colors.green),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
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
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 73, 150, 159),
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
                                                              BorderRadius.zero,
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .green),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
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
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 73, 150, 159),
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
                                                              BorderRadius.zero,
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .green),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                'Courses',
                                                style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: const Color.fromARGB(
                                                      255, 73, 150, 159),
                                                  fontSize: 8.sp,
                                                ),
                                              ),
                                              Column(
                                                children: List.generate(
                                                  templateData
                                                      .educationBackground[
                                                          index]
                                                      .courses
                                                      .length,
                                                  (innerIndex) {
                                                    return SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                      child: TextField(
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
                                                              educationBackground:
                                                                  templateData
                                                                      .educationBackground
                                                                      .map((e) =>
                                                                          e.copyWith(
                                                                            courses:
                                                                                e.courses.asMap().map((i, c) => MapEntry(i, i == innerIndex ? value : c)).values.toList().toList(),
                                                                          ))
                                                                      .toList(),
                                                            );
                                                          });
                                                        },
                                                        controller:
                                                            coursesControllers[
                                                                    index]
                                                                [innerIndex],
                                                        style: TextStyle(
                                                          color: neatColours[
                                                              'black'],
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
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          _borderColorForEdu[index]
                                              ? Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.green,
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
                                                              color:
                                                                  neatColours[
                                                                      'white'],
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
                                                                            .educationBackground[
                                                                        index]);

                                                                templateData
                                                                    .educationBackground
                                                                    .insert(
                                                                        index,
                                                                        templateData
                                                                            .educationBackground
                                                                            .elementAt(index));
                                                              });
                                                              log(templateData
                                                                  .educationBackground
                                                                  .toString());
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    neatColours[
                                                                        'grey'],
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
                                                                    educationBackground: List.from(
                                                                        templateData
                                                                            .educationBackground)
                                                                      ..removeAt(
                                                                          index));
                                                              });
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.red,
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
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                _showAddCourseOnly[
                                                                        index] =
                                                                    !_showAddCourseOnly[
                                                                        index];
                                                              });
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    neatColours[
                                                                        'grey'],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2.r),
                                                              ),
                                                              height: 17.h,
                                                              width: 17.w,
                                                              child: Icon(
                                                                Icons.more_vert,
                                                                color: Colors
                                                                    .white,
                                                                size: 15.r,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 3.h),
                                                      _showAddCourseOnly[index]
                                                          ? GestureDetector(
                                                              onTap: () =>
                                                                  _addCourse(
                                                                      index:
                                                                          index),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .green,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              2.r),
                                                                ),
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.2,
                                                                height: 17.h,
                                                                child: Center(
                                                                  child: Text(
                                                                    'Add Course',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            10.sp),
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
                      SizedBox(height: 10.h),

                      // WORK EXPERIENCE SECTION
                      Column(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'WORK EXPERIENCE',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: neatColours['lightBlue'],
                                  decorationThickness: 3.r,
                                  fontWeight: FontWeight.bold,
                                  color: neatColours['lightBlue'],
                                  fontSize: 15.sp,
                                ),
                              ),
                              templateData.workExperience.isEmpty
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
                                            'No Work Experience provided',
                                            style: TextStyle(
                                              color: neatColours['grey'],
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
                                                      companyName: 'Hex-labs',
                                                      startDate: '29/08/2023',
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
                                                    BorderRadius.circular(5.r),
                                                border: Border.all(
                                                    color: const Color.fromARGB(
                                                        255, 73, 150, 159)),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(2.0.r),
                                                child: Text(
                                                  'Add Work Experience',
                                                  style: TextStyle(
                                                      fontSize: 8.sp,
                                                      color:
                                                          neatColours['black']),
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
                                      itemCount:
                                          templateData.workExperience.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color:
                                                  _borderColorForWorkExp[index]
                                                      ? const Color.fromARGB(
                                                          255, 73, 150, 159)
                                                      : neatColours['white'],
                                            ),
                                          ),
                                          child: Stack(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
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
                                                                .map((e) =>
                                                                    e.copyWith(
                                                                        jobTitle:
                                                                            value))
                                                                .toList());
                                                      });
                                                    },
                                                    controller:
                                                        jobTitleControllers[
                                                            index],
                                                    style: TextStyle(
                                                      color:
                                                          neatColours['black'],
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
                                                      color:
                                                          neatColours['black'],
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
                                                          onChanged: (value) {
                                                            setState(() {
                                                              templateData = templateData.copyWith(
                                                                  workExperience: templateData
                                                                      .workExperience
                                                                      .map((e) =>
                                                                          e.copyWith(
                                                                              startDate: value))
                                                                      .toList());
                                                            });
                                                          },
                                                          controller:
                                                              workEndDateControllers[
                                                                  index],
                                                          style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            color: const Color
                                                                .fromARGB(255,
                                                                73, 150, 159),
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
                                                          onChanged: (value) {
                                                            setState(() {
                                                              templateData = templateData.copyWith(
                                                                  workExperience: templateData
                                                                      .workExperience
                                                                      .map((e) =>
                                                                          e.copyWith(
                                                                              jobType: value))
                                                                      .toList());
                                                            });
                                                          },
                                                          controller:
                                                              jobTypeControllers[
                                                                  index],
                                                          style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            color: const Color
                                                                .fromARGB(255,
                                                                73, 150, 159),
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
                                                  Text(
                                                    'Achievements',
                                                    style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              73,
                                                              150,
                                                              159),
                                                      fontSize: 8.sp,
                                                    ),
                                                  ),
                                                  Column(
                                                    children: List.generate(
                                                      templateData
                                                          .workExperience[index]
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
                                                              style: TextStyle(
                                                                fontSize: 8.sp,
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
                                                              child: TextField(
                                                                maxLines: null,
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
                                                                  setState(
                                                                      () {});
                                                                  FocusScope.of(
                                                                          context)
                                                                      .unfocus();
                                                                },
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    templateData =
                                                                        templateData
                                                                            .copyWith(
                                                                      workExperience: templateData
                                                                          .workExperience
                                                                          .map((e) =>
                                                                              e.copyWith(
                                                                                achievements: e.achievements.asMap().map((i, c) => MapEntry(i, i == innerIndex ? value : c)).values.toList().toList(),
                                                                              ))
                                                                          .toList(),
                                                                    );
                                                                  });
                                                                },
                                                                controller:
                                                                    achievementsControllers[
                                                                            index]
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
                                                                width: 3.w,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    _addWorkExperienceEntry(
                                                                        work: templateData
                                                                            .workExperience[index]);

                                                                    templateData
                                                                        .workExperience
                                                                        .insert(
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
                                                                width: 3.w,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    templateData = templateData.copyWith(
                                                                        workExperience: List.from(templateData
                                                                            .workExperience)
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
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    _showAddAchievementOnly[
                                                                            index] =
                                                                        !_showAddAchievementOnly[
                                                                            index];
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
                                                                    Icons
                                                                        .more_vert,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 15.r,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 3.h),
                                                          _showAddAchievementOnly[
                                                                  index]
                                                              ? GestureDetector(
                                                                  onTap: () =>
                                                                      _addAchievement(
                                                                          index:
                                                                              index),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .green,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              2.r),
                                                                    ),
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.2,
                                                                    height:
                                                                        17.h,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        'Add Achievement',
                                                                        style: TextStyle(
                                                                            color:
                                                                                neatColours['white'],
                                                                            fontSize: 10.sp),
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
                    ],
                  ),
                ),
              ),

              // SKILLS Section
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 20.w, top: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _borderColorForSkills
                                ? neatColours['lightBlue']
                                : neatColours['white'],
                          ),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'SKILLS',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationColor: neatColours['lightBlue'],
                                    decorationThickness: 3.r,
                                    fontWeight: FontWeight.bold,
                                    color: neatColours['lightBlue'],
                                    fontSize: 15.sp,
                                  ),
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
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 73, 150, 159),
                                                      ),
                                                      color:
                                                          neatColours['white'],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.r),
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
                                                              color: neatColours[
                                                                  'greyShade'],
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
                                        child: Wrap(
                                          spacing: 4.r,
                                          children: List.generate(
                                            templateData.skills.length,
                                            (index) {
                                              return Container(
                                                padding: EdgeInsets.all(2.r),
                                                margin: EdgeInsets.only(
                                                    right: 4.w, bottom: 4.h),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: const Color.fromARGB(
                                                        255, 73, 150, 159),
                                                  ),
                                                  color: neatColours['white'],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.r),
                                                ),
                                                child: Text(
                                                  templateData.skills[index],
                                                  style: TextStyle(
                                                    fontSize: 8.sp,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
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
                                                  BorderRadius.circular(2.r),
                                            ),
                                            height: 20.h,
                                            width: 20.w,
                                            child: Icon(
                                              Icons.add,
                                              color: neatColours['white'],
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
                        height: 20.h,
                      ),
                      _borderColorForPersonalProjects
                          ? Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: _borderColorForPersonalProjects
                                      ? neatColours['lightBlue']
                                      : neatColours['white'],
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'PERSONAL PROJECTS',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          decorationColor: const Color.fromARGB(
                                              255, 73, 150, 159),
                                          decorationThickness: 3.r,
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromARGB(
                                              255, 73, 150, 159),
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _borderColorForPersonalProjects =
                                                !_borderColorForPersonalProjects;
                                          });
                                        },
                                        child: Wrap(
                                            spacing: 4.r,
                                            children: List.generate(
                                              templateData
                                                  .personalProjects.length,
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
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 73, 150, 159),
                                                      ),
                                                      color:
                                                          neatColours['white'],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.r),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          templateData
                                                              .personalProjects[
                                                                  index]
                                                              .name,
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
                                                                  personalProjects: List.from(
                                                                      templateData
                                                                          .personalProjects)
                                                                    ..removeAt(
                                                                        index));
                                                            });
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: neatColours[
                                                                  'greyShade'],
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
                                  _borderColorForPersonalProjects
                                      ? Positioned(
                                          top: 2.h,
                                          right: 2.w,
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () => _showMyDialog(
                                                    title:
                                                        'Add Personal Project',
                                                    type: 'personalProjects'),
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
                                                    color: neatColours['white'],
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
                            )
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  _borderColorForPersonalProjects =
                                      !_borderColorForPersonalProjects;
                                });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'PERSONAL PROJECTS',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor: const Color.fromARGB(
                                          255, 73, 150, 159),
                                      decorationThickness: 3.r,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          255, 73, 150, 159),
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(
                                      templateData.personalProjects.length,
                                      (index) {
                                        return Column(
                                          children: [
                                            Text(
                                              templateData
                                                  .personalProjects[index].name,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                              ),
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
                        height: 20.h,
                      ),
                      _borderColorForLanguage
                          ? Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: _borderColorForLanguage
                                      ? neatColours['lightBlue']
                                      : neatColours['white'],
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'LANGUAGES',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          decorationColor: const Color.fromARGB(
                                              255, 73, 150, 159),
                                          decorationThickness: 3.r,
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromARGB(
                                              255, 73, 150, 159),
                                          fontSize: 15.sp,
                                        ),
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
                                                    height: 35.h,
                                                    padding:
                                                        EdgeInsets.all(2.r),
                                                    margin: EdgeInsets.only(
                                                        right: 4.w,
                                                        bottom: 4.h),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 73, 150, 159),
                                                      ),
                                                      color:
                                                          neatColours['white'],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.r),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
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
                                                            SizedBox(
                                                              height: 4.h,
                                                            ),
                                                            Text(
                                                              templateData
                                                                  .languages[
                                                                      index]
                                                                  .proficiency,
                                                              style: TextStyle(
                                                                fontSize: 10.sp,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
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
                                                              color: neatColours[
                                                                  'greyShade'],
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
                                                    color: neatColours['white'],
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
                                  Text(
                                    'Languages',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor: const Color.fromARGB(
                                          255, 73, 150, 159),
                                      decorationThickness: 3.r,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          255, 73, 150, 159),
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
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
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              templateData
                                                  .languages[index].proficiency,
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                              ),
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
                        height: 20.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: _borderColorForInterests
                                    ? neatColours['lightBlue']
                                    : neatColours['white'],
                              ),
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'INTERESTS',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        decorationColor: const Color.fromARGB(
                                            255, 73, 150, 159),
                                        decorationThickness: 3.r,
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromARGB(
                                            255, 73, 150, 159),
                                        fontSize: 15.sp,
                                      ),
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
                                                      padding:
                                                          EdgeInsets.all(2.r),
                                                      margin: EdgeInsets.only(
                                                          right: 4.w,
                                                          bottom: 4.h),
                                                      decoration: BoxDecoration(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 73, 150, 159),
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
                                                                    .interests[
                                                                index],
                                                            style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color:
                                                                  neatColours[
                                                                      'white'],
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
                                                                color: neatColours[
                                                                    'greyShade'],
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
                                            child: Wrap(
                                              spacing: 4.r,
                                              children: List.generate(
                                                templateData.interests.length,
                                                (index) {
                                                  return Container(
                                                    padding:
                                                        EdgeInsets.all(2.r),
                                                    margin: EdgeInsets.only(
                                                        right: 4.w,
                                                        bottom: 4.h),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              73,
                                                              150,
                                                              159),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.r),
                                                    ),
                                                    child: Text(
                                                      templateData
                                                          .interests[index],
                                                      style: TextStyle(
                                                        fontSize: 8.sp,
                                                        color: neatColours[
                                                            'white'],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
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
                                                  color: neatColours['white'],
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
              ),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Card(
              color: Colors.amber,
              child: Padding(
                padding: EdgeInsets.all(8.0.r),
                child: Text(
                  'Tap on any section to edit',
                  style: TextStyle(color: neatColours['black']),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
