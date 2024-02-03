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

  static Future<bool> verifyEmail(String email) async {
    final url = 'http://127.0.0.1:8000/api/users/verify-email/$email';
    final uri = Uri.parse(url);
    final response = await http.post(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if(json['status'] == 'found') return true;
      return false;
    }
    return false;
  }

  static Future<bool> changePass(Map<String, dynamic> data) async {
    final url = 'http://127.0.0.1:8000/api/users/change-pass';

    final uri = Uri.parse(url);
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final response = await http.put(uri, body: jsonEncode(data), headers: headers);

    if(response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print(json['status']);
      if(json['status'] == 'success') return true;
      return false;
    }
    return false;
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

  static Future<http.Response> getShowtime() async {
    final url = 'http://127.0.0.1:8000/api/movies/getShowtime';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    return response;
  }
}