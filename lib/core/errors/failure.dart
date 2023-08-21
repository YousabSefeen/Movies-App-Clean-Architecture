import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(
    super.errorMessage,
  );

  factory ServerFailure.fromDioException({
    required DioException error,
  }) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with ApiServer.');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Connection send timeout with ApiServer.');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Connection receive timeout with ApiServer.');
      case DioExceptionType.badCertificate:
        return ServerFailure('Bad Certificate.');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            error.response!.statusCode, error.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was canceled');
      case DioExceptionType.connectionError:
        return ServerFailure('No internet connection');
      case DioExceptionType.unknown:
        return ServerFailure('An error occurred,Please try again');

      default:
        return ServerFailure('Opps there was an error,Please try again');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure('Your request is not found,Please try later!.');
    } else if (statusCode == 500) {
      return ServerFailure('Internal server error,Please try later!.');
    } else {
      return ServerFailure('Opps there was an error,Please try again');
    }
  }
}
