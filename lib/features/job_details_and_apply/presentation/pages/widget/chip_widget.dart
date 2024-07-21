import 'package:flutter/material.dart';
import 'package:cv_frontend/core/constants/appcolors.dart';

class ChipWidget extends StatelessWidget {
  final List<String> items;

  const ChipWidget({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: items.map((item) {
        return Chip(
          backgroundColor: whiteColor,
          label: Text(
            item,
            style: TextStyle(
              color: primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          side: BorderSide(color: primaryColor, width: 2),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        );
      }).toList(),
    );
  }
}