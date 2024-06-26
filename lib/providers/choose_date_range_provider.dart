import 'package:easypack/utils/format_date.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ChooseDateRangeProvider with ChangeNotifier {
  String startDate = '';
  String endDate = '';
  PickerDateRange? selectedRange;
  bool isRange = true;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  final String format = 'yyyy-MM-dd';

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      selectedRange = args.value;
      isRange = true;
    } 
    notifyListeners();
  }

  void setDates(DateTime? valueStart, DateTime? valueEnd) {
    startDate = DateFormat(format).format(valueStart!);
    endDate = DateFormat(format).format(valueEnd ?? valueStart);
  }

  void clearControllers() {
    startDateController.text = 'Departure';
    endDateController.text = 'Return';
    startDate = '';
    endDate = '';
    selectedRange = null;
    notifyListeners();
  }

  void onSubmit() {
    if (selectedRange != null) {
      if (isRange) {
        setDates(selectedRange!.startDate, selectedRange!.endDate);
        startDateController.text = FormatDate.getformatDate(startDate);
        endDateController.text = FormatDate.getformatDate(endDate);
      } 
      notifyListeners();
      selectedRange=null;
    } else {
      clearControllers();
    }
  }
}
