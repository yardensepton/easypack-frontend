extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String lowerCase() {
    return "${this[0].toLowerCase()}${substring(1).toLowerCase()}";
  }

  String removeUnderscores() {
    return replaceAll('_', ' ').capitalize();
  }

  String addUnderscores() {
    return replaceAll(' ', '_').capitalize();
  }
}
