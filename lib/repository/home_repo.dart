import 'package:mvvm_project1/data/network/base_api_service.dart';
import 'package:mvvm_project1/data/network/network_api_service.dart';
import 'package:mvvm_project1/model/movies_model.dart';
import 'package:mvvm_project1/resources/app_url.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  Future<MovieListModel1> movieApi() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.moviesApiEndPoint);
      return response = MovieListModel1.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
