import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvg extends StatelessWidget {
  final String svgPath;
  CustomSvg({
    required this.svgPath,
  });

  Future<bool> _checkIfSvgExists(String path) async {
    try {
      await SvgPicture.asset(path, width: 0, height: 0);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkIfSvgExists(svgPath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data == true) {
          return SvgPicture.asset(
            svgPath,
            width: 30.0,
            height: 30.0,
            colorFilter: const ColorFilter.mode(
                Color.fromRGBO(26, 35, 126, 1), BlendMode.srcIn),
          );
        } else {
          return SvgPicture.asset(
            "assets/icons/new_category.svg",
            width: 30.0,
            height: 30.0,
            colorFilter: const ColorFilter.mode(
                Color.fromRGBO(26, 35, 126, 1), BlendMode.srcIn),
          );
        }
      },
    );
  }
}
