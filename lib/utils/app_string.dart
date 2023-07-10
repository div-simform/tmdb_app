// ignore_for_file: constant_identifier_names

class AppString {
  static const String homeText = "Home";
  static const String homeTitle = "TMDB Application";
  static const String errorPageText = "Page not found";

  static const String TMDB_URL = "https://api.themoviedb.org/3/movie/";
  static const String TMDB_SEARCH_URL = "https://api.themoviedb.org/3/search/";
  static const String TMDB_API_KEY = "b8d4f35254d6e35a0e0ee0f096c00796";
  static const String TMDB_IMAGE_PREFIX = "https://image.tmdb.org/t/p/original";

  static const String TMDB_LOGO_URL =
      "https://pbs.twimg.com/profile_images/1243623122089041920/gVZIvphd_400x400.jpg";
  static const Map<String, dynamic> TMDB_HEADERS = {
    "accept": "application/json",
    "Authorization":
        "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiOGQ0ZjM1MjU0ZDZlMzVhMGUwZWUwZjA5NmMwMDc5NiIsInN1YiI6IjY0OWE2YTE1N2UzNDgzMDExYzIyNTAwOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.kz0H4a4f_5h8ZniQ4zulO9Cj8HBdl-lr4fnVxJGUTL8"
  };

  static const String POPULAR_TITLE = "Popular";
  static const String TOP_RATED_TITLE = "Trending";
  static const String UPCOMING_TITLE = "Upcoming";

  static const String TMDB_POPULAR = "popular";
  static const String TMDB_TRENDING = "top_rated";
  static const String TMDB_UPCOMING = "upcoming";
  static const String TMDB_SEARCH = "movie";

  static const String CONNECTED = "Connected to internet";
  static const String CONNECTION_LOST = "No internet connection";
}
