class Validators {
  static String? validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty || value.trim().isEmpty) {
      return "$fieldName can't be empty";
    }
    return null;
  }

  static String? validateEmailPattern(String? value) {
    validateNotEmpty(value,'email');
    // Regex for email validation
    const pattern = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'Enter a valid email address';
    }
    return null;
  }
}
