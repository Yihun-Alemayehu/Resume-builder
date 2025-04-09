import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final Function(String val) function;
  final TextEditingController? controller;
  const MyTextField({
    super.key,
    required this.hintText,
    required this.function,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 41.h,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          // isDense: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 199, 198, 198),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 199, 198, 198),
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
            color: Theme.of(context).textTheme.bodyMedium!.color!,
          ),
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        ),
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 12.sp,
          color: Theme.of(context).textTheme.bodyMedium!.color!,
        ),
        onChanged: function,
      ),
    );
  }
}
