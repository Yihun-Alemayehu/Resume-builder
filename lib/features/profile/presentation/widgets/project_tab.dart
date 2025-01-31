import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_resume/features/profile/presentation/cubit/user_profile_data_cubit.dart';
import 'package:my_resume/features/profile/presentation/widgets/my_textfield.dart';

class ProjectTab extends StatefulWidget {
  const ProjectTab({super.key});

  @override
  State<ProjectTab> createState() => _ProjectTabState();
}

class _ProjectTabState extends State<ProjectTab> {
  final TextEditingController _controller = TextEditingController();

  void _addProject() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text('Add Project'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTextField(
                  hintText: 'Project Name',
                  function: (val) {
                    setState(() {
                      _controller.text = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  context
                      .read<UserProfileDataCubit>()
                      .addPersonalProject(project: _controller.text);
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
            return Wrap(
              spacing: 4,
              children: List.generate(
                userProfile.personalProjects.length,
                (index) {
                  return IntrinsicWidth(
                    child: Container(
                      height: 30,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      margin: const EdgeInsets.only(right: 4, bottom: 4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 73, 150, 159),
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            userProfile.personalProjects[index],
                            style: const TextStyle(
                                // fontSize: 16,
                                ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                context
                                    .read<UserProfileDataCubit>()
                                    .removePersonalProject(index: index);
                              });
                            },
                            child: const Icon(
                              Icons.close,
                              size: 14,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProject,
        child: const Icon(Icons.add),
      ),
    );
  }
}
