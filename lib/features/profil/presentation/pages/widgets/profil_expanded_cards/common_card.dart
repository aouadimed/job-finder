import 'package:flutter/material.dart';
import 'package:cv_frontend/core/constants/appcolors.dart';

class CommonCard extends StatelessWidget {
  final VoidCallback? onCardPressed;
  final String headerTitle;
  final IconData headerIcon;

  const CommonCard({
    Key? key,
    required this.onCardPressed,
    required this.headerTitle,
    required this.headerIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0.4, color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(25),
      ),
      child: InkWell(
        onTap: onCardPressed,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          height: 56, // Set a fixed height for the card
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Icon(headerIcon, color: primaryColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  headerTitle,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
