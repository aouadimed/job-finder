import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  final String? path;
  final double? height;
  final String? text;
  final double? fontsize;
const LoginHeader({Key? key,this.path, this.height, required this.text, this.fontsize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 36, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Center the column
        children: [
          Image(
            image: AssetImage(
              path ?? "assets/images/logo.webp", // Providing a default value in case path is null
            ), 
            height: height ?? 100.0, // Providing a default height if height is null
          ),
         const SizedBox(height: 20.0), // Optional spacing between logo and text
          Text(
            text ?? "Create New Account",
            style:  TextStyle(
              fontSize: fontsize ?? 28.0, // Increase font size
              fontWeight: FontWeight.w600, // Optional: Add boldness
            ),
            textAlign: TextAlign.center, // Center the text
          ),
        ],
      ),
    );
  }
}
