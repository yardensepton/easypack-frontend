import 'package:easypack/providers/choose_date_range_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';


class CustomDatePickerDialog extends StatelessWidget {
  final void Function() onSubmit;
  final void Function() onCancel;

  const CustomDatePickerDialog({
    required this.onSubmit,
    required this.onCancel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Travel Dates'),
      content: SizedBox(
        width: 400,
        height: 350,
        child: Consumer<ChooseDateRangeProvider>(
          builder: (context, dateRangeProvider, _) => SfDateRangePicker(
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              dateRangeProvider.onSelectionChanged(args);
            },
            showActionButtons: true,
            minDate: DateTime.now(),
            selectionMode: DateRangePickerSelectionMode.range,
            initialSelectedRange: dateRangeProvider.selectedRange ??
                PickerDateRange(
                  DateTime.now(),
                  DateTime.now().add(const Duration(days: 3)),
                ),
            backgroundColor: Colors.white,
            startRangeSelectionColor: const Color.fromARGB(255, 11, 56, 94),
            endRangeSelectionColor: const Color.fromARGB(255, 11, 56, 94),
            rangeSelectionColor:
                const Color.fromARGB(255, 11, 56, 94).withOpacity(0.3),
            todayHighlightColor: const Color.fromARGB(255, 58, 95, 125),
            selectionTextStyle: const TextStyle(color: Colors.white),
            rangeTextStyle: const TextStyle(color: Colors.black),
            onSubmit: (Object? value) {
              onSubmit();
            },
            onCancel: () {
              onCancel();
            },
            headerStyle: const DateRangePickerHeaderStyle(
              textAlign: TextAlign.center,
              backgroundColor: Colors.white,
              textStyle: TextStyle(
                fontSize: 25,
                fontStyle: FontStyle.normal,
                letterSpacing: 2,
                color: Colors.black,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
