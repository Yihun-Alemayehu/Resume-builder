import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_resume/core/utils/custom_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportUtils {
  static const String supportEmail = 'resumebuilderapphelpcenter@gmail.com';

  // Launch email client or show fallback
  static Future<void> launchSupportEmail(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: supportEmail,
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        // Fallback: Copy email to clipboard
        await _showEmailFallback(context);
      }
    } catch (e) {
      print('Error launching email: $e');
      await _showEmailFallback(context);
    }
  }

  // Encode query parameters to handle spaces and special characters
  static String _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value)}')
        .join('&');
  }

  // Show dialog to copy email to clipboard
  static Future<void> _showEmailFallback(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: supportEmail));
    showDialog(
      context: context,
      builder: (context) => DialogUtils.buildDialog(
        context: context,
        title: 'Email Client Unavailable',
        content: [
          Text(
            'No email client found. The support email ($supportEmail) has been copied to your clipboard. Paste it into your preferred email app.',
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
              'OK',
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
}
