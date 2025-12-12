import 'package:complaint_app/core/errors/error_model.dart';
import 'package:dio/dio.dart';

//!ServerException
class ServerException implements Exception {
  final ErrorModel errorModel;
  ServerException(this.errorModel);
}

class CacheException implements Exception {
  final String errorMessage;
  CacheException({required this.errorMessage});
}

class BadCertificateException extends ServerException {
  BadCertificateException(super.errorModel);
}

class ConnectionTimeoutException extends ServerException {
  ConnectionTimeoutException(super.errorModel);
}

class BadResponseException extends ServerException {
  BadResponseException(super.errorModel);
}

class ReceiveTimeoutException extends ServerException {
  ReceiveTimeoutException(super.errorModel);
}

class ConnectionErrorException extends ServerException {
  ConnectionErrorException(super.errorModel);
}

class SendTimeoutException extends ServerException {
  SendTimeoutException(super.errorModel);
}

class UnauthorizedException extends ServerException {
  UnauthorizedException(super.errorModel);
}

class ForbiddenException extends ServerException {
  ForbiddenException(super.errorModel);
}

class NotFoundException extends ServerException {
  NotFoundException(super.errorModel);
}

class CofficientException extends ServerException {
  CofficientException(super.errorModel);
}

class CancelException extends ServerException {
  CancelException(super.errorModel);
}

class UnknownException extends ServerException {
  UnknownException(super.errorModel);
}

class ConflictException extends ServerException {
  ConflictException(super.errorModel);
}

class BadRequestException extends ServerException {
  BadRequestException(super.errorModel);
}

handleDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionError:
      if (e.response != null && e.response!.data != null) {
        throw ConnectionErrorException(ErrorModel.fromJson(e.response!.data));
      }
      throw ConnectionErrorException(
        ErrorModel(
          status: 0,
          errorMessage: 'Connection error: ${e.message ?? "Unknown error"}',
        ),
      );
    case DioExceptionType.badCertificate:
      if (e.response != null && e.response!.data != null) {
        throw BadCertificateException(ErrorModel.fromJson(e.response!.data));
      }
      throw BadCertificateException(
        ErrorModel(
          status: 0,
          errorMessage: 'Bad certificate: ${e.message ?? "Unknown error"}',
        ),
      );
    case DioExceptionType.connectionTimeout:
      if (e.response != null && e.response!.data != null) {
        throw ConnectionTimeoutException(ErrorModel.fromJson(e.response!.data));
      }
      throw ConnectionTimeoutException(
        ErrorModel(
          status: 408,
          errorMessage:
              'Connection timeout: ${e.message ?? "Request timed out"}',
        ),
      );

    case DioExceptionType.receiveTimeout:
      if (e.response != null && e.response!.data != null) {
        throw ReceiveTimeoutException(ErrorModel.fromJson(e.response!.data));
      }
      throw ReceiveTimeoutException(
        ErrorModel(
          status: 408,
          errorMessage: 'Receive timeout: ${e.message ?? "Response timed out"}',
        ),
      );

    case DioExceptionType.sendTimeout:
      if (e.response != null && e.response!.data != null) {
        throw SendTimeoutException(ErrorModel.fromJson(e.response!.data));
      }
      throw SendTimeoutException(
        ErrorModel(
          status: 408,
          errorMessage:
              'Send timeout: ${e.message ?? "Request send timed out"}',
        ),
      );

    case DioExceptionType.badResponse:
      if (e.response == null) {
        throw BadResponseException(
          ErrorModel(status: 500, errorMessage: 'No response from server'),
        );
      }
      switch (e.response?.statusCode) {
        case 400: // Bad request
          throw BadResponseException(ErrorModel.fromJson(e.response!.data));

        case 401: //unauthorized
          throw UnauthorizedException(ErrorModel.fromJson(e.response!.data));

        case 403: //forbidden
          throw ForbiddenException(ErrorModel.fromJson(e.response!.data));

        case 404: //not found
          throw NotFoundException(ErrorModel.fromJson(e.response!.data));

        case 409: //cofficient
          throw CofficientException(ErrorModel.fromJson(e.response!.data));

        case 500: // Internal server error
        case 502: // Bad gateway
        case 503: // Service unavailable
        case 504: // Gateway timeout
        default: // Any other error status code
          throw BadResponseException(ErrorModel.fromJson(e.response!.data));
      }

    case DioExceptionType.cancel:
      throw CancelException(
        ErrorModel(errorMessage: e.toString(), status: 500),
      );

    case DioExceptionType.unknown:
      throw UnknownException(
        ErrorModel(errorMessage: e.toString(), status: 500),
      );
  }
}
