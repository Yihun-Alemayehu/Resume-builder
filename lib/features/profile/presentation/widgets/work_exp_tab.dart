import 'package:flutter/material.dart';
import 'package:my_resume/features/profile/presentation/widgets/my_textfield.dart';
import 'package:my_resume/features/resume/data/model/work_experience_model.dart';

class WorkExpTab extends StatefulWidget {
  const WorkExpTab({super.key});

  @override
  State<WorkExpTab> createState() => _WorkExpTabState();
}

class _WorkExpTabState extends State<WorkExpTab> {
  List<WorkExperience> _workExperience = [
    WorkExperience(
        jobTitle: 'job title',
        companyName: 'company Name',
        startDate: 'start Date',
        endDate: 'end Date',
        jobType: 'job Type',
        achievements: 'achievement or job description')
  ];

  TextEditingController dateRangeController = TextEditingController();

  Future<void> _selectDateRange() async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      dateRangeController.text =
          "${picked.start.toString().split(' ')[0]} - ${picked.end.toString().split(' ')[0]}";
    }
  }

  void _editWorkExp(int index) {
    // Create a list of controllers for courses
    // List<TextEditingController> courseControllers = _educationBackground[index]
    //     .courses
    //     .map((course) => TextEditingController(text: course))
    //     .toList();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text('Edit Work Experience'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTextField(
                  hintText: 'Job Title',
                  function: (val) {
                    setState(() {
                      _workExperience[index] = _workExperience[index].copyWith(
                        jobTitle: val,
                      );
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  hintText: 'Company Name',
                  function: (val) {
                    setState(() {
                      _workExperience[index] = _workExperience[index].copyWith(
                        companyName: val,
                      );
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  hintText: 'Job Type',
                  function: (val) {
                    setState(() {
                      _workExperience[index] = _workExperience[index].copyWith(
                        jobType: val,
                      );
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: dateRangeController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: _selectDateRange,
                      icon: const Icon(Icons.date_range),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    hintText: 'Select start and end date',
                    hintStyle: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                    border: const OutlineInputBorder(),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
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
      body: SingleChildScrollView(
        primary: true,
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: List.generate(_workExperience.length, (index) {
              return SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _workExperience[index].jobTitle,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _workExperience[index].companyName,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${_workExperience[index].startDate} - ${_workExperience[index].endDate}',
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  Text(
                                    _workExperience[index].jobType,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          color: Colors.grey.shade300,
                        ),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () => _editWorkExp(index),
                              child: const Text(
                                'Edit',
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Delete education background at index
                                setState(() {
                                  _workExperience.removeAt(index);
                                });
                              },
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.red.shade300,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add education background
          setState(() {
            _workExperience.add(
              WorkExperience(
                jobTitle: 'job title',
                companyName: 'company Name',
                jobType: 'job type',
                startDate: 'start date',
                endDate: 'end date',
                achievements: 'achievement',
              ),
            );
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
