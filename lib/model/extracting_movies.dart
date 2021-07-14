import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_key.dart';

class OverviewMovies {
  int movieId;
  String poster;
  double voteAvg;
  String releaseDate;
  bool adult;
  String overview;
  int voteCount;
  double popularity;
  String originalTitle;

  OverviewMovies(
      this.movieId,
      this.originalTitle,
      this.poster,
      this.adult,
      this.overview,
      this.popularity,
      this.releaseDate,
      this.voteAvg,
      this.voteCount);
}

class ExtractingTopRatedMovies {
  Future<List<OverviewMovies>?> extractMovies() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/top_rated?api_key=${MoviesdbApiKey.apiKey}'));
      final result = json.decode(response.body) as Map<String, dynamic>;
      List<dynamic> topRated = result['results'].take(10).toList();

      final extractedMovies = topRated
          .map((e) => OverviewMovies(
                e['id'],
                e['original_title'],
                e['poster_path'],
                e['adult'],
                e['overview'],
                e['popularity'],
                e['release_date'],
                e['vote_average'],
                e['vote_count'],
              ))
          .toList();

      return extractedMovies;
    } catch (e) {
      print(e);
    }
  }
}
