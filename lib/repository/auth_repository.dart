import 'package:mvvm_project1/data/network/base_api_service.dart';
import 'package:mvvm_project1/data/network/network_api_service.dart';
import 'package:mvvm_project1/resources/app_url.dart';

class AuthRespository {
  final BaseApiServices _apiServices = NetworkApiService();
  //post api
  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.loginEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
  //register api

  Future<dynamic> signupApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.registerApiPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
