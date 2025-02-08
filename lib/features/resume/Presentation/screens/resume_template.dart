import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_resume/features/profile/data/model/award_model.dart';
import 'package:my_resume/features/profile/data/model/certificate_model.dart';
import 'package:my_resume/features/profile/data/model/project_model.dart';
import 'package:my_resume/features/resume/data/model/templates_model.dart';
import 'package:my_resume/features/resume/domain/generate_resume_repo.dart';
import 'package:my_resume/features/resume/Presentation/bloc/user_bloc.dart';
import 'package:my_resume/features/resume/Presentation/bloc/user_event.dart';
import 'package:my_resume/features/resume/data/model/education_model.dart';
import 'package:my_resume/features/resume/data/model/language_model.dart';
import 'package:my_resume/features/resume/data/model/work_experience_model.dart';
import 'package:my_resume/core/utils/height_function.dart';

class ResumeTemplate extends StatefulWidget {
  final TemplateModel templateData;
  final bool isNewTemplate;
  final int index;
  const ResumeTemplate(
      {super.key,
      required this.templateData,
      required this.isNewTemplate,
      required this.index});

  @override
  State<ResumeTemplate> createState() => _ResumeTemplateState();
}

class _ResumeTemplateState extends State<ResumeTemplate> {
  final TransformationController _transformationController =
      TransformationController();

  final GlobalKey<_TemporaryColumnState> _childKey =
      GlobalKey<_TemporaryColumnState>();

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tap to edit'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu_open_sharp),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              final icons = _childKey.currentState?.icons;
              final templateData = _childKey.currentState?.templateData;

              // Save the resume
              final pdfFile = await PdfApi.generateResume(
                  userData: templateData!, icons: icons!);
              widget.isNewTemplate
                  ? context
                      .read<UserDataBloc>()
                      .add(SaveTemplateData(templateData: templateData))
                  : context.read<UserDataBloc>().add(UpdateTemplateData(
                      id: widget.index, templateData: templateData));
              PdfApi.openFile(pdfFile);
            },
          )
        ],
      ),
      body: SafeArea(
        child: InteractiveViewer(
          constrained: true,
          boundaryMargin: const EdgeInsets.all(20.0),
          minScale: 0.5,
          maxScale: 3.0,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            primary: true,
            child: TemporaryColumn(
              key: _childKey,
              templateData: widget.templateData,
            ),
          ),
        ),
      ),
    );
  }
}

class TemporaryColumn extends StatefulWidget {
  TemplateModel templateData;
  TemporaryColumn({super.key, required this.templateData});

  @override
  State<TemporaryColumn> createState() => _TemporaryColumnState();
}

class _TemporaryColumnState extends State<TemporaryColumn> {
  late TemplateModel templateData;

