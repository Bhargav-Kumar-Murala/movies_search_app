import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:bhargav_kumar_murala/Model/movie_model.dart';

class ApiService {
  static ApiService? _instance;

  ApiService._();

  static ApiService get getInstance => _instance = _instance ?? ApiService._();
// ------------ Search Movies services ------

  String apiKey = 'e13ee02156abcf4ab5764f591f6492e2';

  Future<List<Search>?> searchMovie(String name) async {
    var request = await http.get(
      Uri.parse(
          "https://api.themoviedb.org/3/search/movie?api_key=$apiKey&language=en-US&query=$name&page=1&include_adult=false"),
    );
    if (request.statusCode == 200) {
      Map res = json.decode(request.body);

      var list = (res['results'] as List)
          .map((item) => Search.fromJson(item))
          .toList();
      return list;
    } else {
      throw Exception('Something went wrong !');
    }
  }
}
