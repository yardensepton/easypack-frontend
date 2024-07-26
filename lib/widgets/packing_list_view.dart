import 'package:easypack/enums/enum_actions.dart';
import 'package:easypack/models/item_list.dart';
import 'package:easypack/providers/packing_list_provider.dart';
import 'package:easypack/utils/string_extentsion.dart';
import 'package:easypack/widgets/btn_create_packing_list.dart';
import 'package:easypack/widgets/custom_text_container.dart';
import 'package:easypack/widgets/group_seperator_category.dart';
import 'package:easypack/widgets/item_tile_in_packing_list.dart';
import 'package:easypack/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class PackingListView extends StatelessWidget {
  final String tripId;
  final String tripTitle;
  final bool isMobile;

  const PackingListView(
      {super.key,
      required this.tripId,
      required this.isMobile,
      required this.tripTitle});

  @override
  Widget build(BuildContext context) {
    return Consumer<PackingListProvider>(
      builder: (context, packingListProvider, child) {
        String? description =
            packingListProvider.currentPackingList?.description;
        List<ItemList> items =
            packingListProvider.currentPackingList?.items ?? [];
        if (packingListProvider.isLoading) {
          return const Center(child: LoadingWidget());
        }
        if (packingListProvider.currentPackingList == null) {
          return Column(
            children: [
              const SizedBox(height: 10),
              BtnCreatePackingList(
                tripId: tripId,
                tripTitle: tripTitle,
                isMobile: isMobile,
              ),
            ],
          );
        }
        return Column(
          children: [
            const SizedBox(height: 10),
            if (description != null)
              CustomTextContainer(description: description),
            Container(
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
              child: SlidableAutoCloseBehavior(
                closeWhenOpened: true,
                child: GroupedListView<ItemList, String>(
                  elements: items,
                  groupBy: (item) => item.category,
                  groupSeparatorBuilder: (String category) =>
                      GroupSeperatorCategory(category: category),
                  itemBuilder: (context, item) {
                    return Slidable(
                      key: Key(item.itemName),
                      // startActionPane: ActionPane(
                      //   motion: const StretchMotion(),
                      //   children: [
                      //     SlidableAction(
                      //       backgroundColor: Colors.green,
                      //       icon: Icons.add,
                      //       label: 'Add',
                      //       onPressed: (context) {
                      //         onDismissed(context, item, EnumActions.add,
                      //             packingListProvider);
                      //       },
                      //     )
                      //   ],
                      // ),
                      endActionPane: ActionPane(
                        motion: const StretchMotion(),
                        children: [
                          SlidableAction(
                            backgroundColor: Colors.red,
                            icon: Icons.delete,
                            label: 'Remove',
                            onPressed: (context) {
                              onDismissed(context, item, EnumActions.remove,
                                  packingListProvider);
                            },
                          )
                        ],
                      ),
                      child: Builder(builder: (context) {
                        return ItemTileInPackingList(
                          initialPackedState: item.isPacked,
                          amount: item.amountPerTrip,
                          name: item.itemName,
                          onChanged: (value) {
                            item.isPacked = value!;
                            packingListProvider.updateCheckBoxInPackingList(tripId,item);
                          },
                          packingListProvider: packingListProvider,
                          // onTap: handleOpenCloseSlides(context),
                        );
                      }),
                    );
                  },
                  order: GroupedListOrder.ASC,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void onDismissed(BuildContext context, ItemList item, EnumActions action,
      PackingListProvider provider) async {
    await provider.updatePackingList(tripId, action, item);
  }
}

void handleOpenCloseSlides(BuildContext context) {
  final slidable = Slidable.of(context)!;
  final isClosed = slidable.actionPaneType.value == ActionPaneType.none;
  if (isClosed) {
    slidable.openStartActionPane();
  } else {
    slidable.close();
  }
}

