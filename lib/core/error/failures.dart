import 'package:dio/dio.dart';

abstract class Failure {
  final String errMassage;

  const Failure(this.errMassage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMassage);

  factory ServerFailure.fromDioError(DioException dioException) {
    print('raw error : ${dioException.toString()}');
    print('here we go again');
    if (dioException.type == DioExceptionType.connectionTimeout) {
      print('111');
      return ServerFailure('Connection timeout with ApiServer');
    } else if (dioException.type == DioExceptionType.sendTimeout) {
      print('222');
      return ServerFailure('Send timeout with ApiServer');
    } else if (dioException.type == DioExceptionType.receiveTimeout) {
      print('333');
      return ServerFailure('Receive timeout with ApiServer');
    } else if (dioException.type == DioExceptionType.badResponse) {
      print('444');
      return ServerFailure.fromResponse(
          dioException.response?.statusCode, dioException.response!.data);
    } else if (dioException.type == DioExceptionType.cancel) {
      print('555');
      return ServerFailure('Request to  ApiServer was canceld');
    } else {
      // print(10000);
      // if (dioException.message!.contains('SocketException')) {
      //   print('666');
      //   return ServerFailure('No Internet Connection');
      // }
      print("status code:  ${dioException.response?.statusCode}");
      print('7777');
      return ServerFailure('network error, check your internet !');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    print('statusCode is $statusCode');
    if (statusCode == 400 ||
        statusCode == 401 ||
        statusCode == 403 ||
        statusCode == 422) {
      print(response['data']);
      String error = response['data'];

      return ServerFailure(error);
    } else if (statusCode == 404) {
      return ServerFailure('Your requesst not found, Please try later!');
    } else if (statusCode == 500) {
      return ServerFailure('internal Server error, Please try later');
    } else {
      return ServerFailure('Opps There was an Error, Please try again');
    }
  }
}
