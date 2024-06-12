class ServerError {

  String getErrorMsg(Map<String, dynamic> errorData) {
    return errorData['detail'] ?? '';
  }
}
