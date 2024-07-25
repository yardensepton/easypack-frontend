import 'package:flutter/material.dart';

class CustomTextContainer extends StatefulWidget {
  final String description;
  const CustomTextContainer({super.key, required this.description});

  @override
  State<CustomTextContainer> createState() => _CustomTextContainerState();
}

class _CustomTextContainerState extends State<CustomTextContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0, top: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        widget.description,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: Colors.indigo[900],
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }
}
