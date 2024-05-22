class Validators {
  static String? validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty || value.trim().isEmpty) {
      return "$fieldName can't be empty";
    }
    return null;
  }
}
