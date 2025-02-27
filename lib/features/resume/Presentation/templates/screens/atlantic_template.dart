import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_resume/features/profile/data/model/award_model.dart';
import 'package:my_resume/features/profile/data/model/certificate_model.dart';
import 'package:my_resume/features/resume/data/model/education_model.dart';
import 'package:my_resume/features/resume/data/model/language_model.dart';
import 'package:my_resume/features/resume/data/model/templates_model.dart';
import 'package:my_resume/features/resume/data/model/work_experience_model.dart';

class AtlanticTemplate extends StatefulWidget {
  TemplateModel templateData;
  AtlanticTemplate({
    Key? key,
    required this.templateData,
  }) : super(key: key);

  @override
  State<AtlanticTemplate> createState() => AtlanticTemplateState();
}

class AtlanticTemplateState extends State<AtlanticTemplate> {
  late TemplateModel templateData;

  List<File> icons = [
    File('assets/Icons/mail.png'),
    File('assets/Icons/pin.png'),
    File('assets/Icons/linkedin.png'),
    File('assets/Icons/telephone.png'),
    File('assets/Icons/github.png'),
    File('assets/Icons/internet.png'),
    File('assets/Icons/briefcase.png'),
    File('assets/Icons/education.png'),
    File('assets/Icons/certificate1.png'),
    File('assets/Icons/award.png'),
    File('assets/Icons/skill2.png'),
    File('assets/Icons/project.png'),
    File('assets/Icons/language2.png'),
    File('assets/Icons/hobby.png'),
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
                        : _addCertificateController,
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
      padding: const EdgeInsets.all(10).copyWith(right: 4),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .4,
            child: Container(
              padding: const EdgeInsets.all(15).copyWith(left: 7),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 27, 49, 66),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _image == null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              pickImage();
                            },
                            child: Container(
                              height: 83,
                              width: 83,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    File(templateData.userData.profilePic.path)
                                            .existsSync()
                                        ? FileImage(File(widget.templateData
                                            .userData.profilePic.path))
                                        : const AssetImage('assets/copy.jpg')
                                            as ImageProvider,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          height: 83,
                          width: 83,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            backgroundImage: FileImage(_image!),
                          ),
                        ),
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
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
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
                    },
                    controller: _professionController,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
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

                  const SizedBox(height: 5),

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

                  const SizedBox(height: 10),
                  // EMAIL, ADDRESS, PHONE NUMBER AND LINKEDIN SECTION
                  Padding(
                    padding: const EdgeInsets.only(right: 3, left: 2),
                    child: SizedBox(
                      height: 70,
                      child: ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  _iconsList1[index],
                                  height: 10,
                                  width: 10,
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: TextField(
                                    onTapOutside: (event) {
                                      FocusScope.of(context).unfocus();
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        switch (index) {
                                          case 0:
                                            templateData =
                                                templateData.copyWith(
                                              userData: templateData.userData
                                                  .copyWith(
                                                email: value,
                                              ),
                                            );
                                            break;
                                          case 1:
                                            templateData =
                                                templateData.copyWith(
                                              userData: templateData.userData
                                                  .copyWith(
                                                address: value,
                                              ),
                                            );
                                            break;
                                          case 2:
                                            templateData =
                                                templateData.copyWith(
                                              userData: templateData.userData
                                                  .copyWith(
                                                phoneNumber: value,
                                              ),
                                            );
                                            break;
                                          case 3:
                                            templateData =
                                                templateData.copyWith(
                                              userData: templateData.userData
                                                  .copyWith(
                                                linkedIn: value,
                                              ),
                                            );
                                            break;
                                        }
                                      });
                                    },
                                    controller: _controllersList1[index],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                    ),
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.zero,
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // CERTIFICATES SECTION
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      templateData.certificates.isEmpty
                          ? Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 73, 150, 159)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'No Certificates provided',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 8,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        templateData = templateData.copyWith(
                                          certificates: [
                                            const CertificateModel(
                                                certificateName:
                                                    'Certificate Name',
                                                issuedDate: 'Issued date'),
                                          ],
                                        );
                                        _addCertificateEntry(
                                            certificate:
                                                templateData.certificates[0]);
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 73, 150, 159)),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Text(
                                          'Add Certificate',
                                          style: TextStyle(
                                              fontSize: 8, color: Colors.black),
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
                              itemCount: templateData.certificates.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: _borderColorForCertificate[index]
                                          ? const Color.fromARGB(
                                              255, 73, 150, 159)
                                          : const Color.fromARGB(
                                              255, 27, 49, 66),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          index == 0
                                              ? Container(
                                                  height: 25,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.35,
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 82, 103, 119),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const SizedBox(width: 5),
                                                      Image.asset(
                                                        'assets/Icons/certificate1.png',
                                                        width: 17,
                                                        height: 17,
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const Text(
                                                        'CERTIFICATES',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : const SizedBox(),
                                          const SizedBox(
                                            height: 5,
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
                                              FocusScope.of(context).unfocus();
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
                                            style: const TextStyle(
                                              color: Colors.white,
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
                                                      templateData.copyWith(
                                                    certificates: templateData
                                                        .certificates
                                                        .map((e) => e.copyWith(
                                                            issuedDate: value))
                                                        .toList(),
                                                  );
                                                });
                                              },
                                              controller:
                                                  issuedDateController[index],
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.grey.shade100,
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
                                          ),
                                        ],
                                      ),
                                      _borderColorForCertificate[index]
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
                                                        width: 2,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            _addCertificateEntry(
                                                                certificate:
                                                                    templateData
                                                                            .certificates[
                                                                        index]);

                                                            templateData
                                                                .certificates
                                                                .insert(
                                                                    index,
                                                                    templateData
                                                                        .certificates
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
                                                                    .circular(
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
                                                        width: 2,
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
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                      const SizedBox(
                                                        width: 2,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 3),
                                                ],
                                              ),
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                );
                              },
                            ),

                      const SizedBox(height: 30),

                      // LANGUAGE SECTION
                      _borderColorForLanguage
                          ? Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: _borderColorForLanguage
                                      ? const Color.fromARGB(255, 73, 150, 159)
                                      : const Color.fromARGB(255, 27, 49, 66),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 25,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 82, 103, 119),
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 5),
                                            Image.asset(
                                              'assets/Icons/language2.png',
                                              width: 17,
                                              height: 17,
                                            ),
                                            const SizedBox(width: 5),
                                            const Text(
                                              'LANGUAGES',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
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
                                                    height: 20,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5,
                                                        vertical: 2),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 4,
                                                            bottom: 4),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          templateData
                                                              .languages[index]
                                                              .language,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
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
                                                        BorderRadius.circular(
                                                            2),
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
                                  Container(
                                    height: 25,
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 82, 103, 119),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 5),
                                        Image.asset(
                                          'assets/Icons/language2.png',
                                          width: 17,
                                          height: 17,
                                        ),
                                        const SizedBox(width: 5),
                                        const Text(
                                          'LANGUAGES',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
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
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              templateData
                                                  .languages[index].proficiency,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.grey.shade100),
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
                        height: 10,
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * .56,
              child: Padding(
                  padding: const EdgeInsets.all(3).copyWith(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      height: 100,
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
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            'No Work Experience provided',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 8,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
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
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: const Color.fromARGB(
                                                        255, 73, 150, 159)),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(2.0),
                                                child: Text(
                                                  'Add Work Experience',
                                                  style: TextStyle(
                                                      fontSize: 8,
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
                                                      ? Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                239, 239, 239),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2),
                                                          ),
                                                          height: 30,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.58,
                                                          child: Row(
                                                            children: [
                                                              const SizedBox(
                                                                  width: 10),
                                                              Image.asset(
                                                                  'assets/Icons/briefcase.png',
                                                                  height: 17,
                                                                  width: 17),
                                                              const SizedBox(
                                                                  width: 5),
                                                              const Text(
                                                                'WORK EXPERIENCE',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : const SizedBox(),
                                                  const SizedBox(
                                                    height: 5,
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
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10,
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
                                                          style:
                                                              const TextStyle(
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontSize: 8,
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
                                                          style:
                                                              const TextStyle(
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontSize: 8,
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
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                          3)
                                                                      .copyWith(
                                                                          left:
                                                                              0),
                                                              child: Container(
                                                                height: 3,
                                                                width: 3,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.45,
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
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 8,
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
                                                                              2),
                                                                ),
                                                                height: 17,
                                                                width: 17,
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .arrow_downward_rounded,
                                                                  color: Colors
                                                                      .white,
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
                                                                        BorderRadius
                                                                            .circular(2),
                                                                  ),
                                                                  height: 17,
                                                                  width: 17,
                                                                  child:
                                                                      const Icon(
                                                                    Icons.copy,
                                                                    color: Colors
                                                                        .white,
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
                                                                        BorderRadius
                                                                            .circular(2),
                                                                  ),
                                                                  height: 17,
                                                                  width: 17,
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .delete_forever_rounded,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 15,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 2,
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
                                                                        BorderRadius
                                                                            .circular(2),
                                                                  ),
                                                                  height: 17,
                                                                  width: 17,
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .more_vert,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 15,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 3),
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
                                                                          .grey,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              2),
                                                                    ),
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.2,
                                                                    height: 17,
                                                                    child:
                                                                        const Center(
                                                                      child:
                                                                          Text(
                                                                        'Add Achievement',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize: 10),
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
                      const SizedBox(height: 20),
                      // EDUCATION SECTION
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          templateData.educationBackground.isEmpty
                              ? Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: 100,
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
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        'No education background provided',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
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
                                          child: const Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: Text(
                                              'Add Education',
                                              style: TextStyle(
                                                  fontSize: 8,
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
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 239, 239, 239),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2),
                                                      ),
                                                      height: 30,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.58,
                                                      child: Row(
                                                        children: [
                                                          const SizedBox(
                                                              width: 10),
                                                          Image.asset(
                                                              'assets/Icons/education.png',
                                                              height: 17,
                                                              width: 17),
                                                          const SizedBox(
                                                              width: 5),
                                                          const Text(
                                                            'EDUCATION',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                              const SizedBox(
                                                height: 5,
                                              ),

                                              // FIELD OF STUDY
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
                                                },
                                                controller:
                                                    fieldOfStudyControllers[
                                                        index],
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10,
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
                                                      style: const TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontSize: 8,
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
                                                      style: const TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontSize: 8,
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
                                                                          2),
                                                            ),
                                                            height: 17,
                                                            width: 17,
                                                            child: const Icon(
                                                              Icons
                                                                  .arrow_downward_rounded,
                                                              color:
                                                                  Colors.white,
                                                              size: 15,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 2,
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
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.grey,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2),
                                                              ),
                                                              height: 17,
                                                              width: 17,
                                                              child: const Icon(
                                                                Icons.copy,
                                                                color: Colors
                                                                    .white,
                                                                size: 15,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 2,
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
                                                                            2),
                                                              ),
                                                              height: 17,
                                                              width: 17,
                                                              child: const Icon(
                                                                Icons
                                                                    .delete_forever_rounded,
                                                                color: Colors
                                                                    .white,
                                                                size: 15,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 2,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 3),
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
                      const SizedBox(height: 20),
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
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 239, 239, 239),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.58,
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      Image.asset('assets/Icons/skill.png',
                                          height: 17, width: 17),
                                      const SizedBox(width: 5),
                                      const Text(
                                        'SKILLS',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
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
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 4,
                                                            bottom: 4),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.grey,
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
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount:
                                                1, // 2 items per row
                                            crossAxisSpacing:
                                                1, // Spacing between columns
                                            mainAxisSpacing:
                                                1, // Spacing between rows
                                            childAspectRatio:
                                                12, // Adjust this to control the height of the items
                                          ),
                                          itemCount: templateData.skills.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 2),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(3)
                                                            .copyWith(left: 0),
                                                    child: Container(
                                                      height: 3,
                                                      width: 3,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    templateData.skills[index],
                                                    style: const TextStyle(
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
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
                                              title: 'Add Skill',
                                              type: 'skills'),
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
                        height: 10,
                      ),
                    ],
                  )))
        ],
      ),
    );
  }
}
