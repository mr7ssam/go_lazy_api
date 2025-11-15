import 'package:common/src/handler/handler_result.dart';

/// Interface for all handlers in the application.
///
/// Each handler processes a request of type [TRequest] and returns
/// a [HandlerResult] containing a response of type [TResponse].
///
/// Type parameters:
/// - [TRequest]: The type of the request object
/// - [TResponse]: The type of the response data
// ignore: one_member_abstracts
abstract class IHandler<TRequest, TResponse> {
  /// Handles the request and returns a result.
  ///
  /// Returns [HandlerResult.success] with [TResponse] data on success,
  /// or [HandlerResult.failed] with an error on failure.
  Future<HandlerResult<TResponse>> handle(TRequest request);
}
