import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/movie/movie_cubit.dart';
import '../cubit/movie/movie_state.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<MovieCubit>();
    return TextField(
      style: theme.textTheme.displayMedium!.copyWith(fontSize: 15),
      textInputAction: TextInputAction.search,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        label: Text(
          'Search',
          style: theme.textTheme.displayMedium!.copyWith(fontSize: 15),
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.white,
        ),
        suffixIcon: BlocSelector<MovieCubit, MovieState, bool>(
          selector: (state) => state is MovieSearchState ? true : false,
          builder: (_, state) {
            return state
                ? IconButton(
                    onPressed: cubit.clearTextField,
                    icon: Icon(
                      Icons.clear,
                      color: theme.iconTheme.color,
                    ),
                  )
                : const SizedBox();
          },
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      cursorColor: Colors.white,
      controller: cubit.searchController,
      onChanged: (value) => cubit.searchMovie(searchValue: value),
    );
  }
}
