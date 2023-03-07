class Failure {
  Failure(
      {this.message = "Check Internet Connection", this.apiStatus, this.model});

  dynamic model;
  final String? message;
  final int? apiStatus;
}

class InternetConnection extends Failure {
  InternetConnection();
}
