import 'dart:convert';

import 'package:http/http.dart' as http;
import 'api_key.dart';

class ExtractTrailerCode {
  Future<String?> extractTrailer(int code) async {
    String baseUrl =
        'https://api.themoviedb.org/3/movie/$code/videos?api_key=${MoviesdbApiKey.apiKey}';
    try {
      final response = await http.get(Uri.parse(baseUrl));
      final result = json.decode(response.body);
      return result['results'][0]['key'];
    } catch (e) {
      print(e);
    }
  }
}
