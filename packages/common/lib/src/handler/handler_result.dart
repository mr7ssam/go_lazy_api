import 'package:common/src/error/index.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'handler_result.freezed.dart';

/// Represents the result of a handler operation.
///
/// Can be either:
/// - [HandlerResult.success] with response data of type [T]
/// - [HandlerResult.failed] with a [BaseError]
@freezed
class HandlerResult<T> with _$HandlerResult<T> {
  const factory HandlerResult.success({
    required T data,
  }) = _Success<T>;

  const factory HandlerResult.failed({
    required BaseError error,
  }) = _Failed<T>;

  Response toResponse({
    int statusCode = 200,
  }) {
    return when(
      success: (data) => Response.json(
        statusCode: statusCode,
        body: data,
      ),
      failed: (error) => Response(
        statusCode: error.statusCode,
        body: error.message,
      ),
    );
  }
}
