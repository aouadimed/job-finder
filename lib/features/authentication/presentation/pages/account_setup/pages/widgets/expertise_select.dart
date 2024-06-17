import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:flutter/material.dart';

class ExpertiseSelect extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  final bool isSelected;

  const ExpertiseSelect({
    Key? key,
    required this.text,
    required this.callback,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: callback,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                strokeAlign: BorderSide.strokeAlignOutside,
                width: 2,
                color: isSelected ? primaryColor : Colors.grey.shade200),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9.0),
                    color: isSelected ? primaryColor : Colors.transparent,
                    border: Border.all(color: primaryColor, width: 2),
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 15),
                Text(
                  text,

                  style: const TextStyle(
                    fontSize: 12,
                    
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
