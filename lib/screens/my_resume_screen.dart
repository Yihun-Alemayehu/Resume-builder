import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_resume/bloc/user_bloc.dart';
import 'package:my_resume/bloc/user_event.dart';
import 'package:my_resume/bloc/user_state.dart';
import 'package:my_resume/screens/resume_template.dart';
import 'package:my_resume/widgets/templates_list.dart';

class MyResumeScreen extends StatefulWidget {
  const MyResumeScreen({super.key});

  @override
  State<MyResumeScreen> createState() => _MyResumeScreenState();
}

class _MyResumeScreenState extends State<MyResumeScreen> {
  @override
  void initState() {
    context.read<UserDataBloc>().add(FetchUserData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Resume')),
      body: BlocBuilder<UserDataBloc, UserDataState>(
        builder: (context, state) {
          if (state is UserDataLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserDataLoaded) {
            final userData = state.userData;
            debugPrint(userData.toString());
            return GridView.builder(
              primary: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.7,
              ),
              itemCount: 1,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {
                    context
                        .read<UserDataBloc>()
                        .add(const DeleteUserData(id: 2));
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResumeTemplate(
                                userData: userData,
                              )),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          templates[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is UserDataError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     context.read<UserDataBloc>().add(FetchUserData());
      //   },
      //   child: const Icon(Icons.refresh),
      // ),
    );
  }
}
