// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/api/server_error.dart';
import 'package:tmdb_app/cubit/movie/movie_state.dart';
import 'package:tmdb_app/debounce/debouce.dart';
import '../../api/repository.dart';
import '../../model/movie_model.dart';

enum MovieChoice {
  Popular,
  Trending,
  Upcoming,
  Search,
}

class MovieCubit extends Cubit<MovieState> {
  List<MovieModel> _movieList = [];
  List<MovieModel> _searchMovieList = [];
  MovieChoice movieChoice;
  int page = 1;
  bool _isLoadingMore = false;

  final _debounce = Debounce(milliseconds: 300);
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  MovieCubit({required this.movieChoice}) : super(MovieLoadingState()) {
    _getMovieList();
    _scrollConfig();
  }

  Future<void> _getMovieList() async {
    try {
      switch (movieChoice) {
        case MovieChoice.Popular:
          _movieList =
              await Repository().getPopularMovieResponse(page: page.toString());
        case MovieChoice.Trending:
          _movieList = await Repository()
              .getTrendingMovieResponse(page: page.toString());
        case MovieChoice.Upcoming:
          _movieList = await Repository()
              .getUpcomingMovieResponse(page: page.toString());
        case MovieChoice.Search:
          return;
      }
      emit(MovieResponseState(movieList: _movieList, isLoadMore: false));
    } catch (e) {
      if (e is DioException) {
        emit(MovieFailedState(
            errorMessage: ServerError.withError(exception: e).getErrorMessage));
      }
    }
  }

  Future<void> _scrollConfig() async {
    scrollController.addListener(
      () {
        final currentScroll = scrollController.position.pixels;
        final maxScroll = scrollController.position.maxScrollExtent;
        if (currentScroll > (maxScroll - 400)) {
          if (!_isLoadingMore) {
            _getMoreMovieList();
            _isLoadingMore = true;
          }
        }
      },
    );
  }

  void _getMoreMovieList() async {
    emit(MovieResponseState(movieList: _movieList, isLoadMore: true));
    try {
      page += 1;
      switch (movieChoice) {
        case MovieChoice.Popular:
          _movieList.addAll(await Repository()
              .getPopularMovieResponse(page: page.toString()));
        case MovieChoice.Trending:
          _movieList.addAll(await Repository()
              .getTrendingMovieResponse(page: page.toString()));

        case MovieChoice.Upcoming:
          _movieList.addAll(await Repository()
              .getUpcomingMovieResponse(page: page.toString()));
        case MovieChoice.Search:
          return;
      }
      emit(MovieResponseState(movieList: _movieList, isLoadMore: false));
      _isLoadingMore = false;
    } catch (e) {
      if (e is DioException) {
        emit(
          MovieFailedState(
              errorMessage: ServerError.withError(exception: e).getErrorMessage,
              cachedMovieList: _movieList),
        );
      }
    }
  }

  void searchMovie({required String searchValue}) {
    emit(MovieSearchState(searchMovieList: [], isSearching: true));
    if (searchValue.isNotEmpty) {
      _debounce.run(
        () async {
          try {
            _searchMovieList = await Repository().getSearchMovieResponse(
                searchData: searchValue.toLowerCase().trim());
            emit(MovieSearchState(
                searchMovieList: _searchMovieList, isSearching: false));
          } catch (e) {
            if (e is DioException) {
              emit(MovieFailedState(
                  errorMessage:
                      ServerError.withError(exception: e).getErrorMessage));
            }
          }
        },
      );
    } else {
      _debounce.cancel();
      _searchMovieList.clear();
      emit(MovieLoadingState());
    }
  }

  Future<void> retryToApiCall() async {
    _movieList.isNotEmpty ? _getMoreMovieList() : _getMovieList();
  }

  void clearTextField() {
    _debounce.cancel();
    searchController.clear();
    emit(MovieLoadingState());
  }

  @override
  Future<void> close() {
    // TODO: implement close
    scrollController.dispose();
    searchController.dispose();
    return super.close();
  }
}
