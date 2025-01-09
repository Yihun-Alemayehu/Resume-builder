import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_resume/API/pdf_api.dart';
import 'package:my_resume/API/pdf_resume_template.dart';
import 'package:my_resume/data/model/education_model.dart';
import 'package:my_resume/data/model/language_model.dart';
import 'package:my_resume/data/model/user_data_model.dart';
import 'package:my_resume/data/model/user_model.dart';
import 'package:my_resume/data/model/work_experience_model.dart';

class ResumeTemplate extends StatefulWidget {
  const ResumeTemplate({super.key});

  @override
  State<ResumeTemplate> createState() => _ResumeTemplateState();
}

class _ResumeTemplateState extends State<ResumeTemplate> {
  final TransformationController _transformationController =
      TransformationController();

  final GlobalKey<_TemporaryColumnState> _childKey =
      GlobalKey<_TemporaryColumnState>(); // Key for the name field

  void _zoomToField(GlobalKey fieldKey) {
    // Get the field's position
    final RenderBox? renderBox =
        fieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position =
          renderBox.localToGlobal(Offset.zero); // Position on screen
      final size = renderBox.size; // Size of the field
      print('Field position: $position, Size: $size');

      // Adjust zoom to focus on the field
      setState(() {
        _transformationController.value = Matrix4.identity()
          ..scale(2.0) // Zoom scale
          ..translate(-position.dx + size.width / 2, -size.height);
      });
    }
  }

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
              final myUser = _childKey.currentState?.myUser;
              final education = _childKey.currentState?.edu;
              final workExperience = _childKey.currentState?.workExp;
              final skills = _childKey.currentState?.skills;
              final personalProjects = _childKey.currentState?.personalProjects;
              final languages = _childKey.currentState?.languages;
              final interests = _childKey.currentState?.interests;

              // Save the resume
              final pdfFile = await PdfApi.generateResume(
                userData: UserData(
                  userData: myUser!,
                  educationBackground: education!,
                  workExperience: workExperience!,
                  skills: skills!,
                  personalProjects: personalProjects!,
                  languages: languages!,
                  interests: interests!,
                ),
              );
              PdfApi.openFile(pdfFile);
            },
          )
        ],
      ),
      body: SafeArea(
        child: InteractiveViewer(
          // transformationController: _transformationController,
          constrained: true, // Set to false to allow it to expand freely
          boundaryMargin:
              const EdgeInsets.all(20.0), // Optional for boundary padding
          minScale: 0.5, // Minimum zoom scale
          maxScale: 3.0,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            primary: true,
            child: TemporaryColumn(
              key: _childKey,
            ),
          ),
        ),
      ),
    );
  }
}

class TemporaryColumn extends StatefulWidget {
  const TemporaryColumn({
    super.key,
  });

  @override
  State<TemporaryColumn> createState() => _TemporaryColumnState();
}

class _TemporaryColumnState extends State<TemporaryColumn> {
  MyUser myUser = MyUser(
    fullName: 'Yihun Alemayehu',
    profession: 'Flutter Developer',
    bio:
        'Enthusiastic and innovative Flutter Developer and Graphics Designer ready to bring a unique blend '
        'of creativity and technical prowess to the Universe. Proficient in Flutter, Dart, and graphic designtools, '
        'I specialize in crafting visually stunning and seamlessly functional mobile applications. With a passion for '
        'user-centric design and a commitment to staying at the forefront of emerging technologies,I am eager to contribute '
        'my skills and learn from experienced professionals in a collaborative environment.',
    profilePic: File('assets/copy.jpg'),
    email: 'yankure01@gmail.com',
    address: 'Addis Ababa, Ethiopia',
    phoneNumber: '+251 982 39 40 38',
    linkedIn: 'linkedin.com/in/yihun-alemayehu',
    github: 'github.com/Yihun-Alemayehu',
    website: 'yihun-alemayehu.netlify.com/app',
  );

  List<EducationBackground> edu = [
    EducationBackground(
      fieldOfStudy: 'Software Engineering',
      institutionName: 'Addis Ababa Science and Technology University',
      startDate: '05/2022 - Present',
      endDate: 'Present',
      institutionAddress: 'Addis Ababa',
      courses: [
        'Internet Programming',
        'Object-oriented Programming',
        'Data Structures and Algorithms',
        'Mobile app development',
      ],
    ),
    EducationBackground(
      fieldOfStudy: 'Mobile app development',
      institutionName: 'GDG AASTU',
      startDate: '10/2023 - 03/2024',
      endDate: '03/2024',
      institutionAddress: 'Addis Ababa',
      courses: ['Flutter', 'Dart', 'Firebase', 'Bloc State Management'],
    ),
  ];

  List<WorkExperience> workExp = [
    WorkExperience(
      jobTitle: 'FLutter Developer',
      companyName: 'Hex-labs',
      startDate: '10/2023 - 01/2024',
      endDate: '01/2024',
      jobType: 'Remote',
      achievements:
          'Implemented Payment Gateway Transition: Successfully facilitated the transition from Telebirr to Chapa as the payment gateway, streamlining transaction processes and enhancing payment reliability.',
    ),
    WorkExperience(
      jobTitle: 'FLutter Developer',
      companyName: 'Horan-Software',
      startDate: '08/2024 - 11/2024',
      endDate: '11/2024',
      jobType: 'Contract',
      achievements:
          'Implemented Firebase Integration: Successfully integrated Firebase into the application, enhancing real-time database management, user authentication, and analytics capabilities, leading to improved app performance and user engagement.',
    ),
    WorkExperience(
      jobTitle: 'FLutter Developer',
      companyName: 'Yize-Tech Ethiopia',
      startDate: '02/2023 - 09/2023',
      endDate: '09/2023',
      jobType: 'Remote',
      achievements:
          'Implemented Complex UI Designs: Successfully developed and integrated intricate, user-centric UI components, ensuring seamless functionality, responsiveness, and an engaging user experience across diverse devices and screen sizes.',
    ),
  ];

