import 'package:flutter/material.dart';
import 'package:my_resume/features/profile/data/model/user_profile_model.dart';
import 'package:my_resume/features/resume/data/model/education_model.dart';
import 'package:my_resume/features/resume/data/model/work_experience_model.dart';

class ResumeTwo extends StatefulWidget {
  final UserProfile userProfile;
  const ResumeTwo({super.key, required this.userProfile});

  @override
  State<ResumeTwo> createState() => _ResumeTwoState();
}

class _ResumeTwoState extends State<ResumeTwo> {
  List<TextEditingController> _fieldOfStudyControllers = [];
  List<TextEditingController> _institutionNameControllers = [];
  List<TextEditingController> _startDateControllers = [];
  List<TextEditingController> _endDateControllers = [];
  List<TextEditingController> _institutionAddressControllers = [];
  List<List<TextEditingController>> _coursesControllers = [];

  List<TextEditingController> _jobTitleControllers = [];
  List<TextEditingController> _companyNameControllers = [];
  List<TextEditingController> _workStartDateControllers = [];
  List<TextEditingController> _workEndDateControllers = [];
  List<TextEditingController> _workJobTypeControllers = [];
  List<TextEditingController> _workAchievementControllers = [];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    final List<EducationBackground> edu = widget.userProfile.education;
    final List<WorkExperience> workExp = widget.userProfile.workExperience;

    // Initialize controllers for education
    for (var eduEntry in edu) {
      _fieldOfStudyControllers
          .add(TextEditingController(text: eduEntry.fieldOfStudy));
      _institutionNameControllers
          .add(TextEditingController(text: eduEntry.institutionName));
      _startDateControllers
          .add(TextEditingController(text: eduEntry.startDate));
      _endDateControllers.add(TextEditingController(text: eduEntry.endDate));
      _institutionAddressControllers
          .add(TextEditingController(text: eduEntry.institutionAddress));

      // Initialize courses controllers
      List<TextEditingController> courseControllers = [];
      for (var course in eduEntry.courses) {
        courseControllers.add(TextEditingController(text: course));
      }
      _coursesControllers.add(courseControllers);
    }

    // Initialize controllers for work experience
    for (var work in workExp) {
      _jobTitleControllers.add(TextEditingController(text: work.jobTitle));
      _companyNameControllers
          .add(TextEditingController(text: work.companyName));
      _workStartDateControllers
          .add(TextEditingController(text: work.startDate));
      _workEndDateControllers.add(TextEditingController(text: work.endDate));
      _workJobTypeControllers.add(TextEditingController(text: work.jobType));
      _workAchievementControllers
          .add(TextEditingController(text: work.achievements));
    }
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    for (var controller in _fieldOfStudyControllers) controller.dispose();
    for (var controller in _institutionNameControllers) controller.dispose();
    for (var controller in _startDateControllers) controller.dispose();
    for (var controller in _endDateControllers) controller.dispose();
    for (var controller in _institutionAddressControllers) controller.dispose();
    for (var courseList in _coursesControllers) {
      for (var controller in courseList) {
        controller.dispose();
      }
    }
    for (var controller in _jobTitleControllers) controller.dispose();
    for (var controller in _companyNameControllers) controller.dispose();
    for (var controller in _workStartDateControllers) controller.dispose();
    for (var controller in _workEndDateControllers) controller.dispose();
    for (var controller in _workJobTypeControllers) controller.dispose();
    for (var controller in _workAchievementControllers) controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Education Fields
                for (int i = 0; i < _fieldOfStudyControllers.length; i++)
                  Column(
                    children: [
                      TextField(
                          controller: _fieldOfStudyControllers[i],
                          decoration:
                              InputDecoration(labelText: "Field of Study")),
                      TextField(
                          controller: _institutionNameControllers[i],
                          decoration:
                              InputDecoration(labelText: "Institution Name")),
                      TextField(
                          controller: _startDateControllers[i],
                          decoration: InputDecoration(labelText: "Start Date")),
                      TextField(
                          controller: _endDateControllers[i],
                          decoration: InputDecoration(labelText: "End Date")),
                      TextField(
                          controller: _institutionAddressControllers[i],
                          decoration: InputDecoration(
                              labelText: "Institution Address")),
                      for (int j = 0; j < _coursesControllers[i].length; j++)
                        TextField(
                            controller: _coursesControllers[i][j],
                            decoration:
                                InputDecoration(labelText: "Course ${j + 1}")),
                      SizedBox(height: 20),
                    ],
                  ),

                // Work Experience Fields
                for (int i = 0; i < _jobTitleControllers.length; i++)
                  Column(
                    children: [
                      TextField(
                          controller: _jobTitleControllers[i],
                          decoration: InputDecoration(labelText: "Job Title")),
                      TextField(
                          controller: _companyNameControllers[i],
                          decoration:
                              InputDecoration(labelText: "Company Name")),
                      TextField(
                          controller: _workStartDateControllers[i],
                          decoration: InputDecoration(labelText: "Start Date")),
                      TextField(
                          controller: _workEndDateControllers[i],
                          decoration: InputDecoration(labelText: "End Date")),
                      TextField(
                          controller: _workJobTypeControllers[i],
                          decoration: InputDecoration(labelText: "Job Type")),
                      TextField(
                          controller: _workAchievementControllers[i],
                          decoration:
                              InputDecoration(labelText: "Achievements")),
                      SizedBox(height: 20),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
