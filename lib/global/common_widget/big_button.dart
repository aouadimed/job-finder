import 'package:flutter/material.dart';
import 'package:cv_frontend/core/constants/appcolors.dart';

class BigButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;

  const BigButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width, // Adjust width as desired
      height: 50.0, // Adjust height as desired
      child: ElevatedButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          if (onPressed != null) {
            onPressed!();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Text(
          text ?? '',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
