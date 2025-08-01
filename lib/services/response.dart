class HTTPResponse<T> {
  bool isSuccessfull;
  T? data;
  String message;
  int? status;
  HTTPResponse(
      {required this.isSuccessfull,
      this.data,
      required this.message,
      this.status});
}