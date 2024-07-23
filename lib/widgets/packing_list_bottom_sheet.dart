import 'package:easypack/providers/packing_list_provider.dart';
import 'package:easypack/providers/trip_details_provider.dart';
import 'package:easypack/widgets/custom_alert_dialog.dart';
import 'package:easypack/widgets/snack_bars/error_snack_bar.dart';
import 'package:easypack/widgets/snack_bars/success_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PackingListBottomSheet extends StatefulWidget {
  final String tripId;

  const PackingListBottomSheet({super.key, required this.tripId});

  @override
  State<PackingListBottomSheet> createState() => _PackingListBottomSheetState();
}

class _PackingListBottomSheetState extends State<PackingListBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: mediaQueryData.viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Delete Packing List'),
                onTap: () {
                  _showDeleteListAlert(context, widget.tripId);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_forever, color: Colors.red),
                title: const Text('Delete Trip'),
                onTap: () {
                  _showDeleteTripAlert(context, widget.tripId);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showDeleteTripAlert(BuildContext context, String tripId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialog(
        title: 'Delete Trip',
        content: 'Are you sure you want to delete this trip?',
        icon: const Icon(Icons.help_outline, color: Colors.red),
        iconColor: Colors.red,
        okBtnText: 'Delete',
        onPressed: () {
          Navigator.pop(context);
          _deleteTrip(context, tripId);
          Navigator.pop(context);
        },
      );
    },
  );
}

void _showDeleteListAlert(BuildContext context, String tripId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialog(
        title: 'Delete Packing List',
        content: 'Are you sure you want to delete this Packing list?',
        icon: const Icon(Icons.help_outline, color: Colors.red),
        iconColor: Colors.red,
        okBtnText: 'Delete',
        onPressed: () {
          Navigator.pop(context);
          _deletePackingList(context, tripId);
        },
      );
    },
  );
}

Future<void> _deletePackingList(BuildContext context, String tripId) async {
  try {
    await Provider.of<PackingListProvider>(context, listen: false)
        .deletePackingListById(context, tripId);
  } catch (e) {
    if (context.mounted) {
      ErrorSnackBar.showErrorSnackBar(context, '$e');
    }
  }
}

Future<void> _deleteTrip(BuildContext context, String tripId) async {
  try {
    String? response =
        await Provider.of<TripDetailsProvider>(context, listen: false)
            .deleteTripById(tripId);
    if (context.mounted) {
      if (response != null) {
        ErrorSnackBar.showErrorSnackBar(context, response);
      } else {
        SuccessSnackBar.showSuccessSnackBar(context, "trip deleted");
      }
    }
  } catch (e) {
    if (context.mounted) {
      ErrorSnackBar.showErrorSnackBar(context, '$e');
    }
  }
}
