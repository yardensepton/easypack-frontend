class Validators {
  static bool isEmptyBool(String? value) {
    if (value == null || value.isEmpty || value.trim().isEmpty) {
      return true;
    }
    return false;
  }

  static String? validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty || value.trim().isEmpty) {
      return "$fieldName can't be empty";
    }
    return null;
  }

  static String? validateEmailPattern(String? value) {
    validateNotEmpty(value, 'email');
    // Regex for email validation
    const pattern = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validatePasswordStrength(String? password) {
    // Check for minimum length of 5 characters
    if (password!.length < 5) {
      return "Password needs to be at least 5 characters long";
    }

    // Check for at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return "Password needs to contain at least one uppercase letter";
    }

    // Check for at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) {
      return "Password needs to contain at least one lowercase letter";
    }

    // Check for at least one digit
    if (!password.contains(RegExp(r'[0-9]'))) {
      return "Password needs to contain at least one digit";
    }

    // If all checks pass, return true
    return null;
  }
}
