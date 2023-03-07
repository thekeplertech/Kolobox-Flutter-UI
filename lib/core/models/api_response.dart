class ApiResponse {
  bool? status;
  String? message;
  dynamic data;
  int? statusCode;

  ApiResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
    statusCode = json['statusCode'];
  }
}
