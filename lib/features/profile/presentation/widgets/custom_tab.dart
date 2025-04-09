import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTab extends StatelessWidget {
  final String text;
  final String iconPath;
  final bool isSelected;

  const CustomTab({
    required this.text,
    required this.iconPath,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 12.w, top: 6.h, bottom: 5),
      height: 30.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            color: Theme.of(context).textTheme.bodyLarge?.color,
            height: 16.h,
            width: 16.w,
          ),
          SizedBox(width: 6.w),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ],
      ),
    );
  }
}
