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
    return Align(
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400.0,maxHeight: 100.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Card(
            child: ListTile(
              title: Text(cityName),
              onTap: () => onTap(placeId),
            ),
          ),
        ),
      ),
    );
  }
}
