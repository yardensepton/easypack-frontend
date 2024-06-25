class FormatDate{
static String getformatDate(String dateString) {
  // Split the input date string
  List<String> dateParts = dateString.split('-');
  
  // Extract the day and month parts
  String day = dateParts[2];
  String month = dateParts[1];
  
  // Format as desired
  String formattedDate = '$day.$month';
  
  return formattedDate;
}

}

