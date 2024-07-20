import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hint;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final bool? obscureText;
  final bool? readOnly;
  final bool? autofocus;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;

  const InputField({
    Key? key,
    required this.controller,
    this.prefixIcon,
    required this.hint,
    this.validator,
    this.textInputType,
    this.suffixIcon,
    this.obscureText,
    void Function(String value)? onChanged,
    this.readOnly,
    this.autofocus,
    this.onFieldSubmitted,
    this.focusNode,
    this.textInputAction,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      autofocus: autofocus ?? false,
      readOnly: readOnly ?? false,
      controller: controller,
      keyboardType: textInputType ?? TextInputType.text,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: Colors.grey[200], // Adjust shade of grey as desired
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ), // Adjust padding
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0), // Adjust corner radius
          borderSide:
              const BorderSide(color: Colors.transparent), // Remove border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0), // Adjust corner radius
          borderSide: const BorderSide(
            color: Colors.transparent,
          ), // Remove border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0), // Adjust corner radius
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2.0,
          ), // Optional highlight border
        ),
      ),
      validator: validator,
    );
  }
}
