import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/cubit/movie/movie_cubit.dart';
import 'package:tmdb_app/cubit/movie/movie_state.dart';
import 'package:tmdb_app/utils/app_string.dart';
import 'package:tmdb_app/widgets/empty_widget.dart';
import 'package:tmdb_app/widgets/movie_icon_widget.dart';
import 'package:tmdb_app/widgets/navigation_button.dart';
import 'package:tmdb_app/widgets/shimmer_widget.dart';

import '../model/movie_model.dart';
import '../widgets/progress_indicator.dart';

class MovieCategoryPage extends StatelessWidget {
  const MovieCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        centerTitle: true,
        leading: const NavigationBackWidget(),
        title: Text(
          context.read<MovieCubit>().movieChoice.name,
          style: theme.textTheme.displayMedium!.copyWith(fontSize: 22),
        ),
      ),
      body: BlocConsumer<MovieCubit, MovieState>(
        listener: (context, state) {
          if (state is MovieFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        bloc: BlocProvider.of<MovieCubit>(context),
        builder: (_, state) {
          if (state is MovieLoadingState) {
            return const ShimmerWidget(isApplyOnGrid: true);
          } else if (state is MovieResponseState) {
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    controller: context.read<MovieCubit>().scrollController,
                    itemCount: state.movieList.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: 0.5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      maxCrossAxisExtent: 200,
                    ),
                    itemBuilder: (_, index) {
                      MovieModel model = state.movieList.elementAt(index);
                      return Column(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                clipBehavior: Clip.antiAlias,
                                child: CachedNetworkImage(
                                  imageUrl: AppString.TMDB_IMAGE_PREFIX +
                                      model.posterPath.toString(),
                                  fit: BoxFit.cover,
                                  placeholder: (_, url) =>
                                      const MovieIconWidget(),
                                  errorWidget: (_, __, ___) => const Center(
                                    child: Icon(Icons.movie),
                                  ),
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
                ),
                if (state.isLoadMore)
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: LoadingIndicator(),
                  ),
              ],
            );
          } else if (state is MovieFailedState) {
            return state.cachedMovieList == null
                ? const MovieNotFoundWidget()
                : Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          controller:
                              context.read<MovieCubit>().scrollController,
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.cachedMovieList?.length,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            childAspectRatio: 0.5,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            maxCrossAxisExtent: 200,
                          ),
                          itemBuilder: (_, index) {
                            MovieModel model =
                                state.cachedMovieList?.elementAt(index) ??
                                    MovieModel();
                            return Column(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      clipBehavior: Clip.antiAlias,
                                      child: CachedNetworkImage(
                                        imageUrl: AppString.TMDB_IMAGE_PREFIX +
                                            model.posterPath.toString(),
                                        fit: BoxFit.cover,
                                        placeholder: (_, url) =>
                                            const MovieIconWidget(),
                                        errorWidget: (_, __, ___) =>
                                            const Center(
                                          child: Icon(Icons.movie),
                                        ),
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
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  model.title ?? "Not found",
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
                      ),
                      MaterialButton(
                        minWidth: 60,
                        height: 25,
                        onPressed: context.read<MovieCubit>().retryToApiCall,
                        color: Colors.white,
                        child: Text(
                          "Retry",
                          style: theme.textTheme.displayMedium!
                              .copyWith(fontSize: 12, color: Colors.blue),
                        ),
                      ),
                    ],
                  );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
