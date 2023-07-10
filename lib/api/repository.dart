import 'package:dio/dio.dart';
import 'package:tmdb_app/api/apiservice.dart';
import 'package:tmdb_app/interceptor/custom_interceptor.dart';
import 'package:tmdb_app/utils/app_string.dart';
import '../model/movie_model.dart';

class Repository {
  late Dio _dio;
  Repository._initializer() {
    _dio = Dio(
      BaseOptions(
        headers: AppString.TMDB_HEADERS,
      ),
    );
    _dio.interceptors.add(CustomInterceptor());
  }
  static final Repository _apiService = Repository._initializer();
  factory Repository() => _apiService;

  Future<List<MovieModel>> getPopularMovieResponse(
      {required String page}) async {
    final response = await ApiService(_dio, baseUrl: AppString.TMDB_URL)
        .getPopularMovie(page);
    return response.data!;
  }

  Future<List<MovieModel>> getTrendingMovieResponse(
      {required String page}) async {
    final response = await ApiService(_dio, baseUrl: AppString.TMDB_URL)
        .getTrendingMovie(page);
    return response.data!;
  }

  Future<List<MovieModel>> getUpcomingMovieResponse(
      {required String page}) async {
    final response = await ApiService(_dio, baseUrl: AppString.TMDB_URL)
        .getUpcomingMovie(page);

    return response.data!;
  }

  Future<List<MovieModel>> getSearchMovieResponse(
      {required String searchData}) async {
    final response = await ApiService(_dio, baseUrl: AppString.TMDB_SEARCH_URL)
        .getSearchMovie(searchData);

    return response.data!;
  }
}
