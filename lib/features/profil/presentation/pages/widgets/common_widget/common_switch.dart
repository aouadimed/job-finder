import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:flutter/material.dart';

class CommonSwitch extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  final String title;

  const CommonSwitch(
      {super.key,
      required this.value,
      required this.onChanged,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(width: 15),
        Switch(
            value: value,
            thumbColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return whiteColor;
              }
              return whiteColor;
            }),
            trackColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return primaryColor;
              }
              return greyColor.withOpacity(0.5);
            }),
            trackOutlineWidth: MaterialStateProperty.all(0),
            onChanged: (value) {
              onChanged(value);
            }),
      ],
    );
  }
}
