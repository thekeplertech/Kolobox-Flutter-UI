class Failure {
  Failure(
      {this.message = "Check Internet Connection", this.apiStatus, this.model});

  dynamic model;
  String? message;
  final int? apiStatus;
}

class InternetConnection extends Failure {
  InternetConnection();
}
