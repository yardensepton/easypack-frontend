import 'package:easypack/utils/string_extentsion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
            SvgPicture.asset(
              'assets/icons/${category.addUnderscores().toLowerCase()}.svg',
              width: 30.0,
              height: 30.0,
              colorFilter: const ColorFilter.mode(
                  Color.fromRGBO(26, 35, 126, 1), BlendMode.srcIn),
            ),
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
