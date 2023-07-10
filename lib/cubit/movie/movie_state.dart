import '../../model/movie_model.dart';

abstract class MovieState {}

class MovieLoadingState extends MovieState {
  MovieLoadingState();
}

class MovieResponseState extends MovieState {
  List<MovieModel> movieList = [];
  bool isLoadMore;
  MovieResponseState({required this.movieList, required this.isLoadMore});
}

class MovieSearchState extends MovieState {
  List<MovieModel> searchMovieList = [];
  bool isSearching;
  MovieSearchState({
    required this.searchMovieList,
    required this.isSearching,
  });
}

class MovieFailedState extends MovieState {
  final List<MovieModel>? cachedMovieList;
  String errorMessage;
  MovieFailedState({required this.errorMessage, this.cachedMovieList});
}
