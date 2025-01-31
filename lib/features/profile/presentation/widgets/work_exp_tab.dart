import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_resume/features/profile/presentation/cubit/user_profile_data_cubit.dart';
import 'package:my_resume/features/profile/presentation/widgets/my_textfield.dart';
import 'package:my_resume/features/resume/data/model/work_experience_model.dart';

class WorkExpTab extends StatefulWidget {
  const WorkExpTab({super.key});

  @override
  State<WorkExpTab> createState() => _WorkExpTabState();
}

class _WorkExpTabState extends State<WorkExpTab> {
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController jobTypeController = TextEditingController();
  TextEditingController dateRangeController = TextEditingController();
  TextEditingController achievementsController = TextEditingController();

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

  void _editWorkExp(
      {required int index, required WorkExperience workExperience}) {
    jobTitleController.text = workExperience.jobTitle;
    companyNameController.text = workExperience.companyName;
    jobTypeController.text = workExperience.jobType;
    achievementsController.text = workExperience.achievements;

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
                  controller: jobTitleController,
                  hintText: 'Job Title',
                  function: (val) {
                    setState(() {
                      jobTitleController.text = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: companyNameController,
                  hintText: 'Company Name',
                  function: (val) {
                    setState(() {
                      companyNameController.text = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: jobTypeController,
                  hintText: 'Job Type',
                  function: (val) {
                    setState(() {
                      jobTypeController.text = val;
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
                // Update work experience at index
                setState(() {
                  context.read<UserProfileDataCubit>().updateWorkExperience(
                        index: index,
                        workExperience: WorkExperience(
                          jobTitle: jobTitleController.text,
                          companyName: companyNameController.text,
                          startDate: dateRangeController.text
                              .toString()
                              .split(' -')[0],
                          endDate: dateRangeController.text
                              .toString()
                              .split(' -')[1],
                          jobType: jobTypeController.text,
                          achievements: achievementsController.text,
                        ),
                      );
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
            return SingleChildScrollView(
              primary: true,
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children:
                      List.generate(userProfile.workExperience.length, (index) {
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
                                    userProfile.workExperience[index].jobTitle,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    userProfile
                                        .workExperience[index].companyName,
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
                                          '${userProfile.workExperience[index].startDate} - ${userProfile.workExperience[index].endDate}',
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        Text(
                                          userProfile
                                              .workExperience[index].jobType,
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
                                    onPressed: () => _editWorkExp(
                                        index: index,
                                        workExperience:
                                            userProfile.workExperience[index]),
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
                                        context
                                            .read<UserProfileDataCubit>()
                                            .removeWorkExperience(index: index);
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
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add education background
          setState(() {
            context.read<UserProfileDataCubit>().addWorkExperience(
                  workExperience: WorkExperience(
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
