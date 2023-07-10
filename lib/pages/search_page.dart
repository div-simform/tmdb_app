// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/cubit/movie/movie_cubit.dart';
import 'package:tmdb_app/cubit/movie/movie_state.dart';
import 'package:tmdb_app/widgets/custom_textfield.dart';
import 'package:tmdb_app/widgets/movie_error_widget.dart';
import 'package:tmdb_app/widgets/navigation_button.dart';
import 'package:tmdb_app/widgets/progress_indicator.dart';

import '../model/movie_model.dart';
import '../utils/app_string.dart';
import '../widgets/movie_icon_widget.dart';

class MovieSearchPage extends StatelessWidget {
  const MovieSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: const NavigationBackWidget(),
        title: Text(
          'Search Movie',
          style: theme.textTheme.displayMedium!.copyWith(fontSize: 20),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: const CustomSearchTextField(),
          ),
          BlocBuilder<MovieCubit, MovieState>(
            builder: (context, state) {
              if (state is MovieFailedState) {
                return Expanded(
                  child: MovieErrorWidget(
                    message: state.errorMessage,
                    routeName: "/searchPage",
                  ),
                );
              } else if (state is MovieSearchState) {
                return state.isSearching
                    ? const Expanded(child: Center(child: LoadingIndicator()))
                    : Expanded(
                        child: state.searchMovieList.isEmpty
                            ? Center(
                                child: Text(
                                  'No Movie Found',
                                  style: theme.textTheme.displayMedium!
                                      .copyWith(fontSize: 15),
                                ),
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(8),
                                controller:
                                    context.read<MovieCubit>().scrollController,
                                physics: const BouncingScrollPhysics(),
                                itemCount: state.searchMovieList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  childAspectRatio: 0.5,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  maxCrossAxisExtent: 200,
                                ),
                                itemBuilder: (_, index) {
                                  MovieModel model =
                                      state.searchMovieList.elementAt(index);
                                  return Column(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          clipBehavior: Clip.antiAlias,
                                          child: GestureDetector(
                                            child: CachedNetworkImage(
                                              imageUrl: AppString
                                                      .TMDB_IMAGE_PREFIX +
                                                  model.posterPath.toString(),
                                              fit: BoxFit.cover,
                                              placeholder: (_, url) =>
                                                  const MovieIconWidget(),
                                              errorWidget: (_, __, ___) =>
                                                  const Center(
                                                child: Icon(Icons.movie),
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                '/detailPage',
                                                arguments: model,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        model.title.toString(),
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: theme.textTheme.displayMedium!
                                            .copyWith(fontSize: 11),
                                      ),
                                    ],
                                  );
                                },
                              ),
                      );
              }
              return Expanded(
                child: Center(
                  child: Text(
                    'Search any movie',
                    style:
                        theme.textTheme.displayMedium!.copyWith(fontSize: 15),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
