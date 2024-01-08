import 'package:dio/dio.dart';
import 'failure.dart';
import '../../presentation/resource/strings_manager.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      // dio error so its an error from response of the API or from dio itself
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.defaultCode.getFailure();
    }
  }
}

Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.connectTimeout.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.sendTimeout.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.recieveTimeout.getFailure();
    case DioExceptionType.badCertificate:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return Failure(error.response?.statusCode ?? 0,
            error.response?.statusMessage ?? "");
      } else {
        print('1');
        return DataSource.defaultCode.getFailure();
      }
    case DioExceptionType.badResponse:
      return DataSource.badRequest.getFailure();
    case DioExceptionType.cancel:
      return DataSource.cancel.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.noInternetConnection.getFailure();
    case DioExceptionType.unknown:
      return DataSource.defaultCode.getFailure();
  }
}

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorised,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  recieveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaultCode
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(
            ResponseCode.success, ResponseMessage.success); //  .tr());
      case DataSource.noContent:
        return Failure(
            ResponseCode.noContent, ResponseMessage.noContent); //.tr());
      case DataSource.badRequest:
        return Failure(
            ResponseCode.badRequest, ResponseMessage.badRequest); //.tr());
      case DataSource.forbidden:
        return Failure(
            ResponseCode.forbidden, ResponseMessage.forbidden); //.tr());
      case DataSource.unauthorised:
        return Failure(
            ResponseCode.unauthorised, ResponseMessage.unauthorised); //.tr());
      case DataSource.notFound:
        return Failure(
            ResponseCode.notFound, ResponseMessage.notFound); //.tr());
      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError,
            ResponseMessage.internalServerError); //.tr());
      case DataSource.connectTimeout:
        return Failure(ResponseCode.connectTimeout,
            ResponseMessage.connectTimeout); //.tr());
      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel); //.tr());
      case DataSource.recieveTimeout:
        return Failure(ResponseCode.recieveTimeout,
            ResponseMessage.recieveTimeout); //.tr());
      case DataSource.sendTimeout:
        return Failure(
            ResponseCode.sendTimeout, ResponseMessage.sendTimeout); //.tr());
      case DataSource.cacheError:
        return Failure(
            ResponseCode.cacheError, ResponseMessage.cacheError); //.tr());
      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection); //.tr());
      case DataSource.defaultCode:
        return Failure(
            ResponseCode.defaultCode, ResponseMessage.defaultCode); //.tr());
    }
  }
}

class ResponseCode {
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no data (no content)
  static const int badRequest = 400; // failure, API rejected request
  static const int unauthorised = 401; // failure, user is not authorised
  static const int forbidden = 403; //  failure, API rejected request
  static const int internalServerError = 500; // failure, crash in server side
  static const int notFound = 404; // failure, not found

  // local status code
  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int recieveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int defaultCode = -7;
}

class ResponseMessage {
  static const String success = AppStrings.success; // success with data
  static const String noContent =
      AppStrings.success; // success with no data (no content)
  static const String badRequest =
      AppStrings.badRequestError; // failure, API rejected request
  static const String unauthorised =
      AppStrings.unauthorizedError; // failure, user is not authorised
  static const String forbidden =
      AppStrings.forbiddenError; //  failure, API rejected request
  static const String internalServerError =
      AppStrings.internalServerError; // failure, crash in server side
  static const String notFound =
      AppStrings.notFoundError; // failure, crash in server side

  // local status code
  static const String connectTimeout = AppStrings.timeoutError;
  static const String cancel = AppStrings.defaultError;
  static const String recieveTimeout = AppStrings.timeoutError;
  static const String sendTimeout = AppStrings.timeoutError;
  static const String cacheError = AppStrings.cacheError;
  static const String noInternetConnection = AppStrings.noInternetError;
  static const String defaultCode = AppStrings.defaultError;
}

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}
