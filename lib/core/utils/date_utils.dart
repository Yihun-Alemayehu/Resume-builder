import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateUtils {
  // Format a date string to "MMMM yyyy" (e.g., "May 2025")
  static String formatMonthYear(String? dateString) {
    if (dateString == null || dateString.isEmpty || dateString == 'Present') {
      return 'Present';
    }
    try {
      final DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(dateString);
      return DateFormat('MMMM yyyy').format(parsedDate);
    } catch (e) {
      return 'Invalid Date';
    }
  }

  // Parse a date string to DateTime
  static DateTime? parseDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return null;
    }
    try {
      return DateFormat('yyyy-MM-dd').parse(dateString);
    } catch (e) {
      return null;
    }
  }

  // Format DateTime to "yyyy-MM-dd" for storage
  static String formatForStorage(DateTime? date) {
    if (date == null) {
      return '';
    }
    return DateFormat('yyyy-MM-dd').format(date);
  }

  // Select date range and update controller
  static Future<void> selectDateRange({
    required BuildContext context,
    required TextEditingController controller,
    required Function(DateTime?, DateTime?) onDatesSelected,
  }) async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2120),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            primaryColor: Theme.of(context).dialogTheme.iconColor,
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Theme.of(context).dialogTheme.iconColor,
                ),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // Update callback with raw DateTime objects
      onDatesSelected(picked.start, picked.end);
      // Format for display
      final DateFormat formatter = DateFormat('MMMM yyyy');
      String formattedStart = formatter.format(picked.start);
      String formattedEnd = formatter.format(picked.end);
      controller.text = '$formattedStart - $formattedEnd';
    }
  }
}
