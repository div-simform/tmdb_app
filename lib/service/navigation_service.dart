import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/cubit/movie/movie_cubit.dart';
import 'package:tmdb_app/model/movie_model.dart';
import 'package:tmdb_app/pages/detail_page.dart';
import 'package:tmdb_app/pages/home_page.dart';
import 'package:tmdb_app/pages/category_page.dart';
import 'package:tmdb_app/utils/app_nav_name.dart';
import 'package:tmdb_app/utils/app_string.dart';
import 'package:tmdb_app/widgets/navigation_button.dart';

import '../cubit/splash/splash_cubit.dart';
import '../pages/search_page.dart';
import '../pages/splash_screen.dart';

class NavigationService {
  Route<MaterialPageRoute> generatedRoutes(RouteSettings settings) {
    switch (settings.name) {
      case AppNavPath.splashPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SplashCubit(),
            child: const SplashScreen(),
          ),
        );
      case AppNavPath.homePage:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case AppNavPath.categoryPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                MovieCubit(movieChoice: settings.arguments as MovieChoice),
            child: const MovieCategoryPage(),
          ),
        );
      case AppNavPath.searchPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                MovieCubit(movieChoice: MovieChoice.Search),
            child: const MovieSearchPage(),
          ),
        );
      case AppNavPath.detailPage:
        return MaterialPageRoute(
          builder: (_) => const DetailPage(),
          settings: RouteSettings(arguments: settings.arguments as MovieModel),
        );
      default:
        return errorRoute();
    }
  }

  Route<MaterialPageRoute> errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        final theme = Theme.of(context).textTheme;
        return Scaffold(
          appBar: AppBar(
            leading: const NavigationBackWidget(),
          ),
          body: Center(
            child: Text(
              AppString.errorPageText,
              style: theme.displayMedium!.copyWith(
                fontSize: 15,
              ),
            ),
          ),
        );
      },
    );
  }
}
