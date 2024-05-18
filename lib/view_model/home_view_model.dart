import 'package:flutter/foundation.dart';
import 'package:mvvm_project1/data/response/api_response.dart';
import 'package:mvvm_project1/model/movies_model.dart';
import 'package:mvvm_project1/repository/home_repo.dart';

class HomeViewviewModel with ChangeNotifier {
  final _myrepo = HomeRepository();
  ApiResponse<MovieListModel1> moviesList = ApiResponse.loading();
  setMoviesList(ApiResponse<MovieListModel1> response) {
    moviesList = response;
    notifyListeners();
  }

  Future<void> fetchMoviesListApi() async {
    setMoviesList(ApiResponse.loading());
    _myrepo.movieApi().then((value) {
      setMoviesList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setMoviesList(ApiResponse.error(error.toString()));
    });
  }
}
