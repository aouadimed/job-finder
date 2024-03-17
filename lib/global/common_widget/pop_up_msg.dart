import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required String message,
  Color? backgroundColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor ?? redColor,
      content: Text(
        message, // Use the message parameter
      ),
    ),
  );
}
