import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_resume/core/utils/custom_dialog.dart';
import 'package:my_resume/features/drawer/presentation/screens/app_drawer.dart';
import 'package:my_resume/features/drawer/presentation/screens/data_usage_screen.dart';
import 'package:my_resume/features/drawer/presentation/screens/privacy_policy_screen.dart';
import 'package:my_resume/features/drawer/presentation/screens/terms_and_conditions_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  String _exportFormat = 'PDF';
  bool _isLoggedIn = false; // Placeholder for login state
  String _userEmail = 'user@example.com'; // Placeholder for user email

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // Load settings from SharedPreferences
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
      _exportFormat = prefs.getString('exportFormat') ?? 'PDF';
      // TODO: Load actual login state and email from auth service
    });
  }

  // Save settings to SharedPreferences
  Future<void> _saveSetting(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    }
  }

  // Launch URL helper
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open $url')),
      );
    }
  }

  // Confirm data deletion
  void _confirmDeleteData(String type) {
    showDialog(
      context: context,
      builder: (context) => DialogUtils.buildDialog(
        context: context,
        title: 'Confirm $type Deletion',
        content: [
          Text(
            'Are you sure you want to $type? This action cannot be undone.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).dialogTheme.iconColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$type deleted successfully')),
              );
              // TODO: Implement actual deletion logic
            },
            child: Text(
              'Delete',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Show export format picker
  void _showExportFormatPicker() {
    showDialog(
      context: context,
      builder: (context) => DialogUtils.buildDialog(
        context: context,
        title: 'Select Export Format',
        content: [
          ListTile(
            title: Text(
              'PDF',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            onTap: () {
              setState(() {
                _exportFormat = 'PDF';
              });
              _saveSetting('exportFormat', 'PDF');
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text(
              'Word',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            onTap: () {
              setState(() {
                _exportFormat = 'Word';
              });
              _saveSetting('exportFormat', 'Word');
              Navigator.of(context).pop();
            },
          ),
        ],
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).dialogTheme.iconColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 24.r,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  Text(
                    'Settings',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  SizedBox(width: 24.w), // Placeholder for symmetry
                ],
              ),
            ),
            SizedBox(height: 20.h),
            // Content
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 5.h),
                children: [
                  /*// Account Settings
                  Text(
                    'Account',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Column(
                    children: [
                      ListTile(
                        minTileHeight: 26.h,
                        dense: true,
                        leading: Icon(
                          Icons.account_circle,
                        ),
                        title: Text(
                          _isLoggedIn ? _userEmail : 'Sign In',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () {
                          // TODO: Navigate to sign-in screen or handle sign-out
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(_isLoggedIn
                                  ? 'Sign out not implemented'
                                  : 'Sign in not implemented'),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        minTileHeight: 26.h,
                        dense: true,
                        leading: Icon(
                          Icons.edit,
                        ),
                        title: Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () {
                          // TODO: Navigate to profile edit screen
                          _launchUrl('https://resumebuilderapp.com/profile');
                        },
                      ),
                      ListTile(
                        minTileHeight: 26.h,
                        dense: true,
                        leading: Icon(
                          Icons.lock,
                        ),
                        title: Text(
                          'Reset Password',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () {
                          _launchUrl(
                              'https://resumebuilderapp.com/reset-password');
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),*/

                  // App Preferences
                  Text(
                    'Preferences',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Column(
                    children: [
                      ListTile(
                        minTileHeight: 26.h,
                        dense: true,
                        title: Text(
                          'Export Format',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: Text(
                          _exportFormat,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                        onTap: _showExportFormatPicker,
                      ),
                      ListTile(
                        minTileHeight: 26.h,
                        dense: true,
                        title: Text(
                          'Notifications',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: CustomSwitch(
                          value: _notificationsEnabled,
                          onChanged: (value) {
                            setState(() {
                              _notificationsEnabled = value;
                            });
                            _saveSetting('notificationsEnabled', value);
                            // TODO: Update notification settings
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // Data Management
                  Text(
                    'Data Management',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Column(
                    children: [
                      ListTile(
                        minTileHeight: 26.h,
                        dense: true,
                        leading: Icon(
                          Icons.delete,
                        ),
                        title: Text(
                          'Clear Cache',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () => _confirmDeleteData('Clear Cache'),
                      ),
                      ListTile(
                        minTileHeight: 26.h,
                        dense: true,
                        leading: Icon(
                          Icons.delete_forever,
                        ),
                        title: Text(
                          'Delete All Resumes',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () => _confirmDeleteData('Delete All Resumes'),
                      ),
                      ListTile(
                        minTileHeight: 26.h,
                        dense: true,
                        leading: Icon(
                          Icons.cloud_download,
                        ),
                        title: Text(
                          'Export Profile Data',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () {
                          // TODO: Implement data export
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Export not implemented')),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // Privacy and Security
                  Text(
                    'Privacy & Security',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  ListTile(
                    minTileHeight: 26.h,
                    dense: true,
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16.sp,
                    ),
                    title: Text(
                      'Data Usage',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, 
                        MaterialPageRoute(
                          builder: (context) => const DataUsageScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    minTileHeight: 26.h,
                    dense: true,
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16.sp,
                    ),
                    title: Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, 
                        MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    minTileHeight: 26.h,
                    dense: true,
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16.sp,
                    ),
                    title: Text(
                      'Terms of Service',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, 
                        MaterialPageRoute(
                          builder: (context) => const TermsAndConditionsScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20.h),

                  // Subscription Management
                  Text(
                    'Subscription',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Column(
                    children: [
                      ListTile(
                        minTileHeight: 26.h,
                        dense: true,
                        leading: Icon(
                          Icons.star,
                        ),
                        title: Text(
                          'Subscription Status',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: Text(
                          'Free', // TODO: Update with actual status
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onTap: () {
                          // TODO: Navigate to subscription details
                          _launchUrl(
                              'https://resumebuilderapp.com/subscription');
                        },
                      ),
                      ListTile(
                        minTileHeight: 26.h,
                        dense: true,
                        leading: Icon(
                          Icons.upgrade,
                        ),
                        title: Text(
                          'Upgrade to Premium',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () {
                          // TODO: Navigate to in-app purchase screen
                          _launchUrl('https://resumebuilderapp.com/upgrade');
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
