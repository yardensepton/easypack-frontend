import 'package:easypack/providers/choose_date_range_provider.dart';
import 'package:easypack/widgets/auto_complete_field.dart';
import 'package:easypack/widgets/custom_date_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripPlannerPage extends StatefulWidget {
  const TripPlannerPage({super.key});

  @override
  _TripPlannerPageState createState() => _TripPlannerPageState();
}

class _TripPlannerPageState extends State<TripPlannerPage> {
  final TextEditingController _destinationController = TextEditingController();

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
              // child: AutoCompleteField(),
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
                onPressed: () {},
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
        return const CustomDatePickerDialog(
          // onSubmit: () {
          //   _onSubmit(context);
          // },
          // onCancel: () {
          //   Navigator.of(context).pop();
          // },
        );
      },
    );
  }

  // void _onSubmit(BuildContext context) {
  //   final dateRangeProvider =
  //       Provider.of<ChooseDateRangeProvider>(context, listen: false);
  //   dateRangeProvider.onSubmit();
  //   print(dateRangeProvider.startDate);
  //   print(dateRangeProvider.endDate);
  //   Navigator.of(context).pop();
  // }
}
