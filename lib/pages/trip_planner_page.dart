import 'package:easypack/providers/auth_user_provider.dart';
import 'package:easypack/providers/auto_complete_provider.dart';
import 'package:easypack/providers/choose_date_range_provider.dart';
import 'package:easypack/providers/create_trip_provider.dart';
import 'package:easypack/providers/create_user_provider.dart';
import 'package:easypack/providers/trip_details_provider.dart';
import 'package:easypack/utils/validators.dart';
import 'package:easypack/widgets/cities_bottom_sheet.dart';
import 'package:easypack/widgets/custom_date_picker_dialog.dart';
import 'package:easypack/widgets/date_field.dart';
import 'package:easypack/widgets/loading_button.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('New Trip'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 350.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      width: 350.0,
                      height: 56,
                      child: CitiesBottomSheet(),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 350.0,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: DateField(
                                icon: const Icon(LineIcons.planeDeparture,
                                    color: Color.fromARGB(255, 97, 97, 97)),
                                labelText: "Departure",
                                onTap: _showDatePickerDialog,
                                controller:
                                    Provider.of<ChooseDateRangeProvider>(
                                            context,
                                            listen: false)
                                        .startDateController),
                          ),
                          const SizedBox(width: 16.0),
                          Flexible(
                            flex: 1,
                            child: DateField(
                                icon: const Icon(LineIcons.planeArrival,
                                    color: Color.fromARGB(255, 97, 97, 97)),
                                labelText: "Return",
                                onTap: _showDatePickerDialog,
                                controller:
                                    Provider.of<ChooseDateRangeProvider>(
                                            context,
                                            listen: false)
                                        .endDateController),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: LoadingButton<CreateTripProvider>(
                        onPressed: _callCreateTrip,
                        buttonText: 'Create new trip',
                      ),
                    ),
                  ],
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
