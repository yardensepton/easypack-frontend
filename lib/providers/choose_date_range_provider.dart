import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ChooseDateRangeProvider with ChangeNotifier {
  String startDate = '';
  String endDate = '';
  PickerDateRange? selectedRange;
  DateTime? oneDaySelected;
  bool isRange = true;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  final String format = 'yyyy-MM-dd';

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      selectedRange = args.value;
      isRange = true;
    } else if (args.value is DateTime) {
      oneDaySelected = args.value;
      isRange = false;
    }
    notifyListeners();
  }

  void setDates(DateTime? valueStart, DateTime? valueEnd) {
    startDate = DateFormat(format).format(valueStart!);
    endDate = DateFormat(format).format(valueEnd ?? valueStart);
  }

  void setDateRange() {
    selectedRange ??= PickerDateRange(
        DateTime.now(), DateTime.now().add(const Duration(days: 3)));
  }

  void onSubmit() {
    if (isRange) {
      setDateRange();
      setDates(selectedRange!.startDate, selectedRange!.endDate);
      startDateController.text = startDate;
      endDateController.text = endDate;
    } else {
      startDate = DateFormat(format).format(oneDaySelected!);
      endDate = DateFormat(format).format(oneDaySelected!);
    }
    notifyListeners();
  }
}