  List<File> icons = [
    File('assets/Icons/mail.png'),
    File('assets/Icons/pin.png'),
    File('assets/Icons/linkedin.png'),
    File('assets/Icons/telephone.png'),
    File('assets/Icons/github.png'),
    File('assets/Icons/internet.png'),
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
  List<TextEditingController> achievementsControllers = [];

  final TextEditingController _addSkillController = TextEditingController();
  final TextEditingController _addPersonalProjectController =
      TextEditingController();
  final TextEditingController _addLanguageControllerForLanguageName =
      TextEditingController();
  final TextEditingController _addLanguageControllerForProficiency =
      TextEditingController();
  final TextEditingController _addInterestsController = TextEditingController();

  List<bool> _borderColorForEdu = [false, false, false, false, false, false];
  List<bool> _borderColorForWorkExp = [
    false,
    false,
    false,
    false,
    false,
    false
  ];

  bool _borderColorForSkills = false;
  bool _borderColorForPersonalProjects = false;
  bool _borderColorForLanguage = false;
  bool _borderColorForInterests = false;

  final List _iconsList1 = [
    Icons.email,
    Icons.pin_drop,
    Icons.dataset_linked_outlined,
  ];

  final List _iconsList2 = [
    Icons.phone,
    Icons.gite,
    Icons.web_sharp,
  ];

  File? _image;
  final ImagePicker _picker = ImagePicker();

  // SKills section input chips count
  int inputs = 3;

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
                  constraints: const BoxConstraints(maxHeight: 90),
                  // height: 60,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _addLanguageControllerForLanguageName,
                          decoration: InputDecoration(
                            hintText: 'Add Language',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 40,
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
                  height: 40,
                  width: MediaQuery.of(context).size.width * .9,
                  child: TextField(
                    controller: title == 'Add Skill'
                        ? _addSkillController
                        : title == 'Add Personal Project'
                            ? _addPersonalProjectController
                            : _addInterestsController,
                    decoration: InputDecoration(
                      hintText: title,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
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
                  borderRadius: BorderRadius.circular(8),
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

      List<TextEditingController> courseControllers = [
        TextEditingController(text: edu.courses[0]),
        TextEditingController(text: edu.courses[1]),
        TextEditingController(text: edu.courses[2]),
        TextEditingController(text: edu.courses[3]),
      ];
      coursesControllers.add(courseControllers);
    });
  }

  void _addWorkExperienceEntry({required WorkExperience work}) {
    setState(() {
      jobTitleControllers.add(TextEditingController(text: work.jobTitle));
      companyNameControllers.add(TextEditingController(text: work.companyName));
      workStartDateControllers.add(TextEditingController(text: work.startDate));
      workEndDateControllers.add(TextEditingController(text: work.endDate));
      jobTypeControllers.add(TextEditingController(text: work.jobType));
      achievementsControllers
          .add(TextEditingController(text: work.achievements));
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
      jobTitleControllers.add(TextEditingController(text: work.jobTitle));
      companyNameControllers.add(TextEditingController(text: work.companyName));
      workStartDateControllers.add(TextEditingController(text: work.startDate));
      workEndDateControllers.add(TextEditingController(text: work.endDate));
      jobTypeControllers.add(TextEditingController(text: work.jobType));
      achievementsControllers
          .add(TextEditingController(text: work.achievements));
    }
  }

  @override
  void initState() {
    templateData = widget.templateData;
    _initializeControllers(templateData: templateData);

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
    return Column(
      children: [
        Container(
          color: const Color.fromARGB(255, 49, 60, 75),
          child: Padding(
            padding: const EdgeInsets.only(right: 30, left: 20, top: 20),
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
                          print(templateData.userData.fullName);
                        },
                        controller: _nameController,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(color: Colors.white),
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
                        style: const TextStyle(
                          color: Color.fromARGB(255, 73, 150, 159),
                          fontSize: 11,
                          fontWeight: FontWeight.normal,
                        ),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(color: Colors.white),
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
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(color: Colors.white),
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
                          radius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage: File(
                                      templateData.userData.profilePic.path)
                                  .existsSync()
                              ? FileImage(File(
                                  widget.templateData.userData.profilePic.path))
                              : const AssetImage('assets/copy.jpg')
                                  as ImageProvider,
                        ),
                      )
                    : CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
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
                color: const Color.fromARGB(255, 34, 42, 51),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 30, left: 20, top: 10, bottom: 10),
                  child: SizedBox(
                    height: 30,
                    child: ListView.builder(
                      itemCount: templateData.userData.linkedIn != null ? 3 : 2,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Icon(
                              _iconsList1[index],
                              color: Colors.white,
                              size: 8,
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
                                          email: value,
                                        ),
                                      );
                                      print(templateData.userData.email);
                                    } else if (index == 1) {
                                      templateData = templateData.copyWith(
                                        userData:
                                            templateData.userData.copyWith(
                                          address: value,
                                        ),
                                      );
                                      print(templateData.userData.address);
                                    } else if (index == 2) {
                                      templateData = templateData.copyWith(
                                        userData:
                                            templateData.userData.copyWith(
                                          linkedIn: value,
                                        ),
                                      );
                                      print(widget
                                          .templateData.userData.linkedIn);
                                    }
                                  });
                                },
                                controller: _controllersList1[index],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide: BorderSide(color: Colors.white),
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
                color: const Color.fromARGB(255, 34, 42, 51),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 30, left: 20, top: 10, bottom: 10),
                  child: SizedBox(
                    height: 30,
                    child: ListView.builder(
                      itemCount: _itemCount(),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Icon(
                              _iconsList2[index],
                              color: Colors.white,
                              size: 8,
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
                                      print(widget
                                          .templateData.userData.phoneNumber);
                                    } else if (index == 1) {
                                      templateData = templateData.copyWith(
                                        userData:
                                            templateData.userData.copyWith(
                                          github: value,
                                        ),
                                      );
                                      print(templateData.userData.github);
                                    } else if (index == 2) {
                                      templateData = templateData.copyWith(
                                        userData:
                                            templateData.userData.copyWith(
                                          website: value,
                                        ),
                                      );
                                      print(templateData.userData.website);
                                    }
                                  });
                                },
                                controller: _controllersList2[index],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide: BorderSide(color: Colors.white),
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
                padding: const EdgeInsets.only(right: 10, left: 20, top: 10),
                // width: MediaQuery.of(context).size.width * 0.6,
                child: Column(
                  children: [
                    // EDUCATIONAL BACKGROUND
                    Column(
                      children: [
                        SizedBox(
                          height: heightFunction(
                                  sectionType: 'edu',
                                  length:
                                      templateData.educationBackground.length,
                                  screen: 'resume-template')
                              .toDouble(),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: templateData.educationBackground.length,
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
                                            ? const Text(
                                                'EDUCATION',
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationColor:
                                                      Color.fromARGB(
                                                          255, 73, 150, 159),
                                                  decorationThickness: 3,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 73, 150, 159),
                                                  fontSize: 15,
                                                ),
                                              )
                                            : const SizedBox(),
                                        const SizedBox(
                                          height: 5,
                                        ),

                                        // FIELD OF STUDY
                                        TextField(
                                          onTap: () {
                                            setState(() {
                                              _borderColorForEdu[index] =
                                                  !_borderColorForEdu[index];
                                            });
                                          },
                                          onTapOutside: (event) {
                                            setState(() {});
                                            FocusScope.of(context).unfocus();
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              templateData =
                                                  templateData.copyWith(
                                                educationBackground:
                                                    templateData
                                                        .educationBackground
                                                        .map((e) => e.copyWith(
                                                            fieldOfStudy:
                                                                value))
                                                        .toList(),
                                              );
                                            });
                                            log(templateData.educationBackground
                                                .toString());
                                          },
                                          controller:
                                              fieldOfStudyControllers[index],
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          decoration: const InputDecoration(
                                            isDense: true,
                                            contentPadding: EdgeInsets.zero,
                                            border: InputBorder.none,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
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
                                                  !_borderColorForEdu[index];
                                            });
                                          },
                                          onTapOutside: (event) {
                                            setState(() {});
                                            FocusScope.of(context).unfocus();
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              templateData =
                                                  templateData.copyWith(
                                                educationBackground:
                                                    templateData
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
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 8,
                                          ),
                                          decoration: const InputDecoration(
                                            isDense: true,
                                            contentPadding: EdgeInsets.zero,
                                            border: InputBorder.none,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                              borderSide: BorderSide(
                                                  color: Colors.green),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.22,
                                              child: TextField(
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
                                                                      startDate:
                                                                          value))
                                                              .toList(),
                                                    );
                                                  });
                                                },
                                                controller:
                                                    startDateControllers[index],
                                                style: const TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Color.fromARGB(
                                                      255, 73, 150, 159),
                                                  fontSize: 8,
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
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.15,
                                              child: TextField(
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
                                                              institutionAddress:
                                                                  value))
                                                          .toList(),
                                                    );
                                                  });
                                                },
                                                controller:
                                                    institutionAddressControllers[
                                                        index],
                                                style: const TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Color.fromARGB(
                                                      255, 73, 150, 159),
                                                  fontSize: 8,
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
                                            ),
                                          ],
                                        ),
                                        const Text(
                                          'Courses',
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Color.fromARGB(
                                                255, 73, 150, 159),
                                            fontSize: 8,
                                          ),
                                        ),
                                        Column(
                                          children: List.generate(
                                            templateData
                                                .educationBackground[index]
                                                .courses
                                                .length,
                                            (innerIndex) {
                                              return SizedBox(
                                                width: MediaQuery.of(context)
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
                                                          templateData.copyWith(
                                                        educationBackground:
                                                            templateData
                                                                .educationBackground
                                                                .map((e) =>
                                                                    e.copyWith(
                                                                      courses: e
                                                                          .courses
                                                                          .asMap()
                                                                          .map((i, c) => MapEntry(
                                                                              i,
                                                                              i == innerIndex ? value : c))
                                                                          .values
                                                                          .toList()
                                                                          .toList(),
                                                                    ))
                                                                .toList(),
                                                      );
                                                    });
                                                  },
                                                  controller:
                                                      coursesControllers[index]
                                                          [innerIndex],
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 8,
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
                                            child: Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
                                                  ),
                                                  height: 17,
                                                  width: 17,
                                                  child: const Icon(
                                                    Icons
                                                        .arrow_downward_rounded,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 3,
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
                                                                  .elementAt(
                                                                      index));
                                                    });
                                                    log(templateData
                                                        .educationBackground
                                                        .toString());
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2),
                                                    ),
                                                    height: 17,
                                                    width: 17,
                                                    child: const Icon(
                                                      Icons.copy,
                                                      color: Colors.white,
                                                      size: 15,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 3,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      templateData =
                                                          templateData.copyWith(
                                                              educationBackground:
                                                                  List.from(
                                                                      templateData
                                                                          .educationBackground)
                                                                    ..removeAt(
                                                                        index));
                                                    });
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2),
                                                    ),
                                                    height: 17,
                                                    width: 17,
                                                    child: const Icon(
                                                      Icons
                                                          .delete_forever_rounded,
                                                      color: Colors.white,
                                                      size: 15,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // WORK EXPERIENCE SECTION
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: heightFunction(
                                      sectionType: 'workExp',
                                      length:
                                          templateData.workExperience.length,
                                      screen: 'resume-template')
                                  .toDouble(),
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: templateData.workExperience.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _borderColorForWorkExp[index]
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
                                                ? const Text(
                                                    'WORK EXPERIENCE',
                                                    style: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      decorationColor:
                                                          Color.fromARGB(255,
                                                              73, 150, 159),
                                                      decorationThickness: 3,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 73, 150, 159),
                                                      fontSize: 15,
                                                    ),
                                                  )
                                                : const SizedBox(),
                                            const SizedBox(
                                              height: 5,
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
                                                  templateData =
                                                      templateData.copyWith(
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
                                                  jobTitleControllers[index],
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              decoration: const InputDecoration(
                                                isDense: true,
                                                contentPadding: EdgeInsets.zero,
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
                                                          .map((e) =>
                                                              e.copyWith(
                                                                  companyName:
                                                                      value))
                                                          .toList());
                                                });
                                              },
                                              controller:
                                                  companyNameControllers[index],
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 8,
                                              ),
                                              decoration: const InputDecoration(
                                                isDense: true,
                                                contentPadding: EdgeInsets.zero,
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
                                                  width: MediaQuery.of(context)
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
                                                                        startDate:
                                                                            value))
                                                                .toList());
                                                      });
                                                    },
                                                    controller:
                                                        workEndDateControllers[
                                                            index],
                                                    style: const TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Color.fromARGB(
                                                          255, 73, 150, 159),
                                                      fontSize: 8,
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
                                                SizedBox(
                                                  width: MediaQuery.of(context)
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
                                                                        jobType:
                                                                            value))
                                                                .toList());
                                                      });
                                                    },
                                                    controller:
                                                        jobTypeControllers[
                                                            index],
                                                    style: const TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Color.fromARGB(
                                                          255, 73, 150, 159),
                                                      fontSize: 8,
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
                                            const Text(
                                              'Achievements',
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Color.fromARGB(
                                                    255, 73, 150, 159),
                                                fontSize: 8,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
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
                                                                    achievements:
                                                                        value))
                                                            .toList());
                                                  });
                                                },
                                                controller:
                                                    achievementsControllers[
                                                        index],
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 8,
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
                                            ),
                                          ],
                                        ),
                                        _borderColorForWorkExp[index]
                                            ? Positioned(
                                                top: 0,
                                                right: 0,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2),
                                                      ),
                                                      height: 17,
                                                      width: 17,
                                                      child: const Icon(
                                                        Icons
                                                            .arrow_downward_rounded,
                                                        color: Colors.white,
                                                        size: 15,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 3,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          _addWorkExperienceEntry(
                                                              work: templateData
                                                                      .workExperience[
                                                                  index]);

                                                          templateData
                                                              .workExperience
                                                              .insert(
                                                                  index,
                                                                  templateData
                                                                      .workExperience
                                                                      .elementAt(
                                                                          index));
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.grey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(2),
                                                        ),
                                                        height: 17,
                                                        width: 17,
                                                        child: const Icon(
                                                          Icons.copy,
                                                          color: Colors.white,
                                                          size: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 3,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          templateData = templateData.copyWith(
                                                              workExperience:
                                                                  List.from(
                                                                      templateData
                                                                          .workExperience)
                                                                    ..removeAt(
                                                                        index));
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(2),
                                                        ),
                                                        height: 17,
                                                        width: 17,
                                                        child: const Icon(
                                                          Icons
                                                              .delete_forever_rounded,
                                                          color: Colors.white,
                                                          size: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  );
                                },
                              ),
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
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                              const Text(
                                'SKILLS',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Color.fromARGB(255, 73, 150, 159),
                                  decorationThickness: 3,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 73, 150, 159),
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
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
                                          spacing: 4,
                                          children: List.generate(
                                            templateData.skills.length,
                                            (index) {
                                              return IntrinsicWidth(
                                                child: Container(
                                                  height: 25,
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  margin: const EdgeInsets.only(
                                                      right: 4, bottom: 4),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              73,
                                                              150,
                                                              159),
                                                    ),
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        templateData
                                                            .skills[index],
                                                        style: const TextStyle(
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 4,
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
                                                                .grey.shade400,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                          ),
                                                          child: const Icon(
                                                            Icons.close,
                                                            size: 10,
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
                                        spacing: 4,
                                        children: List.generate(
                                          templateData.skills.length,
                                          (index) {
                                            return Container(
                                              padding: const EdgeInsets.all(2),
                                              margin: const EdgeInsets.only(
                                                  right: 4, bottom: 4),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: const Color.fromARGB(
                                                      255, 73, 150, 159),
                                                ),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                templateData.skills[index],
                                                style: const TextStyle(
                                                  fontSize: 8,
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
                                  top: 2,
                                  right: 2,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () => _showMyDialog(
                                            title: 'Add Skill', type: 'skills'),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                          height: 20,
                                          width: 20,
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 15,
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
                    const SizedBox(
                      height: 20,
                    ),
                    _borderColorForPersonalProjects
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: _borderColorForPersonalProjects
                                    ? const Color.fromARGB(255, 73, 150, 159)
                                    : Colors.white,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'PERSONAL PROJECTS',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        decorationColor:
                                            Color.fromARGB(255, 73, 150, 159),
                                        decorationThickness: 3,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 73, 150, 159),
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _borderColorForPersonalProjects =
                                              !_borderColorForPersonalProjects;
                                        });
                                      },
                                      child: Wrap(
                                          spacing: 4,
                                          children: List.generate(
                                            templateData
                                                .personalProjects.length,
                                            (index) {
                                              return IntrinsicWidth(
                                                child: Container(
                                                  height: 25,
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  margin: const EdgeInsets.only(
                                                      right: 4, bottom: 4),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              73,
                                                              150,
                                                              159),
                                                    ),
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
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
                                                        style: const TextStyle(
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 4,
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
                                                            color: Colors
                                                                .grey.shade400,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                          ),
                                                          child: const Icon(
                                                            Icons.close,
                                                            size: 10,
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
                                        top: 2,
                                        right: 2,
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () => _showMyDialog(
                                                  title: 'Add Personal Project',
                                                  type: 'personalProjects'),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                ),
                                                height: 20,
                                                width: 20,
                                                child: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 15,
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
                                const Text(
                                  'PERSONAL PROJECTS',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        Color.fromARGB(255, 73, 150, 159),
                                    decorationThickness: 3,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 73, 150, 159),
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                    templateData.personalProjects.length,
                                    (index) {
                                      return Column(
                                        children: [
                                          Text(
                                            templateData
                                                .personalProjects[index].name,
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    _borderColorForLanguage
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: _borderColorForLanguage
                                    ? const Color.fromARGB(255, 73, 150, 159)
                                    : Colors.white,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'LANGUAGES',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        decorationColor:
                                            Color.fromARGB(255, 73, 150, 159),
                                        decorationThickness: 3,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 73, 150, 159),
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _borderColorForLanguage =
                                              !_borderColorForLanguage;
                                        });
                                      },
                                      child: Wrap(
                                          spacing: 4,
                                          children: List.generate(
                                            templateData.languages.length,
                                            (index) {
                                              return IntrinsicWidth(
                                                child: Container(
                                                  height: 35,
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  margin: const EdgeInsets.only(
                                                      right: 4, bottom: 4),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              73,
                                                              150,
                                                              159),
                                                    ),
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
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
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 4,
                                                          ),
                                                          Text(
                                                            templateData
                                                                .languages[
                                                                    index]
                                                                .proficiency,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 10,
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
                                                            color: Colors
                                                                .grey.shade400,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                          ),
                                                          child: const Icon(
                                                            Icons.close,
                                                            size: 10,
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
                                        top: 2,
                                        right: 2,
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
                                                      BorderRadius.circular(2),
                                                ),
                                                height: 20,
                                                width: 20,
                                                child: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 15,
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
                                const Text(
                                  'Languages',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        Color.fromARGB(255, 73, 150, 159),
                                    decorationThickness: 3,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 73, 150, 159),
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            templateData
                                                .languages[index].proficiency,
                                            style: const TextStyle(
                                              fontSize: 10,
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
                    const SizedBox(
                      height: 20,
                    ),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'INTERESTS',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor:
                                          Color.fromARGB(255, 73, 150, 159),
                                      decorationThickness: 3,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 73, 150, 159),
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
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
                                            spacing: 4,
                                            children: List.generate(
                                              templateData.interests.length,
                                              (index) {
                                                return IntrinsicWidth(
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(2),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 4,
                                                            bottom: 4),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              73,
                                                              150,
                                                              159),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          templateData
                                                              .interests[index],
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 4,
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
                                                              color: Colors.grey
                                                                  .shade400,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                            ),
                                                            child: const Icon(
                                                              Icons.close,
                                                              size: 10,
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
                                            spacing: 4,
                                            children: List.generate(
                                              templateData.interests.length,
                                              (index) {
                                                return Container(
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  margin: const EdgeInsets.only(
                                                      right: 4, bottom: 4),
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 73, 150, 159),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: Text(
                                                    templateData
                                                        .interests[index],
                                                    style: const TextStyle(
                                                      fontSize: 8,
                                                      color: Colors.white,
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
                                      top: 2,
                                      right: 2,
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
                                                    BorderRadius.circular(2),
                                              ),
                                              height: 20,
                                              width: 20,
                                              child: const Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 15,
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
        const Align(
          alignment: Alignment.topCenter,
          child: Card(
            color: Colors.amber,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Tap on any section to edit',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
