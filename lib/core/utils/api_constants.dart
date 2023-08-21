class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = '?api_key=4a6ccbbbec448a14a2a114fffae85f15';
  static const String nowPlayingMoviesPath =
      '$baseUrl/movie/now_playing$apiKey';
  static const String popularMoviesPath = '$baseUrl/movie/popular$apiKey';
  static const String topRatedMoviesPath = '$baseUrl/movie/top_rated$apiKey';

  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';

  static String imageUrl(String pathImageUrl) => '$baseImageUrl$pathImageUrl';

  static String movieDetailsPath(int movieID) =>
      '$baseUrl/movie/$movieID$apiKey';

  static String recommendationPath(int movieID) =>
      '$baseUrl/movie/$movieID/recommendations$apiKey';

  static const String upComingMoviesPath = '$baseUrl/movie/upcoming$apiKey';
}