  List<LanguageModel> languages = [
    LanguageModel(
        language: 'English', proficiency: 'Full Professional Proficient'),
    LanguageModel(
        language: 'Amharic', proficiency: 'Full Professional Proficient'),
  ];

  List<String> skills = [
    'Programming',
    'Flutter',
    'Dart',
    'Firebase',
    'Software development',
    'Figma',
    'State Management',
    'Graphics design',
    'Leadership',
    'Communication',
    'Photography',
  ];
  List<String> personalProjects = [
    'Guadaye Mobile App',
    'AddisCart Mobile App',
    'GraceLink Mobile App',
    'Yize-chat Mobile App',
    'Nedemy Mobile App',
  ];
  List<String> interests = [
    'Technology',
    'Design',
    'Photography',
    'Cooking',
    'Reading',
    'Gaming',
    'Artificial Intelligence',
    'Space science',
    'programming',
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
  final TextEditingController _fieldOfStudyController = TextEditingController();
  final TextEditingController _institutionNameController =
      TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _institutionAddressController =
      TextEditingController();
  final TextEditingController _fieldOfStudyController2 =
      TextEditingController();
  final TextEditingController _institutionNameController2 =
      TextEditingController();
  final TextEditingController _startDateController2 = TextEditingController();
  final TextEditingController _endDateController2 = TextEditingController();
  final TextEditingController _institutionAddressController2 =
      TextEditingController();
  final TextEditingController _fieldOfStudyController3 =
      TextEditingController();
  final TextEditingController _institutionNameController3 =
      TextEditingController();
  final TextEditingController _startDateController3 = TextEditingController();
  final TextEditingController _endDateController3 = TextEditingController();
  final TextEditingController _institutionAddressController3 =
      TextEditingController();
  final TextEditingController _fieldOfStudyController4 =
      TextEditingController();
  final TextEditingController _institutionNameController4 =
      TextEditingController();
  final TextEditingController _startDateController4 = TextEditingController();
  final TextEditingController _endDateController4 = TextEditingController();
  final TextEditingController _institutionAddressController4 =
      TextEditingController();
  final TextEditingController _fieldOfStudyController5 =
      TextEditingController();
  final TextEditingController _institutionNameController5 =
      TextEditingController();
  final TextEditingController _startDateController5 = TextEditingController();
  final TextEditingController _endDateController5 = TextEditingController();
  final TextEditingController _institutionAddressController5 =
      TextEditingController();
  final TextEditingController _fieldOfStudyController6 =
      TextEditingController();
  final TextEditingController _institutionNameController6 =
      TextEditingController();
  final TextEditingController _startDateController6 = TextEditingController();
  final TextEditingController _endDateController6 = TextEditingController();
  final TextEditingController _institutionAddressController6 =
      TextEditingController();
  final TextEditingController _coursesController = TextEditingController();
  final TextEditingController _coursesController4eduOne1 =
      TextEditingController();
  final TextEditingController _coursesController4eduOne2 =
      TextEditingController();
  final TextEditingController _coursesController4eduOne3 =
      TextEditingController();
  final TextEditingController _coursesController4eduOne4 =
      TextEditingController();
  final TextEditingController _coursesController4eduTwo1 =
      TextEditingController();
  final TextEditingController _coursesController4eduTwo2 =
      TextEditingController();
  final TextEditingController _coursesController4eduTwo3 =
      TextEditingController();
  final TextEditingController _coursesController4eduTwo4 =
      TextEditingController();
  final TextEditingController _coursesController4eduThree1 =
      TextEditingController();
  final TextEditingController _coursesController4eduThree2 =
      TextEditingController();
  final TextEditingController _coursesController4eduThree3 =
      TextEditingController();
  final TextEditingController _coursesController4eduThree4 =
      TextEditingController();
  final TextEditingController _coursesController4eduFour1 =
      TextEditingController();
  final TextEditingController _coursesController4eduFour2 =
      TextEditingController();
  final TextEditingController _coursesController4eduFour3 =
      TextEditingController();
  final TextEditingController _coursesController4eduFour4 =
      TextEditingController();
  final TextEditingController _coursesController4eduFive1 =
      TextEditingController();
  final TextEditingController _coursesController4eduFive2 =
      TextEditingController();
  final TextEditingController _coursesController4eduFive3 =
      TextEditingController();
  final TextEditingController _coursesController4eduFive4 =
      TextEditingController();
  final TextEditingController _coursesController4eduSix1 =
      TextEditingController();
  final TextEditingController _coursesController4eduSix2 =
      TextEditingController();
  final TextEditingController _coursesController4eduSix3 =
      TextEditingController();
  final TextEditingController _coursesController4eduSix4 =
      TextEditingController();

  final TextEditingController _workExpJobTitleController1 =
      TextEditingController();
  final TextEditingController _workExpCompanyNameController1 =
      TextEditingController();
  final TextEditingController _workExpStartDateController1 =
      TextEditingController();
  final TextEditingController _workExpEndDateController1 =
      TextEditingController();
  final TextEditingController _workExpJobTypeController1 =
      TextEditingController();
  final TextEditingController _workExpAchievementController1 =
      TextEditingController();

  final TextEditingController _workExpJobTitleController2 =
      TextEditingController();
  final TextEditingController _workExpCompanyNameController2 =
      TextEditingController();
  final TextEditingController _workExpStartDateController2 =
      TextEditingController();
  final TextEditingController _workExpEndDateController2 =
      TextEditingController();
  final TextEditingController _workExpJobTypeController2 =
      TextEditingController();
  final TextEditingController _workExpAchievementController2 =
      TextEditingController();

  final TextEditingController _workExpJobTitleController3 =
      TextEditingController();
  final TextEditingController _workExpCompanyNameController3 =
      TextEditingController();
  final TextEditingController _workExpStartDateController3 =
      TextEditingController();
  final TextEditingController _workExpEndDateController3 =
      TextEditingController();
  final TextEditingController _workExpJobTypeController3 =
      TextEditingController();
  final TextEditingController _workExpAchievementController3 =
      TextEditingController();

  final TextEditingController _workExpJobTitleController4 =
      TextEditingController();
  final TextEditingController _workExpCompanyNameController4 =
      TextEditingController();
  final TextEditingController _workExpStartDateController4 =
      TextEditingController();
  final TextEditingController _workExpEndDateController4 =
      TextEditingController();
  final TextEditingController _workExpJobTypeController4 =
      TextEditingController();
  final TextEditingController _workExpAchievementController4 =
      TextEditingController();

  final TextEditingController _workExpJobTitleController5 =
      TextEditingController();
  final TextEditingController _workExpCompanyNameController5 =
      TextEditingController();
  final TextEditingController _workExpStartDateController5 =
      TextEditingController();
  final TextEditingController _workExpEndDateController5 =
      TextEditingController();
  final TextEditingController _workExpJobTypeController5 =
      TextEditingController();
  final TextEditingController _workExpAchievementController5 =
      TextEditingController();

  final TextEditingController _workExpJobTitleController6 =
      TextEditingController();
  final TextEditingController _workExpCompanyNameController6 =
      TextEditingController();
  final TextEditingController _workExpStartDateController6 =
      TextEditingController();
  final TextEditingController _workExpEndDateController6 =
      TextEditingController();
  final TextEditingController _workExpJobTypeController6 =
      TextEditingController();
  final TextEditingController _workExpAchievementController6 =
      TextEditingController();

  var _overlayController = OverlayPortalController();

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
    myUser = myUser.copyWith(profilePic: _image!);
    setState(() {});
  }

