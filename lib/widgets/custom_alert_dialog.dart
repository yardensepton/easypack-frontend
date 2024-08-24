import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final Icon icon;
  final Color iconColor;
  final Function onPressed;
  final String okBtnText;

  const CustomAlertDialog(
      {super.key,
      required this.content,
      required this.icon,
      required this.iconColor,
      required this.onPressed,
      required this.title,
      required this.okBtnText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          icon,
          const SizedBox(width: 8),
          Text(title),
        ],
      ),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onPressed();
            Navigator.of(context).pop();
          },
          child: Text(okBtnText),
        ),
      ],
    );
  }
}
