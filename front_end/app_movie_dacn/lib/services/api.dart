import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<http.Response> signUpUser(Map data) async {
    final url = 'http://127.0.0.1:8000/api/users/create';
    final uri = Uri.parse(url);

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };

    final response = await http.post(
      uri,
      body: jsonEncode(data),
      headers: headers
    );

    return response;
  }

  static Future<http.Response> signInUser(Map data) async {
    final url = 'http://127.0.0.1:8000/api/users/login';
    final uri = Uri.parse(url);
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };

    final response = await http.post(
      uri,
      body: jsonEncode(data),
      headers: headers
    );

    return response;
  }

  static Future<http.Response> getMovieTrending() async {
    final url = 'http://127.0.0.1:8000/api/movies/getTrendingDay';

    final uri = Uri.parse(url);
    final response = await http.get(uri);
    return response;
  }

  static Future<http.Response> getMoviePopular() async {
    final url = 'http://127.0.0.1:8000/api/movies/getPopular';
    final uri = Uri.parse(url);
    final response = http.get(uri);

    return response;
  }

  static Future<http.Response> getMovieNowPlaying() async {
    final url = 'http://127.0.0.1:8000/api/movies/getNowPlaying';
    final uri = Uri.parse(url);
    final response = http.get(uri);

    return response;
  }

  static Future<http.Response> getMovieUpComing() async {
    final url = 'http://127.0.0.1:8000/api/movies/getUpcoming';
    final uri = Uri.parse(url);
    final response = http.get(uri);

    return response;
  }
}