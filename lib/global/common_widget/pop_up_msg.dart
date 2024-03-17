import 'package:flutter/material.dart';

class PopUp extends StatelessWidget {
  const PopUp({Key? key}); // Fix the constructor

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message, // Use the message parameter
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method should not return any widget directly
    return Container(); // Return an empty container or any other widget if needed
  }
}
