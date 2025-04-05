import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_resume/core/Theme/bloc/theme_bloc.dart';
import 'package:my_resume/features/profile/data/db/user_profile_database_helper.dart';
import 'package:my_resume/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:my_resume/features/profile/presentation/cubit/user_profile_data_cubit.dart';
import 'package:my_resume/features/resume/Presentation/bloc/user_bloc.dart';
import 'package:my_resume/features/resume/data/db/db_helper.dart';
import 'package:my_resume/features/resume/Presentation/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load the saved theme mode from SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
  runApp(ResumeApp(
    isDarkMode: isDarkMode,
  ));
}

class ResumeApp extends StatelessWidget {
  final bool isDarkMode;
  const ResumeApp({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserDataBloc(dbHelper: const DatabaseHelper()),
        ),
        BlocProvider(
          create: (context) =>
              UserProfileBloc(dbHelper: const UserProfileDatabaseHelper()),
        ),
        BlocProvider(
          create: (context) =>
              UserProfileDataCubit(dbHelper: const UserProfileDatabaseHelper()),
        ),
        BlocProvider(create: (context) => ThemeBloc(isDarkMode: isDarkMode)),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 820),
        builder: (context, child) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                theme: state.themeData,
                debugShowCheckedModeBanner: false,
                home: const MainScreen(0),
              );
            },
          );
        },
      ),
    );
  }
}
