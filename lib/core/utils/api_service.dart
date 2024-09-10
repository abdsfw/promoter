// import 'dart:convert';

import 'package:dio/dio.dart';

import '../constant/constant.dart';
import '../constants.dart';
import 'cash/cache_helper.dart';
// import 'package:http/http.dart' as http;

class ApiService {
  final _baseUrl = baseUrl;
  // final _baseUrl = fakeUrl;
  final Dio dio;

  ApiService(this.dio);
  // Future<Map<String, dynamic>> get({required String endPoint}) async {
  //   Uri url = Uri.parse(_baseUrl + endPoint);
  //   http.Response response = await http.get(url);
  //   var body = jsonDecode(response.body);

  //   return body;
  // }

  Future<Map<String, dynamic>> get(
      {required String endPoint, CancelToken? cancelToken}) async {
    String token = await CasheHelper.getData(key: Constants.ktoken);
    print(token);
    dio.options.headers["Authorization"] = "Bearer $token";
    // dio.options.headers[]
    var response =
        await dio.get('$_baseUrl$endPoint', cancelToken: cancelToken);
    print('-----------------------------------------------------------');
    // print(response.data);
    return response.data;
  }

  Future<Map<String, dynamic>> getWithBody({
    required String endPoint,
    CancelToken? cancelToken,
    required var data,
  }) async {
    String token = await CasheHelper.getData(key: Constants.ktoken);
    print(token);
    dio.options.headers["Authorization"] = "Bearer $token";
    // dio.options.headers[]
    var response = await dio.get('$_baseUrl$endPoint', data: data);
    print('-----------------------------------------------------------');
    // print(response.data);
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    required var data,
    bool isLogin = false,
  }) async {
    String token = await CasheHelper.getData(key: Constants.ktoken);

    dio.options.headers["Authorization"] = "Bearer $token";
    // print('heeeere');
    var response = await dio.post('$_baseUrl$endPoint', data: data);
    // print('55555555555555555555555555555555555');
    // print(
    // '  heeeeeeeeeer resopopsdklfskdlvdl ${response.data} ----------------------------------------\n ---------------------------------------');
    return response.data;
  }

  Future<Map<String, dynamic>> put({
    required String endPoint,
    required var data,
  }) async {
    String token = await CasheHelper.getData(key: Constants.ktoken);

    dio.options.headers["Authorization"] = "Bearer $token";
    // print('heeeere');
    var response = await dio.put('$_baseUrl$endPoint', data: data);
    // print('55555555555555555555555555555555555');
    // print(
    // '  heeeeeeeeeer resopopsdklfskdlvdl ${response.data} ----------------------------------------\n ---------------------------------------');
    return response.data;
  }

  Future<Map<String, dynamic>> delete(
      {required String endPoint, required int id}) async {
    String token = await CasheHelper.getData(key: Constants.ktoken);
    dio.options.headers["Authorization"] = "Bearer $token";
    // headers: {
    //       'Content-Type': 'application/json',
    //     },
    dio.options.headers['Content-Type'] = "application/json";
    var response = await dio.delete('$_baseUrl$endPoint$id');
    return response.data;
  }

  Future<Map<String, dynamic>> deleteMany(
      {required String endPoint, required var data}) async {
    String token = await CasheHelper.getData(key: Constants.ktoken);
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.options.headers['Content-Type'] = "application/json";

    var response = await dio.delete('$_baseUrl$endPoint', data: data);
    return response.data;
  }

}
