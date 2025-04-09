import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_resume/core/utils/app_theme.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 90.h, horizontal: 10.w),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // Drawer Header (optional)
              Image.asset(
                'assets/Icons/logo-black.png',
                height: 120.h,
                width: 79.w,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  'Resume Builder',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              // Drawer items
              ListTile(
                title: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
                leading: Icon(Icons.settings, size: 24.sp),
                trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
                onTap: () {
                  // Add navigation logic here (e.g., Navigator.push())
                },
              ),
              ListTile(
                title: Text(
                  'Dark Mode',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
                leading: Icon(Icons.dark_mode_rounded, size: 24.sp),
                trailing: CustomSwitch(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme();
                  },
                ),
                onTap: () {
                  // Add navigation logic here (e.g., Navigator.push())
                },
              ),
              ListTile(
                title: Text(
                  'Help & Support',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
                leading: Icon(Icons.help_outline_outlined, size: 24.sp),
                trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
                onTap: () {
                  // Add navigation logic here (e.g., Navigator.push())
                },
              ),
              ListTile(
                title: Text(
                  'About',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
                leading: Icon(Icons.info_outline, size: 24.sp),
                trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
                onTap: () {
                  // Add navigation logic here (e.g., Navigator.push())
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSwitch extends StatefulWidget {
  final bool value;
  final Function(bool) onChanged;

  const CustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 40,
        height: 20,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: widget.value ? AppColors.accent : Colors.black,
        ),
        child: Align(
          alignment:
              widget.value ? Alignment.centerRight : Alignment.centerLeft,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
