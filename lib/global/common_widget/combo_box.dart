import 'package:flutter/material.dart';

class ComboBoxField extends StatelessWidget {
  final String? selectedValue;
  final List<String> items;
  final IconData? icon;
  final String hint;
  final ValueChanged<String?>? onChanged;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;

  const ComboBoxField({
    Key? key,
    required this.selectedValue,
    required this.items,
    required this.hint,
    this.icon,
    required this.onChanged,
    this.focusNode,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: selectedValue,
      validator: validator,
      builder: (FormFieldState<String> state) {
        final correctedSelectedValue = state.value != null && items.contains(state.value)
            ? state.value
            : null;

        return InputDecorator(
          decoration: InputDecoration(
            prefixIcon: icon != null ? Icon(icon) : null,
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2.0,
              ),
            ),
            errorText: state.hasError ? state.errorText : null,
          ),
          isEmpty: correctedSelectedValue == null,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: correctedSelectedValue,
              isDense: true,
              focusNode: focusNode,
              onChanged: (newValue) {
                state.didChange(newValue);
                if (onChanged != null) {
                  onChanged!(newValue);
                }
              },
              dropdownColor: Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 36.0, // Adjust icon size
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16),
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
