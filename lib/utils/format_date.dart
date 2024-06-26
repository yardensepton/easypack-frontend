class FormatDate{
static String getformatDate(String dateString) {
  // Split the input date string
  List<String> dateParts = dateString.split('-');
  
  // Extract the day and month parts
  String day = dateParts[2];
  String month = dateParts[1];
  String year = dateParts[0];
  var formatYear = year.substring(year.length - 2);
  
  // Format as desired
  String formattedDate = '$day.$month.$formatYear';
  
  return formattedDate;
}

}

