import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:flutter/material.dart';

class SelectRole extends StatelessWidget {
  final IconData? iconData;
  final Color? backgroundColor;
  final Color? iconColor;
  final String? title;
  final String? description;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectRole({
    Key? key,
    required this.iconData,
    required this.backgroundColor,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 260,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              strokeAlign: BorderSide.strokeAlignOutside,
              color: isSelected ? primaryColor : Colors.grey.shade200,
              width: isSelected ? 3 : 1.5,
            ),
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: backgroundColor,
                  ),
                  child: Icon(iconData, color: iconColor, size: 40),
                ),
              ),
              Text(
                title ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  description ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}