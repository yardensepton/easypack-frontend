import 'package:easypack/models/item_list.dart';
import 'package:easypack/utils/string_extentsion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grouped_list/grouped_list.dart';

class PackingListView extends StatelessWidget {
  final List<ItemList> items;
  const PackingListView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: GroupedListView<ItemList, String>(
        elements: items,
        groupBy: (item) => item.category,
        groupSeparatorBuilder: (String category) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/${category.addUnderscores().toLowerCase()}.svg',
                  width: 30.0,
                  height: 30.0,
                  colorFilter:const ColorFilter.mode( Color.fromRGBO(26, 35, 126, 1), BlendMode.srcIn),
                ),
                const SizedBox(width: 8.0),
                Text(
                  category.capitalize().removeUnderscores(),
                  style:  TextStyle(
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
        ),
        itemBuilder: (context, item) {
          return ListTile(
            title: Text(item.itemName.capitalize()),
            trailing: Text('${item.amountPerTrip}'),
          );
        },
        order: GroupedListOrder.ASC,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
