class ErrorModel {
  final int status;
  final String errorMessage;

  ErrorModel({required this.status, required this.errorMessage});
  factory ErrorModel.fromJson(Map jsonData) {
    return ErrorModel(
      errorMessage: jsonData["message"],
      status: int.tryParse(jsonData["status"].toString()) ?? 0,
    );
  }
}
