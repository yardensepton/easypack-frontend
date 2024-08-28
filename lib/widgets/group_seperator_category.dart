import 'package:easypack/utils/string_extentsion.dart';
import 'package:easypack/widgets/custom_svg.dart';
import 'package:flutter/material.dart';

class GroupSeperatorCategory extends StatelessWidget {
  final String category;
  const GroupSeperatorCategory({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomSvg(svgPath: 'assets/icons/${category.addUnderscores().toLowerCase()}.svg'),
            const SizedBox(width: 8.0),
            Text(
              category.capitalize().removeUnderscores(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.indigo[900],
              ),
            ),
          ],
        ),
        Divider(
          thickness: 1,
          height: 1,
          color: Colors.indigo[900],
        ),
      ],
    );
  }
}
