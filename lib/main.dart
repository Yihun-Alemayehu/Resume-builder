import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_resume/core/utils/app_theme.dart';
import 'package:my_resume/features/profile/data/db/user_profile_database_helper.dart';
import 'package:my_resume/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:my_resume/features/profile/presentation/cubit/user_profile_data_cubit.dart';
import 'package:my_resume/features/resume/Presentation/bloc/user_bloc.dart';
import 'package:my_resume/features/resume/data/db/db_helper.dart';
import 'package:my_resume/features/resume/Presentation/screens/main_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const ResumeApp(),
    ),
  );
}

class ResumeApp extends StatelessWidget {
  const ResumeApp({super.key});

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
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 820),
        builder: (context, child) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            theme: AppTheme.lightTheme, // Base light theme
            darkTheme: AppTheme.darkTheme, // Base dark theme
            themeMode:
                themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: const MainScreen(0),
          );
        },
      ),
    );
  }
}
