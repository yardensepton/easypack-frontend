import 'package:easypack/providers/auto_complete_provider.dart';
import 'package:easypack/providers/choose_date_range_provider.dart';
import 'package:easypack/providers/create_trip_provider.dart';
import 'package:easypack/utils/validators.dart';
import 'package:easypack/widgets/cities_bottom_sheet.dart';
import 'package:easypack/widgets/custom_date_picker_dialog.dart';
import 'package:easypack/widgets/snack_bars/error_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class TripPlannerPage extends StatefulWidget {
  const TripPlannerPage({super.key});

  @override
  _TripPlannerPageState createState() => _TripPlannerPageState();
}

class _TripPlannerPageState extends State<TripPlannerPage> {
  Future<void> _callCreateTrip() async {
    AutoCompleteProvider autoCompleteProvider =
        Provider.of<AutoCompleteProvider>(context, listen: false);
    ChooseDateRangeProvider dateRangeProvider =
        Provider.of<ChooseDateRangeProvider>(context, listen: false);

    CreateTripProvider createTripProvider =
        Provider.of<CreateTripProvider>(context, listen: false);

    if (Validators.isEmptyBool(dateRangeProvider.startDate) ||
        Validators.isEmptyBool(dateRangeProvider.endDate) ||
        autoCompleteProvider.selectedCity == null) {
      ErrorSnackBar.showErrorSnackBar(context, 'Please fill all the fields');
    } else {
      await createTripProvider.createTrip(
          context,
          autoCompleteProvider.selectedCity,
          dateRangeProvider.startDate,
          dateRangeProvider.endDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Your Trip'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              width: 350.0,
              height: 56, // Match the height of TextFormField
              child: CitiesBottomSheet(),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  _showDatePickerDialog(context);
                },
                icon: const Icon(Icons.date_range),
                label: const Text('Select Dates'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  _callCreateTrip();
                },
                icon: const Icon(Icons.save),
                label: const Text('Save Trip'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDatePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomDatePickerDialog();
      },
    );
  }
}
