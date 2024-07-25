import 'package:easypack/enums/enum_actions.dart';
import 'package:easypack/models/item_list.dart';
import 'package:easypack/providers/packing_list_provider.dart';
import 'package:easypack/utils/string_extentsion.dart';
import 'package:easypack/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class PackingListView extends StatelessWidget {
  final String tripId;
  final List<ItemList> items;

  const PackingListView({super.key, required this.items, required this.tripId});

  @override
  Widget build(BuildContext context) {
    return Consumer<PackingListProvider>(
      builder: (context, packingListProvider, child) {
          if (packingListProvider.isLoading) {
          return const Center(child: LoadingWidget());
        }
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
                      colorFilter: const ColorFilter.mode(Color.fromRGBO(26, 35, 126, 1), BlendMode.srcIn),
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
            ),
            itemBuilder: (context, item) {
              return Slidable(
                startActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      backgroundColor: Colors.green,
                      icon: Icons.add,
                      label: 'Add',
                      onPressed: (context) {
                        onDismissed(context, item, EnumActions.add, packingListProvider);
                      },
                    )
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      backgroundColor: Colors.red,
                      icon: Icons.delete,
                      label: 'Remove',
                      onPressed: (context) {
                        onDismissed(context, item, EnumActions.remove, packingListProvider);
                      },
                    )
                  ],
                ),
                child: ListTile(
                  title: Text(item.itemName.capitalize()),
                  trailing: Text('${item.amountPerTrip}'),
                ),
              );
            },
            order: GroupedListOrder.ASC,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
        );
      },
    );
  }

  void onDismissed(BuildContext context, ItemList item, EnumActions action, PackingListProvider provider) async {
    await provider.updatePackingList(tripId, action, item);
  }
}
