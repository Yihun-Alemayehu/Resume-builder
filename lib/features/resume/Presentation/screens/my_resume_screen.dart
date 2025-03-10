import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_resume/features/resume/Presentation/bloc/user_bloc.dart';
import 'package:my_resume/features/resume/Presentation/bloc/user_event.dart';
import 'package:my_resume/features/resume/Presentation/bloc/user_state.dart';
import 'package:my_resume/features/resume/Presentation/screens/resume_template.dart';
import 'package:my_resume/features/resume/Presentation/widgets/templates_list.dart';

class MyResumeScreen extends StatefulWidget {
  const MyResumeScreen({super.key});

  @override
  State<MyResumeScreen> createState() => _MyResumeScreenState();
}

class _MyResumeScreenState extends State<MyResumeScreen> {
  @override
  void initState() {
    context.read<UserDataBloc>().add(FetchTemplateData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Resume')),
      body: BlocBuilder<UserDataBloc, TemplateDataState>(
        builder: (context, state) {
          if (state is TemplateDataLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TemplateDataLoaded) {
            final userData = state.userData;
            debugPrint(userData.toString());
            return GridView.builder(
              primary: true,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.all(8.0.r),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0.h,
                mainAxisSpacing: 8.0.w,
                childAspectRatio: 0.7,
              ),
              itemCount: userData.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {
                    context
                        .read<UserDataBloc>()
                        .add(const DeleteTemplateData(id: 2));
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResumeTemplate(
                                templateData: userData[index],
                                isNewTemplate: false,
                                index: index + 1,
                              )),
                    );
                  },
                  child: Card(
                    elevation: 5.r,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(1.0.r),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0.r),
                        child: Image.asset(
                          templates[userData[index].templateIndex],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is TemplateDataError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
