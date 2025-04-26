import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showCustomSnackbar(BuildContext context, String message, Color color) {
  final snackBar = SnackBar(
    content: SizedBox(
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.white, size: 10),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              message,
              maxLines: 2,
              overflow: TextOverflow.visible,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          GestureDetector(
            onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 18,
            ),
          ),
        ],
      ),
    ),
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.r),
    ),
    duration: const Duration(seconds: 3),
    elevation: 6,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showCustomErrorSnackbar(BuildContext context, String message, Color color) {
  final snackBar = SnackBar(
    content: SizedBox(
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.white, size: 10),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              message,
              maxLines: 2,
              overflow: TextOverflow.visible,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          GestureDetector(
            onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 18,
            ),
          ),
        ],
      ),
    ),
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.r),
    ),
    duration: const Duration(seconds: 3),
    elevation: 6,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showCustomSuccessSnackbar(BuildContext context, String message, Color color) {
  final snackBar = SnackBar(
    content: SizedBox(
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.white, size: 10),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              message,
              maxLines: 2,
              overflow: TextOverflow.visible,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          GestureDetector(
            onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 18,
            ),
          ),
        ],
      ),
    ),
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.r),
    ),
    duration: const Duration(seconds: 3),
    elevation: 6,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
