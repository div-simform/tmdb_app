import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/utils/app_string.dart';

import '../cubit/movie/movie_cubit.dart';
import '../widgets/movie_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: Text(
          AppString.homeText,
          style: theme.textTheme.displayMedium!.copyWith(fontSize: 22),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset('assets/images/tmdb_logo.jpeg'),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('/searchPage'),
            icon: Icon(
              Icons.search,
              color: theme.iconTheme.color,
            ),
          ),
        ],
        centerTitle: true,
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              BlocProvider<MovieCubit>(
                create: (_) => MovieCubit(movieChoice: MovieChoice.Popular),
                child: Center(
                  child: MoviesWidget(
                    category: AppString.POPULAR_TITLE,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              BlocProvider<MovieCubit>(
                create: (_) => MovieCubit(movieChoice: MovieChoice.Trending),
                child: MoviesWidget(
                  category: AppString.TOP_RATED_TITLE,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              BlocProvider<MovieCubit>(
                create: (_) => MovieCubit(movieChoice: MovieChoice.Upcoming),
                child: MoviesWidget(category: AppString.UPCOMING_TITLE),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
