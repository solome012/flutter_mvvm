import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm_project1/data/network/base_api_service.dart';
import 'package:mvvm_project1/data/response/app_exception.dart';

class NetworkApiService extends BaseApiServices {
  //get api response
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    return responseJson;
  }

//post api response
  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;

    try {
      final response = await http
          .post(
            Uri.parse(url),
            body: data,
          )
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    } catch (e) {
      debugPrint(e.toString());
    }
    return responseJson;
  }
}

dynamic returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      dynamic responseJson = jsonDecode(response.body);

      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 404:
      throw UnauthorizedException(response.body.toString());

    default:
      throw FetchDataException(
          'Error accured while communicating with server with status code${response.statusCode.toString()}');
  }
}
