// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/cubit/movie/movie_cubit.dart';
import 'package:tmdb_app/cubit/movie/movie_state.dart';
import 'package:tmdb_app/utils/app_string.dart';
import 'package:tmdb_app/widgets/movie_error_widget.dart';
import 'package:tmdb_app/widgets/movie_icon_widget.dart';
import 'package:tmdb_app/widgets/shimmer_widget.dart';
import '../model/movie_model.dart';

class MoviesWidget extends StatelessWidget {
  String? category;
  MoviesWidget({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category ?? '',
                style: theme.textTheme.displayMedium!.copyWith(fontSize: 20),
              ),
              GestureDetector(
                onTap: () {
                  MovieChoice choice =
                      BlocProvider.of<MovieCubit>(context).movieChoice;
                  Navigator.of(context).pushNamed(
                    '/categoryPage',
                    arguments: choice,
                  );
                },
                child: const SizedBox(
                  height: 40,
                  width: 70,
                  child: Card(
                    color: Colors.white,
                    child: Center(
                      child: Text('All'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 240,
          child: BlocBuilder<MovieCubit, MovieState>(
            builder: (context, state) {
              if (state is MovieLoadingState) {
                return const ShimmerWidget(
                  isApplyOnGrid: false,
                );
              } else if (state is MovieResponseState) {
                return state.movieList.isEmpty
                    ? Center(
                        child: showEmptyText(theme.textTheme),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 7,
                        itemBuilder: (_, index) {
                          MovieModel model = state.movieList.elementAt(index);
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    '/detailPage',
                                    arguments: model,
                                  );
                                },
                                child: Container(
                                  height: 200,
                                  width: 150,
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: CachedNetworkImage(
                                    imageUrl: AppString.TMDB_IMAGE_PREFIX +
                                        model.posterPath.toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (_, __) => const Center(
                                      child: MovieIconWidget(),
                                    ),
                                    errorWidget: (_, __, ___) =>
                                        const Icon(Icons.error_rounded),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  model.title.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.displayMedium!
                                      .copyWith(fontSize: 11),
                                ),
                              ),
                            ],
                          );
                        },
                      );
              } else if (state is MovieFailedState) {
                return MovieErrorWidget(
                  message: state.errorMessage,
                  routeName: "/homePage",
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Widget showEmptyText(TextTheme theme) {
    return Text(
      'Data not found',
      style: theme.displayMedium,
    );
  }
}
