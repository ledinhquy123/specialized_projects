import 'package:http/http.dart' as http;

class MovieApi {
static Future<http.Response> getMovieTrending() async {
    final url = 'http://127.0.0.1:8000/api/movies/getTrendingDay';

    final uri = Uri.parse(url);
    final response = await http.get(uri);
    return response;
  }

  static Future<http.Response> getMoviePopular() async {
    final url = 'http://127.0.0.1:8000/api/movies/getPopular';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    return response;
  }

  static Future<http.Response> getMovieNowPlaying() async {
    final url = 'http://127.0.0.1:8000/api/movies/getNowPlaying';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    return response;
  }

  static Future<http.Response> getMovieUpComing() async {
    final url = 'http://127.0.0.1:8000/api/movies/getUpcoming';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    return response;
  }

  static Future<http.Response> getMovieName() async {
    final url = 'http://127.0.0.1:8000/api/movies/getSearchMovie';
    final uri = Uri.parse(url);

    final response = await http.get(uri);
    return response;
  }

  static Future<http.Response> getActors(String id) async {
    final url = 'http://127.0.0.1:8000/api/movies/getActor/$id';
    final uri = Uri.parse(url);

    final response = await http.get(uri);
    return response;
  }

  static Future<http.Response> getWeekday() async {
    final url = 'http://127.0.0.1:8000/api/movies/getWeekday';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    return response;
  }

  static Future<http.Response> getShowtime(String weekdayId) async {
    final url = 'http://127.0.0.1:8000/api/movies/getShowtime/$weekdayId';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    return response;
  }
}