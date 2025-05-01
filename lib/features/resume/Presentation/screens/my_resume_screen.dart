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
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              height: 70.h,
              width: 375.w,
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.r),
                  bottomRight: Radius.circular(30.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'My Resume',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Flexible(
              child: BlocBuilder<UserDataBloc, TemplateDataState>(
                builder: (context, state) {
                  if (state is TemplateDataLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TemplateDataLoaded) {
                    if (state.userData.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/Icons/no_profile.png',
                              width: 140.w, height: 140.h),
                          SizedBox(height: 10.h),
                          Text(
                            'No Resume Found',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.color),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'You don\'t have a resume.When you create one,\n it will appear here.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          ),
                        ],
                      );
                    }
                    final userData = state.userData;
                    debugPrint(userData.toString());
                    return Align(
                      alignment: Alignment.topLeft,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            runAlignment: WrapAlignment.start,
                            direction: Axis.horizontal,
                            spacing: 10.w,
                            children: List.generate(
                              userData.length,
                              (index) {
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
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .288,
                                    width: MediaQuery.of(context).size.width *
                                        .416,
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          child: Image.asset(
                                            templates[
                                                userData[index].templateIndex],
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .2697,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .416,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                        Text(
                                          userData[index].templateName,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.color,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (state is TemplateDataError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
