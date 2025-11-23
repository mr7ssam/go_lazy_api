/// Base class for all application errors.
///
/// Each error contains a [message] describing the error
/// and an HTTP [statusCode].
abstract class BaseError {
  const BaseError({
    required this.message,
    required this.statusCode,
  });

  /// Human-readable error message
  final String message;

  /// HTTP status code associated with this error
  final int statusCode;

  @override
  String toString() => '$runtimeType: $message (status: $statusCode)';
}
