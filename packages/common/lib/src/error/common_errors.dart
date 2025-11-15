import 'package:common/src/error/base_error.dart';

/// Error for resource not found scenarios (404)
class NotFoundError extends BaseError {
  NotFoundError({required super.message}) : super(statusCode: 404);
}

/// Error for unauthorized access attempts (401)
class UnauthorizedError extends BaseError {
  UnauthorizedError({required super.message}) : super(statusCode: 401);
}

/// Error for forbidden access to resources (403)
class ForbiddenError extends BaseError {
  ForbiddenError({required super.message}) : super(statusCode: 403);
}

/// Error for conflicts with existing resources (409)
class ConflictError extends BaseError {
  ConflictError({required super.message}) : super(statusCode: 409);
}

/// Error for bad client requests (400)
class BadRequestError extends BaseError {
  BadRequestError({required super.message}) : super(statusCode: 400);
}

/// Error for internal server failures (500)
class InternalServerError extends BaseError {
  InternalServerError({String? message})
      : super(statusCode: 500, message: message ?? 'Internal Server Error');
}

/// Error for validation failures (422)
class ValidationError extends BaseError {
  ValidationError({required super.message}) : super(statusCode: 422);
}
