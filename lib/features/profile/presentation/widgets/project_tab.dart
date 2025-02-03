import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_resume/features/profile/data/model/project_model.dart';
import 'package:my_resume/features/profile/presentation/cubit/user_profile_data_cubit.dart';
import 'package:my_resume/features/profile/presentation/widgets/my_textfield.dart';

class ProjectTab extends StatefulWidget {
  const ProjectTab({super.key});

  @override
  State<ProjectTab> createState() => _ProjectTabState();
}

class _ProjectTabState extends State<ProjectTab> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void _editProject({required int index, required ProjectModel project}) {
    nameController.text = project.name;
    descriptionController.text = project.description;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text('Edit Project'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTextField(
                  controller: nameController,
                  hintText: 'Project Name',
                  function: (val) {
                    setState(() {
                      nameController.text = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: descriptionController,
                  hintText: 'Project Description',
                  function: (val) {
                    setState(() {
                      descriptionController.text = val;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  context.read<UserProfileDataCubit>().updatePersonalProject(
                      index: index,
                      project: ProjectModel(
                          name: nameController.text,
                          description: descriptionController.text));
                  print(
                      '-------------------------------- PROJECT --------------------------------');
                  print(nameController.text);
                  print(descriptionController.text);
                  print(
                      '-------------------------------- PROJECT --------------------------------');
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
                  children: List.generate(userProfile.personalProjects.length,
                      (index) {
                    return SizedBox(
                      width: double.infinity,
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userProfile.personalProjects[index].name,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    userProfile
                                        .personalProjects[index].description,
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
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
                                    onPressed: () => _editProject(
                                        index: index,
                                        project: userProfile
                                            .personalProjects[index]),
                                    child: const Text(
                                      'Edit',
                                      style: TextStyle(
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Delete Language at index
                                      setState(() {
                                        context
                                            .read<UserProfileDataCubit>()
                                            .removePersonalProject(
                                                index: index);
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
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add project
          setState(() {
            context.read<UserProfileDataCubit>().addPersonalProject(
                  project: ProjectModel(
                    name: 'project Name',
                    description: 'project description',
                  ),
                );
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
