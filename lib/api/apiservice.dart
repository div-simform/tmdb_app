import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tmdb_app/model/movie_model.dart';
import 'package:tmdb_app/utils/app_string.dart';

import '../model/response/api_response.dart';

part 'apiservice.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET(AppString.TMDB_POPULAR)
  Future<APIResponse<List<MovieModel>>> getPopularMovie(
      @Query('page') String page);

  @GET(AppString.TMDB_TRENDING)
  Future<APIResponse<List<MovieModel>>> getTrendingMovie(
      @Query('page') String page);

  @GET(AppString.TMDB_UPCOMING)
  Future<APIResponse<List<MovieModel>>> getUpcomingMovie(
      @Query('page') String page);

  @GET(AppString.TMDB_SEARCH)
  Future<APIResponse<List<MovieModel>>> getSearchMovie(
      @Query('query') String searchQuery);
}
