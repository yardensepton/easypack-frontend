import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String labelText;
  final TextInputType inputType;
  final IconData? icon;
  final String? Function(String?)? validator; 

  const InputField({
    super.key,
    required this.controller,
    this.onChanged,
    required this.labelText,
    required this.inputType,
    this.icon,
    this.validator, // Add validator parameter
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged, // No need for null check as it's optional
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
          prefixIcon: icon != null ? Icon(icon) : null,
        ),
        validator: validator, // Use validator parameter
      ),
    );
  }
}