  // Personal info controllers list
  List _controllersList1 = [];
  List _controllersList2 = [];

  // Education Background count controllers
  List _controllersList3 = [];
  List _controllersList4 = [];
  List _controllersList5 = [];
  List _controllersList6 = [];
  List _controllersList7 = [];
  List _controllersList8 = [];

  // Work experience count controllers
  List _workExperienceControllersList1 = [];
  List _workExperienceControllersList2 = [];
  List _workExperienceControllersList3 = [];
  List _workExperienceControllersList4 = [];
  List _workExperienceControllersList5 = [];
  List _workExperienceControllersList6 = [];

  // Education background course controllers list
  List _coursesControllersList1 = [];
  List _coursesControllersList2 = [];
  List _coursesControllersList3 = [];
  List _coursesControllersList4 = [];
  List _coursesControllersList5 = [];
  List _coursesControllersList6 = [];

  // Item count for personal info
  int _itemCount() {
    if (myUser.github != null && myUser.website != null) {
      return 3;
    } else if (myUser.github != null || myUser.website != null) {
      return 2;
    } else {
      return 1;
    }
  }

  // controllers fuction for education, courses and work experience
  TextEditingController _controllerFunction(
      {required String controllerType,
      required int index,
      required int count}) {
    if (controllerType == 'edu') {
      if (index == 0) {
        return _controllersList3[count];
      } else if (index == 1) {
        return _controllersList4[count];
      } else if (index == 2) {
        return _controllersList5[count];
      } else if (index == 3) {
        return _controllersList6[count];
      } else if (index == 4) {
        return _controllersList7[count];
      } else {
        return _controllersList8[count];
      }
    } else if (controllerType == 'courses') {
      if (index == 0) {
        return _coursesControllersList1[count];
      } else if (index == 1) {
        return _coursesControllersList2[count];
      } else if (index == 2) {
        return _coursesControllersList3[count];
      } else if (index == 3) {
        return _coursesControllersList4[count];
      } else if (index == 4) {
        return _coursesControllersList5[count];
      } else {
        return _coursesControllersList6[count];
      }
    } else {
      if (index == 0) {
        return _workExperienceControllersList1[count];
      } else if (index == 1) {
        return _workExperienceControllersList2[count];
      } else if (index == 2) {
        return _workExperienceControllersList3[count];
      } else if (index == 3) {
        return _workExperienceControllersList4[count];
      } else if (index == 4) {
        return _workExperienceControllersList5[count];
      } else {
        return _workExperienceControllersList6[count];
      }
    }
  }

  // Height fuction for edu and work experience sections
  int _heightFunction({required String sectionType}) {
    if (sectionType == 'edu') {
      int eduLength = edu.length;
      if (eduLength == 1) {
        return 110;
      } else if (eduLength == 2) {
        return 220;
      } else if (eduLength == 3) {
        return 330;
      } else if (eduLength == 4) {
        return 440;
      } else {
        return 550;
      }
    } else {
      int workExpLength = workExp.length;
      if (workExpLength == 1) {
        return 140;
      } else if (workExpLength == 2) {
        return 280;
      } else if (workExpLength == 3) {
        return 420;
      } else if (workExpLength == 4) {
        return 560;
      } else {
        return 700;
      }
    }
  }

