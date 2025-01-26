abstract interface class Error implements Exception {
  final String message;

  const Error({this.message = 'Error'});
}

final class HttpException implements Error {
  @override
  final String message;
  final int? statusCode;

  const HttpException(
    this.message, {
    this.statusCode,
  });
}
