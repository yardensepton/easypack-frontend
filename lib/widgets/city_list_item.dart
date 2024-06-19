import 'package:flutter/material.dart';

class CityListItem extends StatelessWidget {
  final String cityName;
  final String placeId;
  final Function(String) onTap;

  const CityListItem({
    super.key,
    required this.cityName,
    required this.placeId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(cityName),
          onTap: () {
            onTap(placeId);
            Navigator.of(context).pop();
          } 
        ),
        const Divider(
          height: 1,
          color: Colors.grey,
        ),
      ],
    );
  }
}
