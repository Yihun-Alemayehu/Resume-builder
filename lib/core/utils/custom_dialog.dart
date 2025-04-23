import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_resume/features/profile/presentation/widgets/my_textfield.dart';

class DialogUtils {
  // Styled text field for dialogs
  static Widget styledTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String hintText,
    required Function(String) onChanged,
    bool isDateField = false,
    VoidCallback? onDateTap,
    int maxLines = 1, // Default value for maxLines
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        SizedBox(height: 5.h),
        SizedBox(
          height: 41.h,
          child: isDateField
              ? TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: onDateTap,
                      icon: const Icon(
                        Icons.date_range,
                        color: Color.fromARGB(255, 199, 198, 198),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 199, 198, 198)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 199, 198, 198)),
                    ),
                    hintText: hintText,
                    hintStyle: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 199, 198, 198),
                    ),
                    border: const OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10.h),
                  ),
                  style: TextStyle(fontSize: 14.sp),
                )
              : MyTextField(
                  controller: controller,
                  hintText: hintText,
                  function: onChanged,
                ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  // Dialog save and cancel buttons
  static List<Widget> dialogActions({
    required BuildContext context,
    required VoidCallback onSave,
    required VoidCallback onCancel,
  }) {
    return [
      TextButton(
        onPressed: onSave,
        child: Text(
          'Save',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).dialogTheme.iconColor,
          ),
        ),
      ),
      TextButton(
        onPressed: onCancel,
        child: Text(
          'Cancel',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: Colors.red,
          ),
        ),
      ),
    ];
  }

  // Common dialog wrapper
  static Widget buildDialog({
    required BuildContext context,
    required String title,
    required List<Widget> content,
    required List<Widget> actions,
  }) {
    return AlertDialog(
      insetPadding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.13,
        left: 25.w,
        right: 25.w,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      title: Center(
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: content,
        ),
      ),
      actions: actions,
    );
  }
}
