import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class DateField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final void Function(BuildContext context) onTap;

  const DateField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: () => onTap(context),
      decoration: InputDecoration(
        prefixIcon: const Icon(LineIcons.calendar, color: Color.fromARGB(255, 97, 97, 97)),
        labelText: labelText,
        filled: true,
        fillColor: const Color.fromARGB(255, 240, 232, 245),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }
}
