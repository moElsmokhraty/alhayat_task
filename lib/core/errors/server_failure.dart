import 'failure.dart';
import 'package:dio/dio.dart';

class ServerFailure extends Failure {
  ServerFailure({required String errMessage}) : super(errMessage);

  factory ServerFailure.fromException(Exception e) {
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.cancel:
          return ServerFailure(errMessage: "Request to server was cancelled");
        case DioExceptionType.connectionError:
          return ServerFailure(
            errMessage:
                "Connection to server failed due to internet connection",
          );
        case DioExceptionType.connectionTimeout:
          return ServerFailure(errMessage: "Connection timeout with server");
        case DioExceptionType.receiveTimeout:
          return ServerFailure(
            errMessage: "Receive timeout in connection with server",
          );
        case DioExceptionType.sendTimeout:
          return ServerFailure(
            errMessage: "Send timeout in connection with server",
          );
        case DioExceptionType.badCertificate:
          return ServerFailure(
            errMessage: "Bad certificate in connection with server",
          );
        case DioExceptionType.badResponse:
          return ServerFailure._fromResponse(e.response);
        default:
          return ServerFailure(
            errMessage:
                "Oops, Unexpected Error Occurred, Please try again later",
          );
      }
    } else {
      return ServerFailure(errMessage: e.toString());
    }
  }

  factory ServerFailure._fromResponse(Response? response) {
    final statusCode = response?.statusCode!;
    var responseData = response?.data!;
    String errorMessage =
        'Oops, Unexpected Error Occurred, Please try again later';

    if (response == null) {
      return ServerFailure(errMessage: errorMessage);
    }
    if (responseData is String) {
      errorMessage = responseData;
    } else if (responseData.containsKey('errors')) {
      final errors = responseData['errors'];
      errorMessage = errors[errors.keys.first];
    } else {
      switch (statusCode) {
        case 404:
          errorMessage = 'Your request was not found, Please try again later';
          break;
        case 500:
          errorMessage = 'Internal server error, please try again later';
          break;
        case 503:
          errorMessage = 'Service Unavailable, please try again later';
          break;
        case 400:
          errorMessage = 'Bad request, please try again later';
          break;
        case 401:
          errorMessage = 'Unauthorized, please try again later';
          break;
        case 402:
          errorMessage = 'Payment required, please try again later';
          break;
        case 403:
          errorMessage = errorMessage.isNotEmpty
              ? errorMessage
              : "An error occurred while processing your request";
          break;
        default:
          break;
      }
    }
    if (errorMessage.isEmpty) {
      errorMessage = 'Oops, Unknown Error Occurred, Please try again later';
    }
    return ServerFailure(errMessage: errorMessage);
  }
}
