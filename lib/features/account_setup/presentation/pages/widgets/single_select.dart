import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:flutter/material.dart';

class SingleSelect extends StatelessWidget {
  const SingleSelect({
    Key? key,
    required this.isSelected,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  final bool isSelected;
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Container(
              width: 16.0,
              height: 16.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: primaryColor, width: 2.0), // Blue border
                color: isSelected ? primaryColor : Colors.transparent, 
                // Fill color based on isSelected
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              text,
              style: TextStyle(
                fontSize: 16.0,
                color: isSelected ? primaryColor : Colors.black, 
                // Change text color based on isSelected
              ),
            ),
          ],
        ),
      ),
    );
  }
}
