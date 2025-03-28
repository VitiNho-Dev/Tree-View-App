abstract interface class Failure implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const Failure({required this.message, this.stackTrace});
}

final class ApiError extends Failure {
  final int? statusCode;

  const ApiError({required super.message, this.statusCode});
}

final class ClientHttpError extends Failure {
  const ClientHttpError({required super.message, super.stackTrace});
}

final class UnexpectedError extends Failure {
  const UnexpectedError({required super.message, super.stackTrace});
}

final class RepositoryError extends Failure {
  const RepositoryError({required super.message, super.stackTrace});
}
