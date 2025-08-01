import 'dart:io';
import 'package:airline_app/services/response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
// import 'package:timesheet_app/services/local.dart';
// import 'package:timesheet_app/services/response.dart';

enum HttpMethod { get, post }

class ApiHelper {
  late Dio client;
  final String baseUrls;
  ApiHelper(this.baseUrls) {
    client = Dio();
    client.options.baseUrl = baseUrls;
    client.options = BaseOptions(validateStatus: (status) {
      return status! < 500 || status == 401;
    });

  }

  Future<HTTPResponse<T>> postmethod<T>(
      {required String url, required HttpMethod method, var parameters}) async {
    var header = {
      "Content-Type": "application/json",
      // "Authorization": LocalService.accesstoken != null
      // ? "Bearer ${LocalService.accesstoken}"
      // : ""
    };
    String methodName = '$method';
    List<String> parts = methodName.split('.');
    String methods = parts[1].toUpperCase();

    if (kDebugMode) {
      print('CALLING API  : ${baseUrls + url}');
      print("METHOD       : $methods");
      print("HEADER       : $header");
      print("PARAMETERS   : $parameters");
    }

    client.options.headers = header;

    try {
      Response response;
      switch (method) {
        case HttpMethod.get:
          response = await client.get(baseUrls + url);
          break;
        case HttpMethod.post:
          response = await client.post(baseUrls + url, data: parameters);
          break;
      }
      if ((response.statusCode! >= 200 && response.statusCode! <= 299)) {
        if (kDebugMode) {
          print("............................................................");
          print('RESPONSE FOR API  : ${baseUrls + url}');
          print('STATUS CODE       : ${response.statusCode}');
          print('DATA              : ${response.data}');
        }
        return HTTPResponse(
            isSuccessfull: true, message: 'success', data: response.data);
      } else {
        if (kDebugMode) {
          print('API HITTING FAILED.....DATA NOT FOUND');
        }
        return HTTPResponse(
            isSuccessfull: false,
            data: response.data,
            message: kDebugMode
                ? getErrorMessage(response.data)
                : 'invalid response please try again later',
            status: response.statusCode);
      }
    } on HttpException {
      if (kDebugMode) {
        print('API HITTING FAILED.....HTTP EXCEPTION');
      }
      return HTTPResponse(isSuccessfull: false, message: 'Couldn\'t find data');
    } on SocketException {
      if (kDebugMode) {
        print('API HITTING FAILED.....SOCKET EXCEPTION');
      }
      return HTTPResponse(
          isSuccessfull: false,
          message: 'unable to reach internet please try again later ');
    } on FormatException {
      if (kDebugMode) {
        print('API HITTING FAILED.....FORMAT EXCEPTION');
      }
      return HTTPResponse(
          isSuccessfull: false,
          message: 'invalid response recieved from server please try again later ');
    } on DioException catch (e) {
      if (e.response!.statusCode! >= 400 && e.response!.statusCode! <= 499) {
        if (kDebugMode) {
          print("............................................................");
          print('RESPONSE FOR API  : ${baseUrls + url}');
          print('STATUS CODE       : ${e.response?.statusCode}');
          print('DATA              : ${e.response?.data}');
        }
        return HTTPResponse(
            isSuccessfull: true, message: 'success', data: e.response?.data);
      } else {
        if (kDebugMode) {
          print('API HITTING FAILED.....DATA NOT FOUND');
        }
        return HTTPResponse(
            isSuccessfull: false,
            message:'Something went wrong please try again later');
      }
    }
  }

  String getErrorMessage(dynamic data) {
    if (data is String) return data;
    if (data is Map && data['message'] is String) return data['message'];
    return 'invalid response please try again later';
  }

}