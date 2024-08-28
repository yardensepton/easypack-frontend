import 'package:flutter/material.dart';

class DateField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final Icon icon;
  final void Function(BuildContext context) onTap;

  const DateField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.onTap,
    required this.icon

  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: () => onTap(context),
      decoration: InputDecoration(
        prefixIcon: icon,
        labelText: labelText,
        filled: true,
        fillColor:  Colors.grey[200]!,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }
}
