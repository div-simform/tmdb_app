import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/cubit/movie/movie_cubit.dart';

class MovieNotFoundWidget extends StatelessWidget {
  const MovieNotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Oops Data not found",
            style: theme.textTheme.displayMedium!.copyWith(fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: context.read<MovieCubit>().retryToApiCall,
            color: Colors.white,
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}
