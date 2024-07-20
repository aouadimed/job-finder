import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:flutter/material.dart';

class CommanInputField extends StatelessWidget {
  final TextEditingController controller;
  final Widget? prefixIcon;
  final IconData? suffixIcon;
  final String? hint;
  final String title;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final bool? obscureText;
  final bool? readOnly;
  final void Function(String value)? onChanged;
  final void Function()? onTap;
  final Color? hintColor;
  final int? maxLines;
  final int? maxLength;
  final bool? enabled;
  final Color? textColor;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;

  const CommanInputField({
    Key? key,
    required this.controller,
    required this.title,
    this.prefixIcon,
    this.hint,
    this.validator,
    this.textInputType,
    this.suffixIcon,
    this.obscureText,
    this.readOnly,
    this.onChanged,
    this.hintColor,
    this.maxLines,
    this.onTap,
    this.enabled,
    this.textColor,
    this.focusNode,
    this.onFieldSubmitted, this.textInputAction, this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
            color: textColor ?? Colors.black,
          ),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          maxLength : maxLength,
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,
          enabled: enabled ?? true,
          maxLines: maxLines ?? 1,
          readOnly: readOnly ?? false,
          controller: controller,
          keyboardType: textInputType ?? TextInputType.text,
          textInputAction: textInputAction,
          obscureText: obscureText ?? false,
          onChanged: onChanged,
          onTap: readOnly == true ? onTap : null,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: Icon(suffixIcon, color: darkColor),
            hintText: hint,
            hintStyle: TextStyle(color: hintColor ?? Colors.grey[400]),
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ), // Remove border
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2.0,
              ),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
