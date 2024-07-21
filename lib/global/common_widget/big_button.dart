import 'package:flutter/material.dart';
import 'package:cv_frontend/core/constants/appcolors.dart';

class BigButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? textColor;

  const BigButton({super.key, required this.text, required this.onPressed, this.color, this.textColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width, 
      height: 50.0, 
      child: ElevatedButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          if (onPressed != null) {
            onPressed!();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Text(
          text ?? '',
          style:  TextStyle(
            color: textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
