class ServerError {

  static String getErrorMsg(Map<String, dynamic> errorData) {
    return errorData['detail'] ?? '';
  }
}