  final TextEditingController _addSkillController = TextEditingController();
  final TextEditingController _addPersonalProjectController =
      TextEditingController();
  final TextEditingController _addLanguageControllerForLanguageName =
      TextEditingController();
  final TextEditingController _addLanguageControllerForProficiency =
      TextEditingController();
  final TextEditingController _addInterestsController = TextEditingController();

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
                    skills.add(_addSkillController.text);
                    _addSkillController.clear();
                  } else if (title == 'Add Personal Project') {
                    personalProjects.add(_addPersonalProjectController.text);
                    _addPersonalProjectController.clear();
                  } else if (title == 'Add Interest') {
                    interests.add(_addInterestsController.text);
                    _addInterestsController.clear();
                  } else {
                    languages.add(
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

  @override
  void initState() {
    super.initState();

    // User controllers
    _nameController.text = myUser.fullName;
    _professionController.text = myUser.profession;
    _bioController.text = myUser.bio;
    _emailController.text = myUser.email;
    _addressController.text = myUser.address;
    _linkedInController.text = myUser.linkedIn!;
    _phoneController.text = myUser.phoneNumber;
    _githubController.text = myUser.github!;
    _websiteController.text = myUser.website!;

    // Education Background controllers
    _fieldOfStudyController.text = edu[0].fieldOfStudy;
    _institutionNameController.text = edu[0].institutionName;
    _startDateController.text = edu[0].startDate;
    _endDateController.text = edu[0].endDate;
    _institutionAddressController.text = edu[0].institutionAddress;

    _fieldOfStudyController2.text = edu[1].fieldOfStudy;
    _institutionNameController2.text = edu[1].institutionName;
    _startDateController2.text = edu[1].startDate;
    _endDateController2.text = edu[1].endDate;
    _institutionAddressController2.text = edu[1].institutionAddress;

    _fieldOfStudyController3.text = edu[0].fieldOfStudy;
    _institutionNameController3.text = edu[0].institutionName;
    _startDateController3.text = edu[0].startDate;
    _endDateController3.text = edu[0].endDate;
    _institutionAddressController3.text = edu[0].institutionAddress;

    _fieldOfStudyController4.text = edu[1].fieldOfStudy;
    _institutionNameController4.text = edu[1].institutionName;
    _startDateController4.text = edu[1].startDate;
    _endDateController4.text = edu[1].endDate;
    _institutionAddressController4.text = edu[1].institutionAddress;

    _fieldOfStudyController5.text = edu[0].fieldOfStudy;
    _institutionNameController5.text = edu[0].institutionName;
    _startDateController5.text = edu[0].startDate;
    _endDateController5.text = edu[0].endDate;
    _institutionAddressController5.text = edu[0].institutionAddress;

    _fieldOfStudyController4.text = edu[1].fieldOfStudy;
    _institutionNameController4.text = edu[1].institutionName;
    _startDateController4.text = edu[1].startDate;
    _endDateController4.text = edu[1].endDate;
    _institutionAddressController4.text = edu[1].institutionAddress;

    // Course controllers
    _coursesController4eduOne1.text = edu[0].courses[0];
    _coursesController4eduOne2.text = edu[0].courses[1];
    _coursesController4eduOne3.text = edu[0].courses[2];
    _coursesController4eduOne4.text = edu[0].courses[3];

    _coursesController4eduTwo1.text = edu[1].courses[0];
    _coursesController4eduTwo2.text = edu[1].courses[1];
    _coursesController4eduTwo3.text = edu[1].courses[2];
    _coursesController4eduTwo4.text = edu[1].courses[3];

    _coursesController4eduThree1.text = edu[0].courses[0];
    _coursesController4eduThree2.text = edu[0].courses[1];
    _coursesController4eduThree3.text = edu[0].courses[2];
    _coursesController4eduThree4.text = edu[0].courses[3];

    _coursesController4eduFour1.text = edu[1].courses[0];
    _coursesController4eduFour2.text = edu[1].courses[1];
    _coursesController4eduFour3.text = edu[1].courses[2];
    _coursesController4eduFour4.text = edu[1].courses[3];

    _coursesController4eduFive1.text = edu[0].courses[0];
    _coursesController4eduFive2.text = edu[0].courses[1];
    _coursesController4eduFive3.text = edu[0].courses[2];
    _coursesController4eduFive4.text = edu[0].courses[3];

    _coursesController4eduSix1.text = edu[1].courses[0];
    _coursesController4eduSix2.text = edu[1].courses[1];
    _coursesController4eduSix3.text = edu[1].courses[2];
    _coursesController4eduSix4.text = edu[1].courses[3];

    // Work Experience controllers
    _workExpJobTitleController1.text = workExp[0].jobTitle;
    _workExpCompanyNameController1.text = workExp[0].companyName;
    _workExpStartDateController1.text = workExp[0].startDate;
    _workExpEndDateController1.text = workExp[0].endDate;
    _workExpJobTypeController1.text = workExp[0].jobType;
    _workExpAchievementController1.text = workExp[0].achievements;

    _workExpJobTitleController2.text = workExp[1].jobTitle;
    _workExpCompanyNameController2.text = workExp[1].companyName;
    _workExpStartDateController2.text = workExp[1].startDate;
    _workExpEndDateController2.text = workExp[1].endDate;
    _workExpJobTypeController2.text = workExp[1].jobType;
    _workExpAchievementController2.text = workExp[1].achievements;

    _workExpJobTitleController3.text = workExp[2].jobTitle;
    _workExpCompanyNameController3.text = workExp[2].companyName;
    _workExpStartDateController3.text = workExp[2].startDate;
    _workExpEndDateController3.text = workExp[2].endDate;
    _workExpJobTypeController3.text = workExp[2].jobType;
    _workExpAchievementController3.text = workExp[2].achievements;

    _workExpJobTitleController4.text = workExp[0].jobTitle;
    _workExpCompanyNameController4.text = workExp[0].companyName;
    _workExpStartDateController4.text = workExp[0].startDate;
    _workExpEndDateController4.text = workExp[0].endDate;
    _workExpJobTypeController4.text = workExp[0].jobType;
    _workExpAchievementController4.text = workExp[0].achievements;

    _workExpJobTitleController5.text = workExp[1].jobTitle;
    _workExpCompanyNameController5.text = workExp[1].companyName;
    _workExpStartDateController5.text = workExp[1].startDate;
    _workExpEndDateController5.text = workExp[1].endDate;
    _workExpJobTypeController5.text = workExp[1].jobType;
    _workExpAchievementController5.text = workExp[1].achievements;

    _workExpJobTitleController6.text = workExp[2].jobTitle;
    _workExpCompanyNameController6.text = workExp[2].companyName;
    _workExpStartDateController6.text = workExp[2].startDate;
    _workExpEndDateController6.text = workExp[2].endDate;
    _workExpJobTypeController6.text = workExp[2].jobType;
    _workExpAchievementController6.text = workExp[2].achievements;

    // Personal info Controllers
    _controllersList1
        .addAll([_emailController, _addressController, _linkedInController, 1]);

    _controllersList2.addAll([
      _phoneController,
      _githubController,
      _websiteController,
    ]);

    // Education Background controllers
    _controllersList3.addAll([
      _fieldOfStudyController,
      _institutionNameController,
      _startDateController,
      _endDateController,
      _institutionAddressController,
      _coursesController,
    ]);

    _controllersList4.addAll([
      _fieldOfStudyController2,
      _institutionNameController2,
      _startDateController2,
      _endDateController2,
      _institutionAddressController2,
    ]);

    _controllersList5.addAll([
      _fieldOfStudyController3,
      _institutionNameController3,
      _startDateController3,
      _endDateController3,
      _institutionAddressController3,
      // _coursesController3,
    ]);

    _controllersList6.addAll([
      _fieldOfStudyController4,
      _institutionNameController4,
      _startDateController4,
      _endDateController4,
      _institutionAddressController4,
    ]);

    _controllersList7.addAll([
      _fieldOfStudyController5,
      _institutionNameController5,
      _startDateController5,
      _endDateController5,
      _institutionAddressController5,
      // _coursesController5,
    ]);

    _controllersList8.addAll([
      _fieldOfStudyController6,
      _institutionNameController6,
      _startDateController6,
      _endDateController6,
      _institutionAddressController6,
    ]);

    _coursesControllersList1.addAll([
      _coursesController4eduOne1,
      _coursesController4eduOne2,
      _coursesController4eduOne3,
      _coursesController4eduOne4,
    ]);

    _coursesControllersList2.addAll([
      _coursesController4eduTwo1,
      _coursesController4eduTwo2,
      _coursesController4eduTwo3,
      _coursesController4eduTwo4,
    ]);

    _coursesControllersList3.addAll([
      _coursesController4eduThree1,
      _coursesController4eduThree2,
      _coursesController4eduThree3,
      _coursesController4eduThree4,
    ]);

    _coursesControllersList4.addAll([
      _coursesController4eduFour1,
      _coursesController4eduFour2,
      _coursesController4eduFour3,
      _coursesController4eduFour4,
    ]);
    _coursesControllersList5.addAll([
      _coursesController4eduFive1,
      _coursesController4eduFive2,
      _coursesController4eduFive3,
      _coursesController4eduFive4,
    ]);

    _coursesControllersList6.addAll([
      _coursesController4eduSix1,
      _coursesController4eduSix2,
      _coursesController4eduSix3,
      _coursesController4eduSix4,
    ]);

    // Work Experience controllers
    _workExperienceControllersList1.addAll([
      _workExpJobTitleController1,
      _workExpCompanyNameController1,
      _workExpStartDateController1,
      _workExpEndDateController1,
      _workExpJobTypeController1,
      _workExpAchievementController1,
    ]);

    _workExperienceControllersList2.addAll([
      _workExpJobTitleController2,
      _workExpCompanyNameController2,
      _workExpStartDateController2,
      _workExpEndDateController2,
      _workExpJobTypeController2,
      _workExpAchievementController2,
    ]);

    _workExperienceControllersList3.addAll([
      _workExpJobTitleController3,
      _workExpCompanyNameController3,
      _workExpStartDateController3,
      _workExpEndDateController3,
      _workExpJobTypeController3,
      _workExpAchievementController3,
    ]);

    _workExperienceControllersList4.addAll([
      _workExpJobTitleController4,
      _workExpCompanyNameController4,
      _workExpStartDateController4,
      _workExpEndDateController4,
      _workExpJobTypeController4,
      _workExpAchievementController4,
    ]);

    _workExperienceControllersList5.addAll([
      _workExpJobTitleController5,
      _workExpCompanyNameController5,
      _workExpStartDateController5,
      _workExpEndDateController5,
      _workExpJobTypeController5,
      _workExpAchievementController5,
    ]);

    _workExperienceControllersList6.addAll([
      _workExpJobTitleController6,
      _workExpCompanyNameController6,
      _workExpStartDateController6,
      _workExpEndDateController6,
      _workExpJobTypeController6,
      _workExpAchievementController6,
    ]);

    // Language controller
    _addLanguageControllerForLanguageName.text = languages[0].language;
    _addLanguageControllerForProficiency.text = languages[0].proficiency;
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
                      TextField(
                        onTapOutside: (event) {
                          setState(() {
                            myUser =
                                myUser.copyWith(fullName: _nameController.text);
                          });
                          print(myUser.fullName);
                          FocusScope.of(context).unfocus();
                        },
                        onSubmitted: (value) {
                          setState(() {
                            myUser = myUser.copyWith(fullName: value);
                          });
                          print(myUser.fullName);
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
                      TextField(
                        onTapOutside: (event) {
                          setState(() {
                            myUser = myUser.copyWith(
                                profession: _professionController.text);
                          });
                          print(myUser.profession);
                          FocusScope.of(context).unfocus();
                        },
                        onSubmitted: (value) {
                          setState(() {
                            myUser = myUser.copyWith(profession: value);
                          });
                          print(myUser.profession);
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
                      TextField(
                        maxLines: null,
                        onTapOutside: (event) {
                          setState(() {
                            myUser = myUser.copyWith(bio: _bioController.text);
                          });
                          print(myUser.bio);
                          FocusScope.of(context).unfocus();
                        },
                        onSubmitted: (value) {
                          setState(() {
                            myUser = myUser.copyWith(bio: value);
                          });
                          print(myUser.bio);
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
                          backgroundImage: AssetImage(myUser.profilePic.path),
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
            Expanded(
              child: Container(
                color: const Color.fromARGB(255, 34, 42, 51),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 30, left: 20, top: 10, bottom: 10),
                  child: SizedBox(
                    height: 30,
                    child: ListView.builder(
                      itemCount: myUser.linkedIn != null ? 3 : 2,
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
                                  setState(() {
                                    if (index == 0) {
                                      myUser = myUser.copyWith(
                                          email: _controllersList1[index].text);
                                      print(myUser.email);
                                    } else if (index == 1) {
                                      myUser = myUser.copyWith(
                                          address:
                                              _controllersList1[index].text);
                                      print(myUser.address);
                                    } else if (index == 2) {
                                      myUser = myUser.copyWith(
                                          linkedIn:
                                              _controllersList1[index].text);
                                      print(myUser.linkedIn);
                                    }
                                  });
                                  FocusScope.of(context).unfocus();
                                },
                                onSubmitted: (value) {
                                  setState(() {
                                    if (index == 0) {
                                      myUser = myUser.copyWith(
                                          email: _controllersList1[index].text);
                                      print(myUser.email);
                                    } else if (index == 1) {
                                      myUser = myUser.copyWith(
                                          address:
                                              _controllersList1[index].text);
                                      print(myUser.address);
                                    } else if (index == 2) {
                                      myUser = myUser.copyWith(
                                          linkedIn:
                                              _controllersList1[index].text);
                                      print(myUser.linkedIn);
                                    }
                                  });
                                  FocusScope.of(context).unfocus();
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
                                  setState(() {
                                    if (index == 0) {
                                      myUser = myUser.copyWith(
                                          email: _controllersList2[index].text);
                                      print(myUser.email);
                                    } else if (index == 1) {
                                      myUser = myUser.copyWith(
                                          address:
                                              _controllersList2[index].text);
                                      print(myUser.address);
                                    } else if (index == 2) {
                                      myUser = myUser.copyWith(
                                          linkedIn:
                                              _controllersList2[index].text);
                                      print(myUser.linkedIn);
                                    }
                                  });
                                  FocusScope.of(context).unfocus();
                                },
                                onSubmitted: (value) {
                                  setState(() {
                                    if (index == 0) {
                                      myUser = myUser.copyWith(
                                          email: _controllersList2[index].text);
                                      print(myUser.email);
                                    } else if (index == 1) {
                                      myUser = myUser.copyWith(
                                          address:
                                              _controllersList2[index].text);
                                      print(myUser.address);
                                    } else if (index == 2) {
                                      myUser = myUser.copyWith(
                                          linkedIn:
                                              _controllersList2[index].text);
                                      print(myUser.linkedIn);
                                    }
                                  });
                                  FocusScope.of(context).unfocus();
                                },
                                controller: _controllersList2[index],
                                // focusNode: widget.professionFocusNode,
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
                    Column(
                      children: [
                        SizedBox(
                          height:
                              _heightFunction(sectionType: 'edu').toDouble(),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: edu.length,
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
                                        TextField(
                                          onTap: () {
                                            setState(() {
                                              _borderColorForEdu[index] =
                                                  !_borderColorForEdu[index];
                                            });
                                            // _overlayController.toggle();
                                            print(_overlayController.isShowing);
                                          },
                                          onTapOutside: (event) {
                                            setState(() {});
                                            FocusScope.of(context).unfocus();
                                          },
                                          onSubmitted: (value) {
                                            setState(() {});
                                            FocusScope.of(context).unfocus();
                                          },
                                          controller: _controllerFunction(
                                            controllerType: 'edu',
                                            index: index,
                                            count: 0,
                                          ),
                                          // focusNode: widget.professionFocusNode,
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
                                        TextField(
                                          maxLines: null,
                                          onTap: () {
                                            setState(() {
                                              _borderColorForEdu[index] =
                                                  !_borderColorForEdu[index];
                                            });
                                            // _overlayController.toggle();
                                            print(_overlayController.isShowing);
                                          },
                                          onTapOutside: (event) {
                                            setState(() {});
                                            FocusScope.of(context).unfocus();
                                          },
                                          onSubmitted: (value) {
                                            setState(() {});
                                            FocusScope.of(context).unfocus();
                                          },
                                          controller: _controllerFunction(
                                            controllerType: 'edu',
                                            index: index,
                                            count: 1,
                                          ),
                                          // focusNode: widget.professionFocusNode,
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
                                                  // _overlayController.toggle();
                                                  print(_overlayController
                                                      .isShowing);
                                                },
                                                onTapOutside: (event) {
                                                  setState(() {});
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                },
                                                onSubmitted: (value) {
                                                  setState(() {});
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                },
                                                controller: _controllerFunction(
                                                  controllerType: 'edu',
                                                  index: index,
                                                  count: 2,
                                                ),
                                                // focusNode: widget.professionFocusNode,
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
                                                  // _overlayController.toggle();
                                                  print(_overlayController
                                                      .isShowing);
                                                },
                                                onTapOutside: (event) {
                                                  setState(() {});
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                },
                                                onSubmitted: (value) {
                                                  setState(() {});
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                },
                                                controller: _controllerFunction(
                                                  controllerType: 'edu',
                                                  index: index,
                                                  count: 4,
                                                ),
                                                // focusNode: widget.professionFocusNode,
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
                                            edu[index].courses.length,
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
                                                    // _overlayController.toggle();
                                                    print(_overlayController
                                                        .isShowing);
                                                  },
                                                  onTapOutside: (event) {
                                                    setState(() {});
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                  },
                                                  onSubmitted: (value) {
                                                    setState(() {});
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                  },
                                                  controller:
                                                      _controllerFunction(
                                                    controllerType: 'courses',
                                                    index: index,
                                                    count: innerIndex,
                                                  ),
                                                  // focusNode: widget.professionFocusNode,
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
                                                      edu.insert(index,
                                                          edu.elementAt(index));
                                                    });
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
                                                      edu.removeAt(index);
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
                    Column(
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: _heightFunction(sectionType: 'workExp')
                                  .toDouble(),
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: workExp.length,
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
                                            TextField(
                                              onTap: () {
                                                setState(() {
                                                  _borderColorForWorkExp[
                                                          index] =
                                                      !_borderColorForWorkExp[
                                                          index];
                                                });
                                                // _overlayController.toggle();
                                                print(_overlayController
                                                    .isShowing);
                                              },
                                              onTapOutside: (event) {
                                                setState(() {});
                                                FocusScope.of(context)
                                                    .unfocus();
                                              },
                                              onSubmitted: (value) {
                                                setState(() {});
                                                FocusScope.of(context)
                                                    .unfocus();
                                              },
                                              controller: _controllerFunction(
                                                controllerType: 'workExp',
                                                index: index,
                                                count: 0,
                                              ),
                                              // focusNode: widget.professionFocusNode,
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
                                            TextField(
                                              maxLines: null,
                                              onTap: () {
                                                setState(() {
                                                  _borderColorForWorkExp[
                                                          index] =
                                                      !_borderColorForWorkExp[
                                                          index];
                                                });
                                                // _overlayController.toggle();
                                                print(_overlayController
                                                    .isShowing);
                                              },
                                              onTapOutside: (event) {
                                                setState(() {});
                                                FocusScope.of(context)
                                                    .unfocus();
                                              },
                                              onSubmitted: (value) {
                                                setState(() {});
                                                FocusScope.of(context)
                                                    .unfocus();
                                              },
                                              controller: _controllerFunction(
                                                controllerType: 'workExp',
                                                index: index,
                                                count: 1,
                                              ),
                                              // focusNode: widget.professionFocusNode,
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
                                                      // _overlayController.toggle();
                                                      print(_overlayController
                                                          .isShowing);
                                                    },
                                                    onTapOutside: (event) {
                                                      setState(() {});
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                    },
                                                    onSubmitted: (value) {
                                                      setState(() {});
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                    },
                                                    controller:
                                                        _controllerFunction(
                                                      controllerType: 'workExp',
                                                      index: index,
                                                      count: 2,
                                                    ),
                                                    // focusNode: widget.professionFocusNode,
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
                                                      // _overlayController.toggle();
                                                      print(_overlayController
                                                          .isShowing);
                                                    },
                                                    onTapOutside: (event) {
                                                      setState(() {});
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                    },
                                                    onSubmitted: (value) {
                                                      setState(() {});
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                    },
                                                    controller:
                                                        _controllerFunction(
                                                      controllerType: 'work',
                                                      index: index,
                                                      count: 4,
                                                    ),
                                                    // focusNode: widget.professionFocusNode,
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
                                                  // _overlayController.toggle();
                                                  print(_overlayController
                                                      .isShowing);
                                                },
                                                onTapOutside: (event) {
                                                  setState(() {});
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                },
                                                onSubmitted: (value) {
                                                  setState(() {});
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                },
                                                controller: _controllerFunction(
                                                  controllerType: 'workExp',
                                                  index: index,
                                                  count: 5,
                                                ),
                                                // focusNode: widget.professionFocusNode,
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
                                                          workExp.insert(
                                                              index,
                                                              workExp.elementAt(
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
                                                          workExp
                                                              .removeAt(index);
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
                                            skills.length,
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
                                                        skills[index],
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
                                                            skills.removeAt(
                                                                index);
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
                                          skills.length,
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
                                                skills[index],
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
                                            personalProjects.length,
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
                                                        personalProjects[index],
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
                                                            personalProjects
                                                                .removeAt(
                                                                    index);
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
                                    personalProjects.length,
                                    (index) {
                                      return Column(
                                        children: [
                                          Text(
                                            personalProjects[index],
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
                                            languages.length,
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
                                                            languages[index]
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
                                                            languages[index]
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
                                                            languages.removeAt(
                                                                index);
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
                                    languages.length,
                                    (index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            languages[index].language,
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            languages[index].proficiency,
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
                                              interests.length,
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
                                                          interests[index],
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              interests
                                                                  .removeAt(
                                                                      index);
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
                                              interests.length,
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
                                                    interests[index],
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

class MyColumn extends StatelessWidget {
  const MyColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.12,
          width: double.infinity,
          color: const Color.fromARGB(255, 49, 60, 75),
          child: const Padding(
            padding: EdgeInsets.only(right: 30, left: 20, top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Yihun Alemayehu',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Flutter Developer',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        'Enthusiastic and innovative Junior Flutter Developer and Graphics Designer ready to bring a unique blend '
                        'of creativity and technical prowess to the Universe. Proficient in Flutter, Dart, and graphic designtools, '
                        'I specialize in crafting visually stunning and seamlessly functional mobile applications. With apassion for '
                        'user-centric design and a commitment to staying at the forefront of emerging technologies,I am eager to contribute '
                        'my skills and learn from experienced professionals in a collaborativeenvironment',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 6,
                        ),
                        overflow: TextOverflow.visible,
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/copy.jpg'),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.08,
          width: double.infinity,
          color: const Color.fromARGB(255, 34, 42, 51),
          child: const Padding(
            padding: EdgeInsets.only(right: 30, left: 20, top: 10, bottom: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: Colors.white,
                          size: 10,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'yankure01@gmail.com',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: Colors.white,
                          size: 10,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '+251 982 39 40 38',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.pin_drop,
                          color: Colors.white,
                          size: 10,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Addis Ababa, Ethiopia',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.gite,
                          color: Colors.white,
                          size: 10,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'github.com/Yihun-Alemayehu',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.dataset_linked_outlined,
                          color: Colors.white,
                          size: 10,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'linkedin.com/in/yihun-alemayehu',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.web_sharp,
                          color: Colors.white,
                          size: 10,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'yihun-alemayehu.netlify.com/app',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(right: 10, left: 20),
                // width: MediaQuery.of(context).size.width * 0.6,
                child: const Column(
                  children: [
                    Column(
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('EDUCATION'),
                            Text(
                              'Software Engineering',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Addis Ababa Science and Technology University',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '05/2022 - Present',
                                  style: TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                                Text(
                                  'Addis Ababa',
                                  style: TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                                SizedBox(
                                  width: 1,
                                ),
                              ],
                            ),
                            Text(
                              'Courses',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              'Internet programming',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              'Internet programming',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              'Internet programming',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              'Internet programming',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            )
                          ],
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mobile App Development',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'GDG AASTU',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '05/2022 - Present',
                                  style: TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                                Text(
                                  'Addis Ababa',
                                  style: TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                                SizedBox(
                                  width: 1,
                                ),
                              ],
                            ),
                            Text(
                              'Courses',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              'Internet programming',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              'Internet programming',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              'Internet programming',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              'Internet programming',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('WORK EXPERIENCE'),
                            Text(
                              'Flutter Developer',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Hex-labs',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '10/2023 - 01/2024',
                                  style: TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                                Text(
                                  'Remote',
                                  style: TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                                SizedBox(
                                  width: 1,
                                ),
                              ],
                            ),
                            Text(
                              'Achievements',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              'Improved Efficiency: Optimized widget rendering in a critical feature'
                              ' of the mobile app, reducing load times by 20% and enhancing overall user '
                              'experience.',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              'Implemented Payment Gateway Transition: Successfully'
                              'facilitated the transition from Telebirr to Chapa as the payment'
                              'gateway, streamlining transaction processes and enhancing'
                              'payment reliability.',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Flutter Developer',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Horan-software',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '08/2024 - 11/2024',
                                  style: TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                                Text(
                                  'Contract',
                                  style: TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                                SizedBox(
                                  width: 1,
                                ),
                              ],
                            ),
                            Text(
                              'Achievements',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              'Implemented Firebase Integration: Successfully integrated Firebase into'
                              'the application, enhancing real-time database management, user'
                              'authentication, and analytics capabilities, leading to improved app'
                              'performance and user engagement.',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Flutter Developer',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Yize-Tech Ethiopia',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '02/2023 - 09/2023',
                                  style: TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                                Text(
                                  'Remote',
                                  style: TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                                SizedBox(
                                  width: 1,
                                ),
                              ],
                            ),
                            Text(
                              'Achievements',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            Text(
                              'Implemented Complex UI Designs: Successfully developed and integrated intricate,'
                              'user-centric UI components, ensuring seamless functionality, responsiveness, and an'
                              'engaging user experience across diverse devices and screen sizes.',
                              style: TextStyle(
                                fontSize: 8,
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
                padding: const EdgeInsets.only(left: 20),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('SKILLS'),
                        Wrap(
                          spacing: 4,
                          children: [
                            Chip(
                              padding: EdgeInsets.all(0),
                              label: Text(
                                'Programming',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              padding: EdgeInsets.all(0),
                              label: Text(
                                'Flutter',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                'Dart',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                'Firebase',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                'Software development',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                'Figma',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                'State Management',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                'Graphics design',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                'Leadership',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                'Communication',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                'Photography',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('PERSONAL PROJECTS'),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // spacing: 4,
                          children: [
                            Text(
                              'Guadaye Mobile App',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              'AddisCart Mobile App',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              'GraceLink Mobile App',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              'Yize-chat Mobile App',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              'Nedemy Mobile App',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LANGUAGES'),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // spacing: 4,
                          children: [
                            Text(
                              'English',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              'Full Professional Proficient',
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                          ],
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Amharic',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Full Professional Proficient',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ]),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('INTERESTS'),
                        Wrap(
                          spacing: 4,
                          children: [
                            Chip(
                              padding: EdgeInsets.all(0),
                              label: Text(
                                'Space science',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                'programming',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                'photography',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                'reading',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                'Artificial Intelligence',
                                style: TextStyle(
                                  fontSize: 8,
                                ),
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
          ],
        ),
      ],
    );
  }
}
